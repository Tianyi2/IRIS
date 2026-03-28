"""
Static analysis tool wrappers for Infrastructure as Code (IaC) templates.

Supports:
  - cfn-lint      (CloudFormation)
  - tflint        (Terraform)
  - trivy         (CloudFormation, Terraform, ARM/Bicep via misc-config)
  - checkov       (CloudFormation, Terraform, ARM, Bicep)
  - terraform validate (Terraform)
  - arm-ttk       (ARM)
  - bicep-linter  (Bicep)

Each wrapper returns a standardised result dict:
  {
    "tool":        str,
    "file":        str,
    "iac_type":    str,
    "return_code": int,
    "issues":      list[dict],   # parsed findings (where possible)
    "raw_stdout":  str,
    "raw_stderr":  str,
    "duration_s":  float,
    "error":       str | None,   # set only when the tool itself fails to run
  }
"""

from __future__ import annotations

import csv
import json
import os
import re
import shutil
import subprocess
import tempfile
import time
from pathlib import Path
from typing import Any, Dict, List, Optional

try:
    from evaluation.static_analysis_tools.test_tf import (
        run_tflint_on_group,
        run_terraform_validate_on_group,
    )
except ModuleNotFoundError:
    from test_tf import (
        run_tflint_on_group,
        run_terraform_validate_on_group,
    )


# ---------------------------------------------------------------------------
# Path helpers
# ---------------------------------------------------------------------------
PROJECT_ROOT = Path(__file__).resolve().parent.parent.parent
TOOLS_DIR = PROJECT_ROOT / "tools"
VENV_SCRIPTS = PROJECT_ROOT / ".venv" / "Scripts"

CFN_LINT_EXE = VENV_SCRIPTS / "cfn-lint.exe"
CHECKOV_CMD = VENV_SCRIPTS / "checkov.cmd"
TFLINT_EXE = TOOLS_DIR / "tflint.exe"
TRIVY_EXE = TOOLS_DIR / "trivy.exe"
ARM_TTK_DIR = TOOLS_DIR / "arm-ttk" / "arm-ttk"
ARM_TTK_MODULE = ARM_TTK_DIR / "arm-ttk.psd1"
_ARM_TTK_UNBLOCKED = False
ARM_TTK_SKIP_TESTS = [
    # This built-in test can trigger web requests and interactive prompts.
    "apiVersions*",
]

IAC_TYPE_MAP = {
    ".yaml": "cloudformation",
    ".yml": "cloudformation",
    ".json": "arm",
    ".tf": "terraform",
    ".bicep": "bicep",
}


def detect_iac_type(file_path: str) -> str:
    """Return one of: cloudformation, terraform, arm, bicep, unknown."""
    ext = Path(file_path).suffix.lower()
    if ext in (".yaml", ".yml"):
        try:
            with open(file_path, "r", encoding="utf-8") as f:
                head = f.read(2048)
            if "AWSTemplateFormatVersion" in head or "aws" in head.lower():
                return "cloudformation"
        except Exception:
            pass
        return "cloudformation"
    return IAC_TYPE_MAP.get(ext, "unknown")


def _base_result(tool: str, file_path: str, iac_type: str) -> Dict[str, Any]:
    return {
        "tool": tool,
        "file": str(file_path),
        "iac_type": iac_type,
        "return_code": -1,
        "issues": [],
        "raw_stdout": "",
        "raw_stderr": "",
        "duration_s": 0.0,
        "error": None,
    }


def _run_cmd(
    cmd: List[str],
    cwd: Optional[str] = None,
    timeout: int = 120,
    input_text: Optional[str] = None,
) -> tuple[int, str, str]:
    """Run a command, return (returncode, stdout, stderr)."""
    proc = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
        cwd=cwd,
        timeout=timeout,
        input=input_text,
    )
    return proc.returncode, proc.stdout or "", proc.stderr or ""


def _arm_ttk_ps_preamble() -> str:
    """
    Build a PowerShell preamble for non-interactive ARM-TTK execution.
    """
    return (
        "$ConfirmPreference='None'; "
        "$ProgressPreference='SilentlyContinue'; "
        "$PSDefaultParameterValues['*:Confirm'] = $false; "
        "if ($PSVersionTable.PSVersion.Major -le 5) { "
        "Set-ItemProperty -Path 'HKCU:\\Software\\Microsoft\\Internet Explorer\\Main' "
        "-Name 'DisableFirstRunCustomize' -Value 2 -ErrorAction SilentlyContinue; "
        "$PSDefaultParameterValues['Invoke-WebRequest:UseBasicParsing'] = $true; "
        "$PSDefaultParameterValues['Invoke-RestMethod:UseBasicParsing'] = $true; "
        "function global:Invoke-WebRequest { "
        "param([Parameter(ValueFromRemainingArguments=$true)]$Args) "
        "Microsoft.PowerShell.Utility\\Invoke-WebRequest @Args -UseBasicParsing -Confirm:$false "
        "}; "
        "function global:Invoke-RestMethod { "
        "param([Parameter(ValueFromRemainingArguments=$true)]$Args) "
        "Microsoft.PowerShell.Utility\\Invoke-RestMethod @Args -UseBasicParsing -Confirm:$false "
        "}; "
        "}; "
    )


def _extract_json_payload(text: str, begin_marker: str, end_marker: str) -> Optional[str]:
    """Extract JSON payload between markers, with object/array fallback."""
    if not text:
        return None

    start = text.find(begin_marker)
    end = text.find(end_marker, start + len(begin_marker)) if start != -1 else -1
    if start != -1 and end != -1 and end > start:
        payload = text[start + len(begin_marker):end].strip()
        if payload:
            return payload

    decoder = json.JSONDecoder()
    for idx, ch in enumerate(text):
        if ch not in "[{":
            continue
        try:
            _, consumed = decoder.raw_decode(text[idx:])
            return text[idx: idx + consumed]
        except json.JSONDecodeError:
            continue
    return None


def _ensure_arm_ttk_unblocked(shell: str) -> Optional[str]:
    """
    Best-effort one-time unblock for ARM-TTK scripts/modules on Windows.
    Returns an error string if the unblock command fails, else None.
    """
    global _ARM_TTK_UNBLOCKED
    if _ARM_TTK_UNBLOCKED:
        return None

    ttk_dir = str(ARM_TTK_DIR).replace("'", "''")
    ps_script = (
        _arm_ttk_ps_preamble() +
        "$ErrorActionPreference='Stop'; "
        "if (Get-Command Unblock-File -ErrorAction SilentlyContinue) { "
        f"Get-ChildItem -Path '{ttk_dir}' -Include *.ps1,*.psd1,*.ps1xml,*.psm1 -Recurse -File "
        "| Unblock-File -ErrorAction SilentlyContinue; "
        "}"
    )
    try:
        rc, stdout, stderr = _run_cmd(
            [shell, "-NoProfile", "-NonInteractive", "-Command", ps_script],
            timeout=180,
            input_text="A\n" * 200,
        )
        if rc != 0:
            return (stderr or stdout or "Failed to unblock ARM-TTK files").strip()
        _ARM_TTK_UNBLOCKED = True
        return None
    except Exception as err:
        return f"Failed to unblock ARM-TTK files: {err}"


