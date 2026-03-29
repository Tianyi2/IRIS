"""
Terraform static analysis helpers for multi-file template groups.

This module is focused on Terraform group scanning with:
  - tflint
  - terraform validate

It supports the same group path style used in the project, e.g.:
  "a/main.tf|a/variables.tf|a/outputs.tf"
"""

from __future__ import annotations

import json
import shutil
import subprocess
import tempfile
import time
from pathlib import Path
from typing import Any, Dict, List, Optional, Sequence, Union


PROJECT_ROOT = Path(__file__).resolve().parent.parent.parent
TOOLS_DIR = PROJECT_ROOT / "tools"
TFLINT_EXE = TOOLS_DIR / "tflint.exe"


def _base_group_result(tool: str, group_files: List[str]) -> Dict[str, Any]:
    return {
        "tool": tool,
        "group_files": group_files,
        "iac_type": "terraform",
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
) -> tuple[int, str, str]:
    proc = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
        cwd=cwd,
        timeout=timeout,
    )
    return proc.returncode, proc.stdout or "", proc.stderr or ""


def _to_group_paths(group: Union[str, Sequence[str]]) -> List[Path]:
    """
    Normalize Terraform group input into absolute, existing .tf paths.

    Input can be:
      - pipe-separated string
      - list/tuple of file paths
    """
    if isinstance(group, str):
        raw_paths = [p.strip() for p in group.split("|") if p.strip()]
    else:
        raw_paths = [str(p).strip() for p in group if str(p).strip()]

    paths: List[Path] = []
    for raw in raw_paths:
        # Keep absolute paths as-is; resolve relative ones against project root.
        p = Path(raw)
        if not p.is_absolute():
            p = PROJECT_ROOT / raw.replace("\\", "/")
        p = p.resolve()
        if p.suffix.lower() != ".tf":
            raise ValueError(f"Non-Terraform file in group: {p}")
        if not p.exists():
            raise FileNotFoundError(f"Terraform file does not exist: {p}")
        paths.append(p)

    if not paths:
        raise ValueError("Terraform group is empty")
    return paths


def _copy_group_to_temp_dir(group_paths: List[Path], tmp_dir: str) -> None:
    """
    Copy all Terraform files into one temp working directory.

    If duplicate file names exist from different folders, prefix with index to
    avoid collisions.
    """
    used_names = set()
    for idx, src in enumerate(group_paths):
        dst_name = src.name
        if dst_name in used_names:
            dst_name = f"{idx}_{dst_name}"
        used_names.add(dst_name)
        shutil.copy2(src, Path(tmp_dir) / dst_name)


def run_tflint_on_group(group: Union[str, Sequence[str]]) -> Dict[str, Any]:
    """
    Run tflint against a Terraform template group.

    The group is scanned as one Terraform module by copying all .tf files into a
    temporary directory and executing tflint there.
    """
    group_paths = _to_group_paths(group)
    result = _base_group_result("tflint", [str(p) for p in group_paths])

    exe = str(TFLINT_EXE if TFLINT_EXE.exists() else (shutil.which("tflint") or "tflint"))
    tmp_dir = tempfile.mkdtemp(prefix="tflint_group_")
    start = time.perf_counter()

    try:
        _copy_group_to_temp_dir(group_paths, tmp_dir)
        cmd = [exe, "--format", "json", "--force"]
        rc, stdout, stderr = _run_cmd(cmd, cwd=tmp_dir, timeout=180)

        result["return_code"] = rc
        result["raw_stdout"] = stdout
        result["raw_stderr"] = stderr

        if stdout.strip():
            data = json.loads(stdout)
            for issue in data.get("issues", []):
                start_line = issue.get("range", {}).get("start", {}).get("line", "?")
                result["issues"].append(
                    {
                        "id": issue.get("rule", {}).get("name", ""),
                        "message": issue.get("message", ""),
                        "level": issue.get("rule", {}).get("severity", ""),
                        "location": f"L{start_line}",
                    }
                )
            for err in data.get("errors", []):
                result["issues"].append(
                    {
                        "id": "tflint-error",
                        "message": err.get("message", str(err)),
                        "level": "error",
                        "location": "",
                    }
                )
    except subprocess.TimeoutExpired:
        result["error"] = "tflint timed out"
    except FileNotFoundError:
        result["error"] = "tflint executable not found"
    except json.JSONDecodeError:
        result["error"] = "Failed to parse tflint JSON output"
    except Exception as e:
        result["error"] = str(e)
    finally:
        result["duration_s"] = round(time.perf_counter() - start, 3)
        shutil.rmtree(tmp_dir, ignore_errors=True)

    return result


def run_terraform_validate_on_group(group: Union[str, Sequence[str]]) -> Dict[str, Any]:
    """
    Run terraform init + terraform validate for a Terraform template group.

    Returns parsed diagnostics from `terraform validate -json`.
    """
    group_paths = _to_group_paths(group)
    result = _base_group_result("terraform-validate", [str(p) for p in group_paths])

    tf_exe = shutil.which("terraform")
    if not tf_exe:
        result["error"] = "terraform executable not found on PATH"
        return result

    tmp_dir = tempfile.mkdtemp(prefix="tfvalidate_group_")
    start = time.perf_counter()

    try:
        _copy_group_to_temp_dir(group_paths, tmp_dir)
        _run_cmd([tf_exe, "init", "-backend=false", "-no-color"], cwd=tmp_dir, timeout=120)
        rc, stdout, stderr = _run_cmd(
            [tf_exe, "validate", "-json", "-no-color"],
            cwd=tmp_dir,
            timeout=180,
        )

        result["return_code"] = rc
        result["raw_stdout"] = stdout
        result["raw_stderr"] = stderr

        if stdout.strip():
            data = json.loads(stdout)
            result["return_code"] = 0 if data.get("valid", False) else 1
            for diag in data.get("diagnostics", []):
                start_line = (diag.get("range", {}) or {}).get("start", {}).get("line", "?")
                result["issues"].append(
                    {
                        "id": diag.get("summary", ""),
                        "message": diag.get("detail", ""),
                        "level": diag.get("severity", "error"),
                        "location": f"L{start_line}",
                    }
                )
    except subprocess.TimeoutExpired:
        result["error"] = "terraform validate timed out"
    except FileNotFoundError:
        result["error"] = "terraform executable not found"
    except json.JSONDecodeError:
        result["error"] = "Failed to parse terraform validate JSON output"
    except Exception as e:
        result["error"] = str(e)
    finally:
        result["duration_s"] = round(time.perf_counter() - start, 3)
        shutil.rmtree(tmp_dir, ignore_errors=True)

    return result


def scan_terraform_group_with_tools(
    group: Union[str, Sequence[str]],
) -> Dict[str, Any]:
    """
    Run both tflint and terraform validate on one Terraform group.
    """
    tflint_result = run_tflint_on_group(group)
    tf_validate_result = run_terraform_validate_on_group(group)

    return {
        "group": list(tflint_result.get("group_files", [])),
        "results": {
            "tflint": tflint_result,
            "terraform-validate": tf_validate_result,
        },
        "summary": {
            "tflint_issue_count": len(tflint_result.get("issues", [])),
            "terraform_validate_issue_count": len(tf_validate_result.get("issues", [])),
            "tflint_error": tflint_result.get("error"),
            "terraform_validate_error": tf_validate_result.get("error"),
        },
    }