# ---------------------------------------------------------------------------
# cfn-lint  (CloudFormation)
# ---------------------------------------------------------------------------
def run_cfn_lint(file_path: str, iac_type: Optional[str] = None) -> Dict[str, Any]:
    """
    Run cfn-lint on a CloudFormation template.
    Returns JSON-formatted findings.
    """
    iac_type = iac_type or "cloudformation"
    result = _base_result("cfn-lint", file_path, iac_type)

    exe = str(CFN_LINT_EXE)
    if not CFN_LINT_EXE.exists():
        exe = shutil.which("cfn-lint") or "cfn-lint"

    cmd = [exe, "--format", "json", "--", str(file_path)]

    start = time.perf_counter()
    try:
        rc, stdout, stderr = _run_cmd(cmd)
        result["return_code"] = rc
        result["raw_stdout"] = stdout
        result["raw_stderr"] = stderr

        if stdout and stdout.strip():
            findings = json.loads(stdout)
            result["issues"] = [
                {
                    "id": f.get("Rule", {}).get("Id", ""),
                    "message": f.get("Message", ""),
                    "level": f.get("Level", ""),
                    "location": f"L{f.get('Location', {}).get('Start', {}).get('LineNumber', '?')}",
                }
                for f in findings
            ]
    except subprocess.TimeoutExpired:
        result["error"] = "cfn-lint timed out"
    except FileNotFoundError:
        result["error"] = "cfn-lint executable not found"
    except json.JSONDecodeError:
        result["error"] = "Failed to parse cfn-lint JSON output"
    finally:
        result["duration_s"] = round(time.perf_counter() - start, 3)

    return result


# ---------------------------------------------------------------------------
# tflint  (Terraform)
# ---------------------------------------------------------------------------
def run_tflint(file_path: str, iac_type: Optional[str] = None) -> Dict[str, Any]:
    """
    Run tflint on a Terraform file.
    tflint works on directories, so we copy the target file to a temp dir.
    """
    iac_type = iac_type or "terraform"
    result = _base_result("tflint", file_path, iac_type)

    exe = str(TFLINT_EXE)
    if not TFLINT_EXE.exists():
        exe = shutil.which("tflint") or "tflint"

    tmp_dir = tempfile.mkdtemp(prefix="tflint_")
    try:
        src = Path(file_path).resolve()
        dst = Path(tmp_dir) / src.name
        shutil.copy2(src, dst)

        cmd = [exe, "--format", "json", "--force"]
        start = time.perf_counter()
        try:
            rc, stdout, stderr = _run_cmd(cmd, cwd=tmp_dir)
            result["return_code"] = rc
            result["raw_stdout"] = stdout
            result["raw_stderr"] = stderr

            if stdout and stdout.strip():
                data = json.loads(stdout)
                for issue in data.get("issues", []):
                    result["issues"].append({
                        "id": issue.get("rule", {}).get("name", ""),
                        "message": issue.get("message", ""),
                        "level": issue.get("rule", {}).get("severity", ""),
                        "location": f"L{issue.get('range', {}).get('start', {}).get('line', '?')}",
                    })
                for err in data.get("errors", []):
                    result["issues"].append({
                        "id": "tflint-error",
                        "message": err.get("message", str(err)),
                        "level": "error",
                        "location": "",
                    })
        except subprocess.TimeoutExpired:
            result["error"] = "tflint timed out"
        except FileNotFoundError:
            result["error"] = "tflint executable not found"
        except json.JSONDecodeError:
            result["error"] = "Failed to parse tflint JSON output"
        finally:
            result["duration_s"] = round(time.perf_counter() - start, 3)
    finally:
        shutil.rmtree(tmp_dir, ignore_errors=True)

    return result


# ---------------------------------------------------------------------------
# trivy  (multi-IaC)
# ---------------------------------------------------------------------------
def run_trivy(file_path: str, iac_type: Optional[str] = None) -> Dict[str, Any]:
    """
    Run trivy config scan on an IaC file.
    Supports CloudFormation, Terraform, ARM, Bicep (via misconfig scanner).
    """
    iac_type = iac_type or IAC_TYPE_MAP.get(Path(file_path).suffix.lower(), "unknown")
    result = _base_result("trivy", file_path, iac_type)

    exe = str(TRIVY_EXE)
    if not TRIVY_EXE.exists():
        exe = shutil.which("trivy") or "trivy"

    cmd = [
        exe, "config",
        "--format", "json",
        "--quiet",
        str(file_path),
    ]

    start = time.perf_counter()
    try:
        rc, stdout, stderr = _run_cmd(cmd, timeout=180)
        result["return_code"] = rc
        result["raw_stdout"] = stdout
        result["raw_stderr"] = stderr

        if rc != 0 and "No module named 'checkov'" in (stderr or ""):
            result["error"] = (
                "checkov launcher exists but checkov module is missing in this environment. "
                "Use a dedicated static-analysis virtual environment and reinstall checkov."
            )
            return result

        if stdout and stdout.strip():
            data = json.loads(stdout)
            results_list = data if isinstance(data, list) else data.get("Results", [])
            for res_block in results_list:
                for vuln in res_block.get("Misconfigurations", []) or []:
                    result["issues"].append({
                        "id": vuln.get("ID", ""),
                        "message": vuln.get("Message", vuln.get("Title", "")),
                        "level": vuln.get("Severity", ""),
                        "location": vuln.get("CauseMetadata", {}).get("StartLine", ""),
                    })
    except subprocess.TimeoutExpired:
        result["error"] = "trivy timed out"
    except FileNotFoundError:
        result["error"] = "trivy executable not found"
    except json.JSONDecodeError:
        result["error"] = "Failed to parse trivy JSON output"
    finally:
        result["duration_s"] = round(time.perf_counter() - start, 3)

    return result


# ---------------------------------------------------------------------------
# checkov  (multi-IaC)
# ---------------------------------------------------------------------------
def run_checkov(file_path: str, iac_type: Optional[str] = None) -> Dict[str, Any]:
    """
    Run checkov on an IaC file.
    Supports CloudFormation, Terraform, ARM, Bicep.
    """
    iac_type = iac_type or IAC_TYPE_MAP.get(Path(file_path).suffix.lower(), "unknown")
    result = _base_result("checkov", file_path, iac_type)

    framework_map = {
        "cloudformation": "cloudformation",
        "terraform": "terraform",
        "arm": "arm",
        "bicep": "bicep",
    }
    fw = framework_map.get(iac_type)
    if not fw:
        result["error"] = f"checkov: unsupported IaC type '{iac_type}'"
        return result

    exe = str(CHECKOV_CMD)
    if not CHECKOV_CMD.exists():
        exe = shutil.which("checkov") or "checkov"

    cmd = [
        exe,
        "--file", str(file_path),
        "--framework", fw,
        "--output", "json",
        "--compact",
        "--quiet",
    ]

    start = time.perf_counter()
    try:
        rc, stdout, stderr = _run_cmd(cmd, timeout=180)
        result["return_code"] = rc
        result["raw_stdout"] = stdout
        result["raw_stderr"] = stderr

        if stdout and stdout.strip():
            data = json.loads(stdout)
            check_results = []
            if isinstance(data, list):
                for block in data:
                    check_results.extend(
                        block.get("results", {}).get("failed_checks", [])
                    )
            elif isinstance(data, dict):
                check_results = data.get("results", {}).get("failed_checks", [])

            for chk in check_results:
                loc_lines = chk.get("file_line_range", [])
                loc_str = f"L{loc_lines[0]}-L{loc_lines[1]}" if len(loc_lines) >= 2 else ""
                result["issues"].append({
                    "id": chk.get("check_id", ""),
                    "message": chk.get("check_name", ""),
                    "level": chk.get("severity", chk.get("check_result", {}).get("result", "")),
                    "location": loc_str,
                })
    except subprocess.TimeoutExpired:
        result["error"] = "checkov timed out"
    except FileNotFoundError:
        result["error"] = "checkov executable not found"
    except json.JSONDecodeError:
        result["error"] = "Failed to parse checkov JSON output"
    finally:
        result["duration_s"] = round(time.perf_counter() - start, 3)

    return result


# ---------------------------------------------------------------------------
# terraform validate  (Terraform only)
# ---------------------------------------------------------------------------
def run_terraform_validate(file_path: str, iac_type: Optional[str] = None) -> Dict[str, Any]:
    """
    Run 'terraform init -backend=false' then 'terraform validate -json'
    in a temporary directory containing the target .tf file.
    """
    iac_type = iac_type or "terraform"
    result = _base_result("terraform-validate", file_path, iac_type)

    tf_exe = shutil.which("terraform")
    if not tf_exe:
        result["error"] = "terraform executable not found on PATH"
        return result

    tmp_dir = tempfile.mkdtemp(prefix="tfvalidate_")
    try:
        src = Path(file_path).resolve()
        dst = Path(tmp_dir) / src.name
        shutil.copy2(src, dst)

        start = time.perf_counter()
        try:
            _run_cmd([tf_exe, "init", "-backend=false", "-no-color"], cwd=tmp_dir, timeout=60)

            rc, stdout, stderr = _run_cmd(
                [tf_exe, "validate", "-json", "-no-color"], cwd=tmp_dir
            )
            result["return_code"] = rc
            result["raw_stdout"] = stdout
            result["raw_stderr"] = stderr

            if stdout and stdout.strip():
                data = json.loads(stdout)
                result["return_code"] = 0 if data.get("valid", False) else 1
                for diag in data.get("diagnostics", []):
                    rng = diag.get("range", {}) or {}
                    start_line = rng.get("start", {}).get("line", "?")
                    result["issues"].append({
                        "id": diag.get("summary", ""),
                        "message": diag.get("detail", ""),
                        "level": diag.get("severity", "error"),
                        "location": f"L{start_line}",
                    })
        except subprocess.TimeoutExpired:
            result["error"] = "terraform validate timed out"
        except FileNotFoundError:
            result["error"] = "terraform executable not found"
        except json.JSONDecodeError:
            result["error"] = "Failed to parse terraform validate JSON output"
        finally:
            result["duration_s"] = round(time.perf_counter() - start, 3)
    finally:
        shutil.rmtree(tmp_dir, ignore_errors=True)

    return result


# ---------------------------------------------------------------------------
# arm-ttk  (ARM only)
# ---------------------------------------------------------------------------
def run_arm_ttk(file_path: str, iac_type: Optional[str] = None) -> Dict[str, Any]:
    """
    Run ARM-TTK (Test-AzTemplate) against an ARM template and parse failed tests.
    """
    iac_type = iac_type or "arm"
    result = _base_result("arm-ttk", file_path, iac_type)

    shell = shutil.which("pwsh") or shutil.which("powershell")
    if not shell:
        result["error"] = "PowerShell (pwsh/powershell) executable not found"
        return result
    if not ARM_TTK_MODULE.exists():
        result["error"] = f"ARM-TTK module not found: {ARM_TTK_MODULE}"
        return result

    unblock_error = _ensure_arm_ttk_unblocked(shell)
    if unblock_error:
        result["error"] = unblock_error
        return result

    module_path = str(ARM_TTK_MODULE).replace("'", "''")
    target_path = str(file_path).replace("'", "''")
    begin_marker = "__ARM_TTK_JSON_BEGIN__"
    end_marker = "__ARM_TTK_JSON_END__"
    skip_tests_ps = ",".join([f"'{t}'" for t in ARM_TTK_SKIP_TESTS])
    ps_script = (
        _arm_ttk_ps_preamble() +
        "$ErrorActionPreference='Stop'; "
        f"Import-Module '{module_path}' -Force; "
        "$ErrorActionPreference='Continue'; "
        "$errs = @(); "
        f"$skipTests = @({skip_tests_ps}); "
        f"$results = @(Test-AzTemplate -TemplatePath '{target_path}' -Skip $skipTests -ErrorVariable +errs -ErrorAction Continue); "
        "$simpleResults = @($results | ForEach-Object { "
        "$fileName = ''; "
        "if ($_.File) { "
        "try { $fileName = [string]$_.File.Name } catch { $fileName = [string]$_.File } "
        "}; "
        "[PSCustomObject]@{ "
        "Name=[string]$_.Name; "
        "Passed=[bool]$_.Passed; "
        "Errors=@($_.Errors | ForEach-Object { [string]$_ }); "
        "FileName=$fileName "
        "} "
        "}); "
        "$payload = [PSCustomObject]@{results=$simpleResults; errors=@($errs | ForEach-Object { [string]$_ })}; "
        f"Write-Output '{begin_marker}'; "
        "$payload | ConvertTo-Json -Depth 25 -Compress; "
        f"Write-Output '{end_marker}'"
    )

    start = time.perf_counter()
    try:
        rc, stdout, stderr = _run_cmd(
            [shell, "-NoProfile", "-NonInteractive", "-Command", ps_script],
            timeout=300,
            input_text="A\n" * 200,
        )
        result["return_code"] = rc
        result["raw_stdout"] = stdout
        result["raw_stderr"] = stderr

        payload = _extract_json_payload(stdout, begin_marker, end_marker)
        if payload:
            parsed = json.loads(payload)
            envelope_errors: List[str] = []
            if isinstance(parsed, dict) and "results" in parsed:
                entries = parsed.get("results", []) or []
                raw_errs = parsed.get("errors", []) or []
                envelope_errors = [str(e).strip() for e in raw_errs if str(e).strip()]
            else:
                entries = parsed if isinstance(parsed, list) else [parsed]
            for item in entries:
                if not isinstance(item, dict):
                    continue
                passed = bool(item.get("Passed", True))
                if passed:
                    continue
                name = str(item.get("Name", "")).strip()
                errors = item.get("Errors", [])
                if isinstance(errors, list):
                    err_msgs = [
                        str(e.get("Exception", e)).strip()
                        if isinstance(e, dict) else str(e).strip()
                        for e in errors
                    ]
                    msg = " | ".join([m for m in err_msgs if m]) or "ARM-TTK test failed"
                else:
                    msg = str(errors).strip() or "ARM-TTK test failed"
                file_name = str(item.get("FileName", "") or "")
                result["issues"].append(
                    {
                        "id": name,
                        "message": msg,
                        "level": "error",
                        "location": "",
                        "file": file_name,
                    }
                )
            if envelope_errors and not result["issues"] and rc != 0:
                result["error"] = " | ".join(envelope_errors[:5])
        elif rc != 0:
            err_excerpt = (stderr or "").strip()
            if err_excerpt:
                result["error"] = f"arm-ttk failed and no JSON payload was found in output: {err_excerpt[:300]}"
            else:
                result["error"] = "arm-ttk failed and no JSON payload was found in output"
    except subprocess.TimeoutExpired:
        result["error"] = "arm-ttk timed out"
    except FileNotFoundError:
        result["error"] = "PowerShell executable not found"
    except json.JSONDecodeError:
        result["error"] = "Failed to parse ARM-TTK JSON output"
    finally:
        result["duration_s"] = round(time.perf_counter() - start, 3)

    return result


_BICEP_DIAG_RE = re.compile(
    r"^(?P<file>.+?)\((?P<line>\d+),(?P<col>\d+)\)\s*:\s*(?P<level>Warning|Error)\s+(?P<code>[A-Za-z0-9_-]+):\s*(?P<message>.*?)(?:\s+\[https?://[^\]]+\])?\s*$",
    flags=re.IGNORECASE,
)


# ---------------------------------------------------------------------------
# bicep-linter  (Bicep only)
# ---------------------------------------------------------------------------
def run_bicep_linter(file_path: str, iac_type: Optional[str] = None) -> Dict[str, Any]:
    """
    Run Bicep CLI diagnostics (via bicep build / az bicep build) and parse issues.
    """
    iac_type = iac_type or "bicep"
    result = _base_result("bicep-linter", file_path, iac_type)

    bicep_exe = shutil.which("bicep")
    az_exe = shutil.which("az")

    if bicep_exe:
        cmd = [bicep_exe, "build", str(file_path), "--stdout"]
    elif az_exe:
        cmd = [az_exe, "bicep", "build", "--file", str(file_path)]
    else:
        result["error"] = "Neither bicep CLI nor Azure CLI found"
        return result

    start = time.perf_counter()
    try:
        rc, stdout, stderr = _run_cmd(cmd, timeout=240)
        result["return_code"] = rc
        result["raw_stdout"] = stdout
        result["raw_stderr"] = stderr

        combined_lines = []
        if stdout:
            combined_lines.extend(stdout.splitlines())
        if stderr:
            combined_lines.extend(stderr.splitlines())

        for line in combined_lines:
            m = _BICEP_DIAG_RE.match(line.strip())
            if not m:
                continue
            line_no = int(m.group("line"))
            col_no = int(m.group("col"))
            result["issues"].append(
                {
                    "id": m.group("code"),
                    "message": m.group("message").strip(),
                    "level": m.group("level").lower(),
                    "location": f"L{line_no}:C{col_no}",
                    "file": m.group("file"),
                }
            )

        if rc != 0 and not result["issues"]:
            result["error"] = "bicep linter/build failed with unparsable diagnostics"
    except subprocess.TimeoutExpired:
        result["error"] = "bicep linter timed out"
    except FileNotFoundError:
        result["error"] = "bicep/az executable not found"
    finally:
        result["duration_s"] = round(time.perf_counter() - start, 3)

    return result


# ---------------------------------------------------------------------------
# Aggregation / comparison
# ---------------------------------------------------------------------------
TOOL_REGISTRY: Dict[str, Dict[str, Any]] = {
    "cfn-lint": {
        "fn": run_cfn_lint,
        "supports": {"cloudformation"},
    },
    "tflint": {
        "fn": run_tflint,
        "supports": {"terraform"},
    },
    "trivy": {
        "fn": run_trivy,
        "supports": {"cloudformation", "terraform", "arm", "bicep"},
    },
    "checkov": {
        "fn": run_checkov,
        "supports": {"cloudformation", "terraform", "arm", "bicep"},
    },
    "terraform-validate": {
        "fn": run_terraform_validate,
        "supports": {"terraform"},
    },
    "arm-ttk": {
        "fn": run_arm_ttk,
        "supports": {"arm"},
    },
    "bicep-linter": {
        "fn": run_bicep_linter,
        "supports": {"bicep"},
    },
}


def run_all_tools(
    file_path: str,
    tools: Optional[List[str]] = None,
) -> Dict[str, Any]:
    """
    Run every applicable static analysis tool on *file_path* and return a
    combined report comparing their results.

    Parameters
    ----------
    file_path : str
        Path to the IaC template.
    tools : list[str] | None
        Restrict to specific tool names (keys of TOOL_REGISTRY).
        None means "run all applicable tools".

    Returns
    -------
    dict with keys:
      - file, iac_type
      - tool_results: {tool_name: result_dict}
      - comparison: summary table comparing issue counts / ids
    """
    file_path = str(Path(file_path).resolve())
    iac_type = detect_iac_type(file_path)

    report: Dict[str, Any] = {
        "file": file_path,
        "iac_type": iac_type,
        "tool_results": {},
        "comparison": {},
    }

    selected = tools or list(TOOL_REGISTRY.keys())

    for name in selected:
        entry = TOOL_REGISTRY.get(name)
        if entry is None:
            report["tool_results"][name] = {"error": f"Unknown tool '{name}'"}
            continue
        if iac_type not in entry["supports"]:
            report["tool_results"][name] = {
                "error": f"{name} does not support '{iac_type}'"
            }
            continue
        report["tool_results"][name] = entry["fn"](file_path, iac_type=iac_type)

    comparison: Dict[str, Any] = {}
    for name, res in report["tool_results"].items():
        if isinstance(res, dict) and "issues" in res:
            issues = res["issues"]
            comparison[name] = {
                "issue_count": len(issues),
                "issue_ids": sorted({i.get("id", "") for i in issues}),
                "levels": _count_levels(issues),
                "duration_s": res.get("duration_s", 0),
                "error": res.get("error"),
            }
        else:
            comparison[name] = {"error": res.get("error", "no result")}

    report["comparison"] = comparison
    return report


def _count_levels(issues: List[Dict]) -> Dict[str, int]:
    counts: Dict[str, int] = {}
    for i in issues:
        lvl = str(i.get("level", "unknown")).lower()
        counts[lvl] = counts.get(lvl, 0) + 1
    return counts


# ---------------------------------------------------------------------------
# Pretty-print helper
# ---------------------------------------------------------------------------
def print_report(report: Dict[str, Any]) -> None:
    """Print a human-readable summary of a run_all_tools report."""
    print(f"\n{'='*72}")
    print(f"File     : {report['file']}")
    print(f"IaC type : {report['iac_type']}")
    print(f"{'='*72}")

    for tool_name, summary in report.get("comparison", {}).items():
        err = summary.get("error")
        if err:
            print(f"\n  [{tool_name}]  ERROR: {err}")
            continue
        print(f"\n  [{tool_name}]  issues={summary['issue_count']}  "
              f"duration={summary['duration_s']:.2f}s")
        if summary.get("levels"):
            print(f"    levels : {summary['levels']}")
        if summary.get("issue_ids"):
            for iid in summary["issue_ids"][:15]:
                print(f"      - {iid}")
            if len(summary["issue_ids"]) > 15:
                print(f"      ... and {len(summary['issue_ids']) - 15} more")

    print(f"\n{'='*72}\n")


# ---------------------------------------------------------------------------
# Batch CSV processing
# ---------------------------------------------------------------------------
STATIC_TOOLS_DIR = Path(__file__).resolve().parent
DEFAULT_EXTRACTED_TF_CSV = STATIC_TOOLS_DIR / "extracted_test_cases_tf.csv"
DEFAULT_OUTPUT_CSV = STATIC_TOOLS_DIR / "static_analysis_tool_results.csv"
DEFAULT_MANUAL_REVIEW_CSV = STATIC_TOOLS_DIR / "static_analysis_manual_review_results.csv"
DEFAULT_ARM_TTK_TEMPLATES_DIR = ARM_TTK_DIR / "templates"
DEFAULT_ARM_TTK_MANUAL_REVIEW_CSV = STATIC_TOOLS_DIR / "result" / "manual_review_results_arm_ttk_templates.csv"


def _resolve_template_path(template_path: str) -> str:
    """
    Resolve template_path from CSV (may be pipe-separated for multi-file).
    Returns the path to pass to run_all_tools: first file, resolved relative to PROJECT_ROOT.
    """
    if not template_path or not str(template_path).strip():
        return ""
    paths = [p.strip() for p in str(template_path).split("|") if p.strip()]
    if not paths:
        return ""
    first = paths[0]
    # Normalize path separators and resolve relative to project root
    resolved = PROJECT_ROOT / first.replace("\\", "/")
    return str(resolved.resolve())


def _resolve_template_paths(template_path: str) -> List[str]:
    """
    Resolve all file paths from CSV template_path (pipe-separated supported).
    """
    if not template_path or not str(template_path).strip():
        return []
    paths = [p.strip() for p in str(template_path).split("|") if p.strip()]
    resolved_paths: List[str] = []
    for p in paths:
        resolved = PROJECT_ROOT / p.replace("\\", "/")
        resolved_paths.append(str(resolved.resolve()))
    return resolved_paths


def _aggregate_group_results(tool_name: str, results: List[Dict[str, Any]], iac_type: str) -> Dict[str, Any]:
    """
    Aggregate per-file tool results into one group-level result dict.
    """
    agg: Dict[str, Any] = {
        "tool": tool_name,
        "file": "",
        "iac_type": iac_type,
        "return_code": 0,
        "issues": [],
        "raw_stdout": "",
        "raw_stderr": "",
        "duration_s": 0.0,
        "error": None,
    }
    errors: List[str] = []
    for res in results:
        agg["issues"].extend(res.get("issues", []) or [])
        agg["raw_stdout"] += (res.get("raw_stdout", "") or "") + "\n"
        agg["raw_stderr"] += (res.get("raw_stderr", "") or "") + "\n"
        agg["duration_s"] += float(res.get("duration_s", 0.0) or 0.0)
        agg["return_code"] = max(int(agg["return_code"]), int(res.get("return_code", 0) or 0))
        if res.get("error"):
            errors.append(str(res.get("error")))
    agg["duration_s"] = round(float(agg["duration_s"]), 3)
    if errors:
        agg["error"] = " | ".join(sorted(set(errors)))
    return agg


def run_checkov_on_group(group_files: List[str], iac_type: str = "terraform") -> Dict[str, Any]:
    """
    Run checkov on all files in a Terraform group and aggregate results.
    """
    per_file_results = [run_checkov(fp, iac_type=iac_type) for fp in group_files]
    return _aggregate_group_results("checkov", per_file_results, iac_type)


def run_static_analysis_on_csv(
    input_csv: Optional[Path] = None,
    output_csv: Optional[Path] = None,
    tools: Optional[List[str]] = None,
) -> Path:
    """
    Read a CSV of test cases, run static analysis on each template, and save results.

    For each row, gets the template path from the "template_path" column
    (pipe-separated paths use the first file), runs all applicable static analysis
    tools, and appends result columns for each tool.

    Parameters
    ----------
    input_csv : Path | None
        Path to input CSV (e.g. extracted_test_cases_tf.csv). Defaults to
        tests/static_analysis_tools/extracted_test_cases_tf.csv.
    output_csv : Path | None
        Path for output CSV. Defaults to
        tests/static_analysis_tools/static_analysis_tool_results.csv.
    tools : list[str] | None
        Restrict to specific tools. None = all applicable tools.

    Returns
    -------
    Path
        Path to the output CSV file.
    """
    input_csv = input_csv or DEFAULT_EXTRACTED_TF_CSV
    output_csv = output_csv or DEFAULT_OUTPUT_CSV

    tool_names = tools or list(TOOL_REGISTRY.keys())
    result_columns = []
    for name in tool_names:
        result_columns.extend([
            f"{name}_issue_count",
            f"{name}_error",
            f"{name}_raw_stdout",
            f"{name}_duration_s",
        ])

    rows_out: List[Dict[str, Any]] = []

    with open(input_csv, "r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        input_fieldnames = list(reader.fieldnames or [])

        try:
            for row in reader:
                template_path = row.get("template_path", "")
                resolved = _resolve_template_path(template_path)

                if not resolved or not Path(resolved).exists():
                    for name in tool_names:
                        row[f"{name}_issue_count"] = ""
                        row[f"{name}_error"] = "File not found or invalid path"
                        row[f"{name}_duration_s"] = ""
                    rows_out.append(row)
                    continue

                report = run_all_tools(resolved, tools=tool_names)

                for name in tool_names:
                    res = report.get("tool_results", {}).get(name, {})
                    if isinstance(res, dict) and "issues" in res:
                        row[f"{name}_issue_count"] = len(res.get("issues", []))
                        row[f"{name}_error"] = res.get("error", "") or ""
                        row[f"{name}_raw_stdout"] = res.get("raw_stdout", "")
                        row[f"{name}_duration_s"] = res.get("duration_s", 0)
                    else:
                        row[f"{name}_issue_count"] = ""
                        row[f"{name}_error"] = res.get("error", "no result") or ""
                        row[f"{name}_raw_stdout"] = res.get("raw_stdout", "")
                        row[f"{name}_duration_s"] = ""

                rows_out.append(row)
        except Exception as e:
            print(f"Error processing row: {row} with error: {e}")

    output_fieldnames = input_fieldnames + result_columns
    output_csv.parent.mkdir(parents=True, exist_ok=True)

    with open(output_csv, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=output_fieldnames, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows_out)

    return output_csv


def run_static_analysis_manual_review_on_csv(
    input_csv: Optional[Path] = None,
    output_csv: Optional[Path] = None,
    tools: Optional[List[str]] = None,
    include_raw_output: bool = False,
) -> Path:
    """
    Produce a manual-review friendly output with one row per issue.

    This function is intended for human validation of tool correctness.
    Each output row stores:
      - template metadata (name/path/language if available)
      - tool metadata (tool, iac_type, return_code, duration, error)
      - issue-level details (id/message/level/location + issue JSON)

    Notes
    -----
    - iac_type is taken from the input CSV's "template_language" column.
    - Tools are filtered by this iac_type using TOOL_REGISTRY supports.
    - If a tool emits no issues, one placeholder row is still written with
      issue_status = "no_issue" so clean cases can be reviewed too.

    Parameters
    ----------
    input_csv : Path | None
        Input CSV containing at least a 'template_path' column.
    output_csv : Path | None
        Output CSV for manual review.
    tools : list[str] | None
        Tool names to run. None = all tools in TOOL_REGISTRY.
    include_raw_output : bool
        If True, include raw stdout/stderr in output rows.

    Returns
    -------
    Path
        Output CSV path.
    """
    input_csv = input_csv or DEFAULT_EXTRACTED_TF_CSV
    output_csv = output_csv or DEFAULT_MANUAL_REVIEW_CSV
    tool_names = tools or list(TOOL_REGISTRY.keys())

    rows_out: List[Dict[str, Any]] = []

    with open(input_csv, "r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            template_path_raw = row.get("template_path", "")
            resolved = _resolve_template_path(template_path_raw)
            iac_type = str(row.get("template_language", "") or "").strip().lower()

            base_info = {
                "template_name": row.get("template_name", ""),
                "template_language": row.get("template_language", ""),
                "template_path": template_path_raw,
                "resolved_template_path": resolved,
                "iac_type": iac_type,
            }

            if not resolved or not Path(resolved).exists():
                for tool_name in tool_names:
                    rows_out.append({
                        **base_info,
                        "tool": tool_name,
                        "return_code": "",
                        "duration_s": "",
                        "issue_count": 0,
                        "issue_index": "",
                        "issue_id": "",
                        "issue_message": "",
                        "issue_level": "",
                        "issue_location": "",
                        "issue_json": "",
                        "issue_status": "error",
                        "error": "File not found or invalid path",
                        "raw_stdout": "" if include_raw_output else None,
                        "raw_stderr": "" if include_raw_output else None,
                    })
                continue

            for tool_name in tool_names:
                entry = TOOL_REGISTRY.get(tool_name, {})
                supports = set(entry.get("supports", set()))
                if iac_type and iac_type not in supports:
                    rows_out.append({
                        **base_info,
                        "tool": tool_name,
                        "return_code": "",
                        "duration_s": "",
                        "issue_count": 0,
                        "issue_index": "",
                        "issue_id": "",
                        "issue_message": "",
                        "issue_level": "",
                        "issue_location": "",
                        "issue_json": "",
                        "issue_status": "unsupported",
                        "error": f"{tool_name} does not support '{iac_type}'",
                        "raw_stdout": "" if include_raw_output else None,
                        "raw_stderr": "" if include_raw_output else None,
                    })
                    continue

                fn = entry.get("fn")
                if not callable(fn):
                    rows_out.append({
                        **base_info,
                        "tool": tool_name,
                        "return_code": "",
                        "duration_s": "",
                        "issue_count": 0,
                        "issue_index": "",
                        "issue_id": "",
                        "issue_message": "",
                        "issue_level": "",
                        "issue_location": "",
                        "issue_json": "",
                        "issue_status": "error",
                        "error": f"Tool function not found for '{tool_name}'",
                        "raw_stdout": "" if include_raw_output else None,
                        "raw_stderr": "" if include_raw_output else None,
                    })
                    continue

                res = fn(resolved, iac_type=iac_type)
                if not isinstance(res, dict):
                    res = {"error": f"Unexpected result for tool '{tool_name}'", "issues": []}

                issues = res.get("issues", []) if isinstance(res.get("issues", []), list) else []
                issue_count = len(issues)

                if issue_count == 0:
                    out_row = {
                        **base_info,
                        "tool": tool_name,
                        "return_code": res.get("return_code", ""),
                        "duration_s": res.get("duration_s", ""),
                        "issue_count": 0,
                        "issue_index": "",
                        "issue_id": "",
                        "issue_message": "",
                        "issue_level": "",
                        "issue_location": "",
                        "issue_json": "",
                        "issue_status": "error" if (res.get("error") or "") else "no_issue",
                        "error": res.get("error", "") or "",
                    }
                    if include_raw_output:
                        out_row["raw_stdout"] = res.get("raw_stdout", "")
                        out_row["raw_stderr"] = res.get("raw_stderr", "")
                    rows_out.append(out_row)
                    continue

                for idx, issue in enumerate(issues, start=1):
                    issue = issue if isinstance(issue, dict) else {"message": str(issue)}
                    out_row = {
                        **base_info,
                        "tool": tool_name,
                        "return_code": res.get("return_code", ""),
                        "duration_s": res.get("duration_s", ""),
                        "issue_count": issue_count,
                        "issue_index": idx,
                        "issue_id": issue.get("id", ""),
                        "issue_message": issue.get("message", ""),
                        "issue_level": issue.get("level", ""),
                        "issue_location": issue.get("location", ""),
                        "issue_json": json.dumps(issue, ensure_ascii=False),
                        "issue_status": "issue",
                        "error": res.get("error", "") or "",
                    }
                    if include_raw_output:
                        out_row["raw_stdout"] = res.get("raw_stdout", "")
                        out_row["raw_stderr"] = res.get("raw_stderr", "")
                    rows_out.append(out_row)

    output_csv.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = [
        "template_name",
        "template_language",
        "template_path",
        "resolved_template_path",
        "tool",
        "iac_type",
        "return_code",
        "duration_s",
        "issue_count",
        "issue_index",
        "issue_id",
        "issue_message",
        "issue_level",
        "issue_location",
        "issue_json",
        "issue_status",
        "error",
    ]
    if include_raw_output:
        fieldnames.extend(["raw_stdout", "raw_stderr"])

    with open(output_csv, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows_out)

    return output_csv


def run_arm_ttk_manual_review_on_templates_folder(
    templates_dir: Optional[Path] = None,
    output_csv: Optional[Path] = None,
    include_raw_output: bool = False,
    recursive: bool = True,
    max_templates: Optional[int] = None,
) -> Path:
    """
    Run ARM-TTK over all templates in a folder and export issue-level review CSV.

    Before iteration, executes:
      - Get-ChildItem *.ps1, *.psd1, *.ps1xml, *.psm1 -Recurse | Unblock-File
      - Import-Module .\\arm-ttk.psd1

    Output schema is aligned with run_static_analysis_manual_review_on_csv
    (one row per issue + no_issue/error rows).
    """
    templates_dir = templates_dir or DEFAULT_ARM_TTK_TEMPLATES_DIR
    output_csv = output_csv or DEFAULT_ARM_TTK_MANUAL_REVIEW_CSV
    templates_dir = templates_dir if templates_dir.is_absolute() else (PROJECT_ROOT / templates_dir)
    output_csv = output_csv if output_csv.is_absolute() else (PROJECT_ROOT / output_csv)

    rows_out: List[Dict[str, Any]] = []

    shell = shutil.which("pwsh") or shutil.which("powershell")
    if not shell:
        rows_out.append({
            "template_name": "",
            "template_language": "arm",
            "template_path": "",
            "resolved_template_path": "",
            "tool": "arm-ttk",
            "iac_type": "arm",
            "return_code": "",
            "duration_s": "",
            "issue_count": 0,
            "issue_index": "",
            "issue_id": "",
            "issue_message": "",
            "issue_level": "",
            "issue_location": "",
            "issue_json": "",
            "issue_status": "error",
            "error": "PowerShell (pwsh/powershell) executable not found",
            "raw_stdout": "" if include_raw_output else None,
            "raw_stderr": "" if include_raw_output else None,
        })
    elif not ARM_TTK_MODULE.exists():
        rows_out.append({
            "template_name": "",
            "template_language": "arm",
            "template_path": "",
            "resolved_template_path": "",
            "tool": "arm-ttk",
            "iac_type": "arm",
            "return_code": "",
            "duration_s": "",
            "issue_count": 0,
            "issue_index": "",
            "issue_id": "",
            "issue_message": "",
            "issue_level": "",
            "issue_location": "",
            "issue_json": "",
            "issue_status": "error",
            "error": f"ARM-TTK module not found: {ARM_TTK_MODULE}",
            "raw_stdout": "" if include_raw_output else None,
            "raw_stderr": "" if include_raw_output else None,
        })
    else:
        # Run the required activation commands exactly once before iteration.
        prep_script = (
            "Get-ChildItem *.ps1, *.psd1, *.ps1xml, *.psm1 -Recurse | Unblock-File; "
            "Import-Module .\\arm-ttk.psd1 -Force"
        )
        prep_rc, prep_stdout, prep_stderr = _run_cmd(
            [shell, "-NoProfile", "-NonInteractive", "-Command", prep_script],
            cwd=str(ARM_TTK_DIR),
            timeout=300,
            input_text="A\n" * 200,
        )
        prep_error = ""
        if prep_rc != 0:
            prep_error = (
                "ARM-TTK activation commands failed before iteration. "
                + (prep_stderr or prep_stdout or "")
            ).strip()

        file_iter = templates_dir.rglob("*.json") if recursive else templates_dir.glob("*.json")
        template_files = sorted([p.resolve() for p in file_iter if p.is_file()])
        if max_templates is not None and max_templates >= 0:
            template_files = template_files[:max_templates]

        if not template_files:
            rows_out.append({
                "template_name": "",
                "template_language": "arm",
                "template_path": str(templates_dir),
                "resolved_template_path": str(templates_dir),
                "tool": "arm-ttk",
                "iac_type": "arm",
                "return_code": "",
                "duration_s": "",
                "issue_count": 0,
                "issue_index": "",
                "issue_id": "",
                "issue_message": "",
                "issue_level": "",
                "issue_location": "",
                "issue_json": "",
                "issue_status": "error",
                "error": prep_error or f"No JSON templates found in: {templates_dir}",
                "raw_stdout": prep_stdout if include_raw_output else None,
                "raw_stderr": prep_stderr if include_raw_output else None,
            })
        else:
            for template_file in template_files:
                base_info = {
                    "template_name": template_file.name,
                    "template_language": "arm",
                    "template_path": str(template_file),
                    "resolved_template_path": str(template_file),
                    "iac_type": "arm",
                }

                res = run_arm_ttk(str(template_file), iac_type="arm")
                if prep_error and not res.get("error"):
                    res["error"] = prep_error

                issues = res.get("issues", []) if isinstance(res.get("issues", []), list) else []
                issue_count = len(issues)

                if issue_count == 0:
                    out_row = {
                        **base_info,
                        "tool": "arm-ttk",
                        "return_code": res.get("return_code", ""),
                        "duration_s": res.get("duration_s", ""),
                        "issue_count": 0,
                        "issue_index": "",
                        "issue_id": "",
                        "issue_message": "",
                        "issue_level": "",
                        "issue_location": "",
                        "issue_json": "",
                        "issue_status": "error" if (res.get("error") or "") else "no_issue",
                        "error": res.get("error", "") or "",
                    }
                    if include_raw_output:
                        out_row["raw_stdout"] = res.get("raw_stdout", "")
                        out_row["raw_stderr"] = res.get("raw_stderr", "")
                    rows_out.append(out_row)
                    continue

                for idx, issue in enumerate(issues, start=1):
                    issue = issue if isinstance(issue, dict) else {"message": str(issue)}
                    out_row = {
                        **base_info,
                        "tool": "arm-ttk",
                        "return_code": res.get("return_code", ""),
                        "duration_s": res.get("duration_s", ""),
                        "issue_count": issue_count,
                        "issue_index": idx,
                        "issue_id": issue.get("id", ""),
                        "issue_message": issue.get("message", ""),
                        "issue_level": issue.get("level", ""),
                        "issue_location": issue.get("location", ""),
                        "issue_json": json.dumps(issue, ensure_ascii=False),
                        "issue_status": "issue",
                        "error": res.get("error", "") or "",
                    }
                    if include_raw_output:
                        out_row["raw_stdout"] = res.get("raw_stdout", "")
                        out_row["raw_stderr"] = res.get("raw_stderr", "")
                    rows_out.append(out_row)

    output_csv.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = [
        "template_name",
        "template_language",
        "template_path",
        "resolved_template_path",
        "tool",
        "iac_type",
        "return_code",
        "duration_s",
        "issue_count",
        "issue_index",
        "issue_id",
        "issue_message",
        "issue_level",
        "issue_location",
        "issue_json",
        "issue_status",
        "error",
    ]
    if include_raw_output:
        fieldnames.extend(["raw_stdout", "raw_stderr"])

    with open(output_csv, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows_out)

    return output_csv


def run_static_analysis_manual_review_on_csv_with_group_support(
    input_csv: Optional[Path] = None,
    output_csv: Optional[Path] = None,
    tools: Optional[List[str]] = None,
    include_raw_output: bool = False,
) -> Path:
    """
    Manual-review CSV runner with Terraform group support.

    For terraform rows where template_path contains multiple files:
      - tflint               -> run_tflint_on_group
      - terraform-validate   -> run_terraform_validate_on_group
      - checkov              -> run_checkov_on_group

    Output schema matches run_static_analysis_manual_review_on_csv
    (one row per issue + no_issue/error rows).
    """
    input_csv = input_csv or DEFAULT_EXTRACTED_TF_CSV
    output_csv = output_csv or DEFAULT_MANUAL_REVIEW_CSV
    tool_names = tools or list(TOOL_REGISTRY.keys())

    rows_out: List[Dict[str, Any]] = []

    with open(input_csv, "r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            template_path_raw = row.get("template_path", "")
            resolved_paths = _resolve_template_paths(template_path_raw)
            resolved_first = resolved_paths[0] if resolved_paths else ""
            iac_type = str(row.get("template_language", "") or "").strip().lower()

            base_info = {
                "template_name": row.get("template_name", ""),
                "template_language": row.get("template_language", ""),
                "template_path": template_path_raw,
                "resolved_template_path": resolved_first,
                "iac_type": iac_type,
            }

            if not resolved_paths or not Path(resolved_first).exists():
                for tool_name in tool_names:
                    rows_out.append({
                        **base_info,
                        "tool": tool_name,
                        "return_code": "",
                        "duration_s": "",
                        "issue_count": 0,
                        "issue_index": "",
                        "issue_id": "",
                        "issue_message": "",
                        "issue_level": "",
                        "issue_location": "",
                        "issue_json": "",
                        "issue_status": "error",
                        "error": "File not found or invalid path",
                        "raw_stdout": "" if include_raw_output else None,
                        "raw_stderr": "" if include_raw_output else None,
                    })
                continue

            for tool_name in tool_names:
                entry = TOOL_REGISTRY.get(tool_name, {})
                supports = set(entry.get("supports", set()))
                if iac_type and iac_type not in supports:
                    rows_out.append({
                        **base_info,
                        "tool": tool_name,
                        "return_code": "",
                        "duration_s": "",
                        "issue_count": 0,
                        "issue_index": "",
                        "issue_id": "",
                        "issue_message": "",
                        "issue_level": "",
                        "issue_location": "",
                        "issue_json": "",
                        "issue_status": "unsupported",
                        "error": f"{tool_name} does not support '{iac_type}'",
                        "raw_stdout": "" if include_raw_output else None,
                        "raw_stderr": "" if include_raw_output else None,
                    })
                    continue

                use_group = iac_type == "terraform" and len(resolved_paths) > 1
                if use_group and tool_name == "tflint":
                    res = run_tflint_on_group(resolved_paths)
                elif use_group and tool_name == "terraform-validate":
                    res = run_terraform_validate_on_group(resolved_paths)
                elif use_group and tool_name == "checkov":
                    res = run_checkov_on_group(resolved_paths, iac_type="terraform")
                else:
                    fn = entry.get("fn")
                    if not callable(fn):
                        res = {"error": f"Tool function not found for '{tool_name}'", "issues": []}
                    else:
                        res = fn(resolved_first, iac_type=iac_type)

                if not isinstance(res, dict):
                    res = {"error": f"Unexpected result for tool '{tool_name}'", "issues": []}

                issues = res.get("issues", []) if isinstance(res.get("issues", []), list) else []
                issue_count = len(issues)

                if issue_count == 0:
                    out_row = {
                        **base_info,
                        "tool": tool_name,
                        "return_code": res.get("return_code", ""),
                        "duration_s": res.get("duration_s", ""),
                        "issue_count": 0,
                        "issue_index": "",
                        "issue_id": "",
                        "issue_message": "",
                        "issue_level": "",
                        "issue_location": "",
                        "issue_json": "",
                        "issue_status": "error" if (res.get("error") or "") else "no_issue",
                        "error": res.get("error", "") or "",
                    }
                    if include_raw_output:
                        out_row["raw_stdout"] = res.get("raw_stdout", "")
                        out_row["raw_stderr"] = res.get("raw_stderr", "")
                    rows_out.append(out_row)
                    continue

                for idx, issue in enumerate(issues, start=1):
                    issue = issue if isinstance(issue, dict) else {"message": str(issue)}
                    out_row = {
                        **base_info,
                        "tool": tool_name,
                        "return_code": res.get("return_code", ""),
                        "duration_s": res.get("duration_s", ""),
                        "issue_count": issue_count,
                        "issue_index": idx,
                        "issue_id": issue.get("id", ""),
                        "issue_message": issue.get("message", ""),
                        "issue_level": issue.get("level", ""),
                        "issue_location": issue.get("location", ""),
                        "issue_json": json.dumps(issue, ensure_ascii=False),
                        "issue_status": "issue",
                        "error": res.get("error", "") or "",
                    }
                    if include_raw_output:
                        out_row["raw_stdout"] = res.get("raw_stdout", "")
                        out_row["raw_stderr"] = res.get("raw_stderr", "")
                    rows_out.append(out_row)

    output_csv.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = [
        "template_name",
        "template_language",
        "template_path",
        "resolved_template_path",
        "tool",
        "iac_type",
        "return_code",
        "duration_s",
        "issue_count",
        "issue_index",
        "issue_id",
        "issue_message",
        "issue_level",
        "issue_location",
        "issue_json",
        "issue_status",
        "error",
    ]
    if include_raw_output:
        fieldnames.extend(["raw_stdout", "raw_stderr"])

    with open(output_csv, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows_out)

    return output_csv


def main():
    # Use of cli
    # import sys

    # if len(sys.argv) < 2 and target is None:
    #     print("Usage: python static_tool_test.py <iac_file> [tool1,tool2,...]")
    #     sys.exit(1)

    # target = sys.argv[1]
    # tool_filter = sys.argv[2].split(",") if len(sys.argv) > 2 else None

    # Use of code directly
    # target = "D:/Personal Storage/1 - PhD/0_Projects/1_IR/code/paper/paper_content/figures/motivating_example/cloudformation.yaml"
    # tool_filter = ["trivy", "cfn-lint", "checkov"]

    # report = run_all_tools(target, tools=tool_filter)
    # print_report(report)
    # print("\n--- Full JSON ---")
    # print(json.dumps(report, indent=2, default=str))

    # Evaluation static anlaysis tools
    # out_path = run_static_analysis_on_csv(
    #     input_csv=Path("evaluation/oracle/oracle_dataset_test.csv"),
    #     output_csv=Path("evaluation/static_analysis_tools/result/results_test.csv"),
    #     # tools=["tflint", "trivy", "checkov", "terraform-validate"],  # or None for all
    # )
    # CloudFormation Manual Review Results
    # out = run_static_analysis_manual_review_on_csv(
    #     input_csv=Path("evaluation/oracle/oracle_dataset_cfn.csv"),
    #     output_csv=Path("evaluation/static_analysis_tools/result/manual_review_results_cfn_checkov.csv"),
    #     tools=["checkov"],   # "cfn-lint", "trivy", "checkov"
    #     include_raw_output=False,
    # )

    # ARM Manual Review Results
    # out = run_static_analysis_manual_review_on_csv(
    #     input_csv=Path("evaluation/oracle/oracle_dataset_arm.csv"),
    #     output_csv=Path("evaluation/static_analysis_tools/result/manual_review_results_arm.csv"),
    #     tools=["trivy", "checkov"],   # "arm-ttk" will run on a seperate function
    #     include_raw_output=False,
    # )
    # ARM-TTK folder runner (templates under tools/arm-ttk/arm-ttk/templates)
    # out = run_arm_ttk_manual_review_on_templates_folder(
    #     templates_dir=Path("tools/arm-ttk/arm-ttk/templates"),
    #     output_csv=Path("evaluation/static_analysis_tools/result/manual_review_results_arm_ttk_templates.csv"),
    #     include_raw_output=False,
    #     recursive=True,
    #     max_templates=None,  # set to an int (e.g., 10) for quick tests
    # )
    # print(f"ARM-TTK folder manual-review output: {out}")

    # # Terraform Manual Review Results (group-aware for | separated files)
    out = run_static_analysis_manual_review_on_csv_with_group_support(
        input_csv=Path("evaluation/oracle/oracle_dataset_tf.csv"),
        output_csv=Path("evaluation/static_analysis_tools/result/manual_review_results_tf_group.csv"),
        tools=["tflint", "trivy", "checkov", "terraform-validate"],
        include_raw_output=False,
    )

    # # Bicep Manual Review Results
    # out = run_static_analysis_manual_review_on_csv(
    #     input_csv=Path("evaluation/oracle/oracle_dataset_bicep.csv"),
    #     output_csv=Path("evaluation/static_analysis_tools/result/manual_review_results_bicep_checkov.csv"),
    #     tools=["checkov"],   # "bicep-linter", "trivy", "checkov"
    #     include_raw_output=False,
    # )


if __name__ == "__main__":
    main()