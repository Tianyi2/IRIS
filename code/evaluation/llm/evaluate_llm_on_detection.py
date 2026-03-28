"""
Run one-shot LLM smell detection on oracle templates and compare with ground truth.

This script evaluates template-level smell detection for three providers:
- ChatGPT (OpenAI API)
- Claude (Anthropic API)
- DeepSeek (OpenAI-compatible API)

For each template in the oracle dataset, the evaluator:
1) loads the template content from template_path,
2) prompts the selected LLM once with the 12 supported smells,
3) parses detected smells from strict JSON output,
4) compares predictions with oracle ground truth.

Metrics are computed as binary classification over (template, smell) pairs.
"""

from __future__ import annotations

import csv
import datetime as dt
import json
import os
import re
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Sequence, Set, Tuple
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen
try:
    from prompt import PROMPT
except Exception:  # noqa: BLE001
    from evaluation.oracle.prompt import PROMPT

PROJECT_ROOT = Path(__file__).resolve().parent.parent.parent
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from config.sensitive import CLAUDE_KEY, DEEPSEEK_KEY, GPT_KEY

# try:
#     from config.sensitive import CLAUDE_KEY, DEEPSEEK_KEY, GPT_KEY
# except Exception:  # noqa: BLE001
#     CLAUDE_KEY = ""
#     DEEPSEEK_KEY = ""
#     GPT_KEY = ""

csv.field_size_limit(2**31 - 1)

# GPT_MODEL = "gpt-5.4"
GPT_MODEL = "gpt-4o-mini"
CLAUDE_MODEL = "claude-opus-4-6"
# CLAUDE_MODEL = "claude-haiku-4-5-20251001"
# DEEPSEEK_MODEL = "deepseek-reasoner"
DEEPSEEK_MODEL = "deepseek-chat"

SUPPORTED_SMELLS = [
    "always_true_conditions",
    "always_false_conditions",
    "dead_resources",
    "unused_parameters",
    "unused_conditions",
    "no_sourced_outputs",
    "no_sourced_conditions",
    "circular_dependencies",
    "cascading_provisioning_failures",
    "hard_coded_secrets",
    "unrestricted_ip_addresses",
    "unprotected_secrets",
]

SMELL_DEFINITIONS = {
    "always_true_conditions": "Conditions that always evaluate to true.",
    "always_false_conditions": "Conditions that always evaluate to false.",
    "dead_resources": "Resources that are never provisioned or effectively unreachable.",
    "unused_parameters": "Parameters/variables declared but never used.",
    "unused_conditions": "Conditions declared but never referenced.",
    "no_sourced_outputs": "Outputs not sourced from meaningful resources/parameters.",
    "no_sourced_conditions": "Conditions with no meaningful source dependencies.",
    "circular_dependencies": "Cyclic dependency among IaC elements.",
    "cascading_provisioning_failures": "A failing prerequisite can trigger downstream failures.",
    "hard_coded_secrets": "Secrets/credentials hard-coded in template values.",
    "unrestricted_ip_addresses": "Rules allowing unrestricted IPs, such as 0.0.0.0/0.",
    "unprotected_secrets": "Secret-like parameters without protection controls.",
}

PROVIDER_NAMES = ("chatgpt", "claude", "deepseek")
SMELL_SET = set(SUPPORTED_SMELLS)
SMELL_NORMALIZATION = {k.lower(): k for k in SUPPORTED_SMELLS}


@dataclass
class TemplateRecord:
    template_name: str
    template_language: str
    template_path: str


def _read_csv_rows(path: Path) -> List[Dict[str, str]]:
    with open(path, "r", encoding="utf-8-sig", newline="") as fh:
        return list(csv.DictReader(fh))


def _load_dataset(dataset_csv: Path) -> List[TemplateRecord]:
    rows = _read_csv_rows(dataset_csv)
    out: List[TemplateRecord] = []
    for row in rows:
        out.append(
            TemplateRecord(
                template_name=row.get("template_name", "").strip(),
                template_language=row.get("template_language", "").strip(),
                template_path=row.get("template_path", "").strip(),
            )
        )
    return out


def _load_ground_truth(ground_truth_csv: Path) -> Dict[str, Set[str]]:
    rows = _read_csv_rows(ground_truth_csv)
    gt: Dict[str, Set[str]] = {}
    for row in rows:
        template_name = row.get("template_name", "").strip()
        smell_type = row.get("smell_type", "").strip()
        if not template_name or smell_type not in SMELL_SET:
            continue
        gt.setdefault(template_name, set()).add(smell_type)
    return gt


def _resolve_template_paths(path_value: str) -> List[Path]:
    if not path_value:
        return []
    raw_paths = [p.strip() for p in path_value.split("|") if p.strip()]
    resolved: List[Path] = []
    for raw in raw_paths:
        normalized = raw.replace("\\", "/")
        candidate = Path(normalized)
        if not candidate.is_absolute():
            candidate = PROJECT_ROOT / candidate
        resolved.append(candidate)
    return resolved


def _load_template_text(path_value: str) -> str:
    chunks: List[str] = []
    for file_path in _resolve_template_paths(path_value):
        if not file_path.exists():
            chunks.append(f"# FILE_NOT_FOUND: {file_path}")
            continue
        try:
            content = file_path.read_text(encoding="utf-8", errors="replace")
        except OSError as err:
            chunks.append(f"# FILE_READ_ERROR: {file_path} ({err})")
            continue
        chunks.append(f"### FILE: {file_path.name}\n{content}")
    return "\n\n".join(chunks)


def _build_prompt(template_language: str, template_content: str) -> str:
    """
    Build prompt robustly for both placeholder styles:
      - {{template_language}} / {{template_content}}
      - {template_language} / {template_content}
    """
    prompt = PROMPT
    prompt = prompt.replace("{{template_language}}", str(template_language))
    prompt = prompt.replace("{{template_content}}", str(template_content))
    return prompt


def _post_json(url: str, headers: Dict[str, str], payload: Dict[str, Any], timeout_s: int) -> Dict[str, Any]:
    data = json.dumps(payload).encode("utf-8")
    request = Request(url=url, data=data, headers=headers, method="POST")
    try:
        with urlopen(request, timeout=timeout_s) as response:
            body = response.read().decode("utf-8")
            return json.loads(body)
    except HTTPError as err:
        detail = err.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"HTTP {err.code}: {detail}") from err
    except URLError as err:
        raise RuntimeError(f"Network error: {err}") from err


def _call_openai_compatible(
    *,
    api_key: str,
    model: str,
    prompt: str,
    timeout_s: int,
    base_url: str,
) -> str:
    payload = {
        "model": model,
        "messages": [
            {"role": "system", "content": "Return strict JSON only."},
            {"role": "user", "content": prompt},
        ],
        "temperature": 0,
    }
    body = _post_json(
        url=base_url.rstrip("/") + "/chat/completions",
        headers={
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
        },
        payload=payload,
        timeout_s=timeout_s,
    )
    choices = body.get("choices", [])
    if not choices:
        raise RuntimeError("No choices returned by model")
    message = choices[0].get("message", {})
    content = message.get("content", "")
    if not isinstance(content, str):
        raise RuntimeError("Unexpected response shape from model")
    return content


def _call_claude(
    api_key: str,
    model: str,
    prompt: str,
    timeout_s: int,
    max_tokens: int = 4096,
) -> str:
    payload = {
        "model": model,
        "max_tokens": max_tokens,
        "temperature": 0,
        "messages": [{"role": "user", "content": prompt}],
        "system": (
            "Return strict JSON only. "
            "Do not output scratchpad or intermediate reasoning."
        ),
    }
    body = _post_json(
        url="https://api.anthropic.com/v1/messages",
        headers={
            "x-api-key": api_key,
            "anthropic-version": "2023-06-01",
            "content-type": "application/json",
        },
        payload=payload,
        timeout_s=timeout_s,
    )
    content_blocks = body.get("content", [])
    text_parts: List[str] = []
    for block in content_blocks:
        if isinstance(block, dict) and block.get("type") == "text":
            text_parts.append(str(block.get("text", "")))
    if not text_parts:
        raise RuntimeError("No text content returned by Claude")
    return "\n".join(text_parts)


def _extract_json_block(text: str) -> Dict[str, Any]:
    text = (text or "").strip()
    if not text:
        return {}
    try:
        parsed = json.loads(text)
        if isinstance(parsed, dict):
            return parsed
    except json.JSONDecodeError:
        pass

    code_fence_match = re.search(r"```(?:json)?\s*(\{.*?\})\s*```", text, re.DOTALL | re.IGNORECASE)
    if code_fence_match:
        try:
            parsed = json.loads(code_fence_match.group(1))
            if isinstance(parsed, dict):
                return parsed
        except json.JSONDecodeError:
            pass

    bracket_match = re.search(r"\{.*\}", text, re.DOTALL)
    if bracket_match:
        try:
            parsed = json.loads(bracket_match.group(0))
            if isinstance(parsed, dict):
                return parsed
        except json.JSONDecodeError:
            return {}
    return {}


def _normalize_smells(smells: Iterable[Any]) -> Set[str]:
    normalized: Set[str] = set()
    for smell in smells:
        if isinstance(smell, str):
            key = SMELL_NORMALIZATION.get(smell.strip().lower())
            if key:
                normalized.add(key)
        elif isinstance(smell, dict):
            candidate = smell.get("smell_type") or smell.get("name")
            if isinstance(candidate, str):
                key = SMELL_NORMALIZATION.get(candidate.strip().lower())
                if key:
                    normalized.add(key)
    return normalized


def _normalize_finding(obj: Dict[str, Any]) -> Optional[Dict[str, str]]:
    smell_candidate = (
        obj.get("smell_name")
        or obj.get("smell_type")
        or obj.get("name")
    )
    if not isinstance(smell_candidate, str):
        return None
    smell_name = SMELL_NORMALIZATION.get(smell_candidate.strip().lower())
    if not smell_name:
        return None

    element_name = obj.get("element_name", "")
    if not isinstance(element_name, str):
        element_name = str(element_name)

    explanation = obj.get("explanation", "")
    if not isinstance(explanation, str):
        explanation = str(explanation)

    return {
        "smell_name": smell_name,
        "element_name": element_name.strip(),
        "explanation": explanation.strip(),
    }


def _extract_findings_from_text(raw_response: str) -> List[Dict[str, str]]:
    findings: List[Dict[str, str]] = []
    pattern = re.compile(
        r"\*\*\[(?P<smell>[^\]]+)\]\*\*\s*:\s*(?P<explanation>.*?)(?:\nEvidence:\s*(?P<evidence>.*?))?(?:\n|$)",
        re.IGNORECASE | re.DOTALL,
    )
    for match in pattern.finditer(raw_response or ""):
        smell_raw = (match.group("smell") or "").strip()
        smell_name = SMELL_NORMALIZATION.get(smell_raw.lower())
        if not smell_name:
            continue
        explanation = (match.group("explanation") or "").strip()
        evidence = (match.group("evidence") or "").strip()
        if evidence:
            explanation = f"{explanation} Evidence: {evidence}".strip()
        findings.append(
            {
                "smell_name": smell_name,
                "element_name": "",
                "explanation": explanation,
            }
        )
    return findings


def _unescape_json_string(value: str) -> str:
    """Best-effort unescape for JSON-like string fragments."""
    try:
        return json.loads(f'"{value}"')
    except Exception:  # noqa: BLE001
        return value


def _extract_findings_from_partial_json(raw_response: str) -> List[Dict[str, str]]:
    """
    Recover findings from truncated JSON blocks.

    This handles responses where the model starts valid JSON but the output is cut
    before the closing bracket/brace.
    """
    findings: List[Dict[str, str]] = []
    pattern = re.compile(
        r'"smell_name"\s*:\s*"(?P<smell>(?:\\.|[^"\\])*)"\s*,\s*'
        r'"element_name"\s*:\s*"(?P<element>(?:\\.|[^"\\])*)"\s*,\s*'
        r'"explanation"\s*:\s*"(?P<explanation>(?:\\.|[^"\\])*)"',
        re.IGNORECASE | re.DOTALL,
    )
    for match in pattern.finditer(raw_response or ""):
        smell_raw = _unescape_json_string(match.group("smell")).strip()
        smell_name = SMELL_NORMALIZATION.get(smell_raw.lower())
        if not smell_name:
            continue
        findings.append(
            {
                "smell_name": smell_name,
                "element_name": _unescape_json_string(match.group("element")).strip(),
                "explanation": _unescape_json_string(match.group("explanation")).strip(),
            }
        )
    return findings


def _extract_findings_from_summary(raw_response: str) -> List[Dict[str, str]]:
    """
    Recover smell findings from natural-language summary sections.

    Example handled:
      Summary of detected smells:
      1. hard_coded_secrets: ...
    """
    findings: List[Dict[str, str]] = []
    text = raw_response or ""
    summary_match = re.search(
        r"summary of detected smells\s*:(?P<body>.*?)(?:</scratchpad>|```|$)",
        text,
        re.IGNORECASE | re.DOTALL,
    )
    if not summary_match:
        return findings

    body = summary_match.group("body")
    for smell in SUPPORTED_SMELLS:
        smell_pattern = re.compile(
            rf"(?:^|\n)\s*(?:[-*]|\d+\.)?\s*{re.escape(smell)}\s*:\s*(?P<explanation>[^\n]+)",
            re.IGNORECASE,
        )
        for match in smell_pattern.finditer(body):
            findings.append(
                {
                    "smell_name": smell,
                    "element_name": "",
                    "explanation": (match.group("explanation") or "").strip(),
                }
            )
    return findings


def _parse_predicted_smells(raw_response: str) -> Tuple[Set[str], List[Dict[str, str]]]:
    obj = _extract_json_block(raw_response)
    findings: List[Dict[str, str]] = []

    if obj:
        detected_findings = obj.get("detected_findings")
        if isinstance(detected_findings, list):
            for item in detected_findings:
                if isinstance(item, dict):
                    normalized = _normalize_finding(item)
                    if normalized:
                        findings.append(normalized)

        if not findings and isinstance(obj.get("smells"), list):
            for item in obj["smells"]:
                if isinstance(item, dict):
                    normalized = _normalize_finding(item)
                    if normalized:
                        findings.append(normalized)

        if not findings and isinstance(obj.get("detected_smells"), list):
            smell_set = _normalize_smells(obj["detected_smells"])
            findings.extend(
                {
                    "smell_name": smell,
                    "element_name": "",
                    "explanation": "",
                }
                for smell in sorted(smell_set)
            )

    if not findings:
        findings = _extract_findings_from_text(raw_response)
    if not findings:
        findings = _extract_findings_from_partial_json(raw_response)
    if not findings:
        findings = _extract_findings_from_summary(raw_response)

    unique: Dict[Tuple[str, str, str], Dict[str, str]] = {}
    for finding in findings:
        key = (
            finding["smell_name"],
            finding["element_name"],
            finding["explanation"],
        )
        unique[key] = finding
    deduped = list(unique.values())
    return {f["smell_name"] for f in deduped}, deduped


def _looks_incomplete_response(raw_response: str, findings: List[Dict[str, str]]) -> bool:
    text = (raw_response or "").strip()
    if not text:
        return True
    if findings:
        return False
    has_json_marker = '"detected_findings"' in text or "detected_findings" in text
    has_scratchpad = "<scratchpad>" in text.lower()
    missing_closing = "<scratchpad>" in text and "</scratchpad>" not in text
    # Common truncation signatures for long reasoning output.
    ends_abruptly = text.endswith(":") or text.endswith("without") or text.endswith("\\")
    return bool((has_scratchpad and missing_closing) or (has_json_marker and not findings) or ends_abruptly)


def _invoke_provider(
    provider: str,
    prompt: str,
    timeout_s: int,
) -> Tuple[Set[str], List[Dict[str, str]], str, str]:
    provider = provider.lower()
    raw_response = ""
    model_name = ""

    if provider == "chatgpt":
        api_key = GPT_KEY
        model_name = GPT_MODEL
        if not api_key:
            raise RuntimeError("Missing OPENAI_API_KEY (or CHATGPT_API_KEY)")
        raw_response = _call_openai_compatible(
            api_key=api_key,
            model=model_name,
            prompt=prompt,
            timeout_s=timeout_s,
            base_url=os.getenv("OPENAI_BASE_URL", "https://api.openai.com/v1"),
        )

    elif provider == "deepseek":
        api_key = DEEPSEEK_KEY
        model_name = DEEPSEEK_MODEL
        if not api_key:
            raise RuntimeError("Missing DEEPSEEK_API_KEY")
        raw_response = _call_openai_compatible(
            api_key=api_key,
            model=model_name,
            prompt=prompt,
            timeout_s=timeout_s,
            base_url=os.getenv("DEEPSEEK_BASE_URL", "https://api.deepseek.com"),
        )

    elif provider == "claude":
        api_key = CLAUDE_KEY
        model_name = CLAUDE_MODEL
        if not api_key:
            raise RuntimeError("Missing ANTHROPIC_API_KEY (or CLAUDE_API_KEY)")
        raw_response = _call_claude(
            api_key=api_key,
            model=model_name,
            prompt=prompt,
            timeout_s=timeout_s,
            max_tokens=4096,
        )
    else:
        raise ValueError(f"Unsupported provider: {provider}")

    predicted_smells, predicted_findings = _parse_predicted_smells(raw_response)

    # Retry once for Claude if output appears truncated/non-JSON.
    if provider == "claude" and _looks_incomplete_response(raw_response, predicted_findings):
        retry_prompt = (
            f"{prompt}\n\n"
            "IMPORTANT: Return ONLY final JSON object with key "
            '"detected_findings". Do not include <scratchpad>.'
        )
        raw_response = _call_claude(
            api_key=api_key,
            model=model_name,
            prompt=retry_prompt,
            timeout_s=timeout_s,
            max_tokens=4096,
        )
        predicted_smells, predicted_findings = _parse_predicted_smells(raw_response)

    return predicted_smells, predicted_findings, raw_response, model_name


def _compute_binary_metrics(
    templates: Sequence[TemplateRecord],
    gt_by_template: Dict[str, Set[str]],
    pred_by_template: Dict[str, Set[str]],
) -> Dict[str, Any]:
    total_tp = total_fp = total_fn = total_tn = 0
    per_smell: Dict[str, Dict[str, float]] = {}

    for smell in SUPPORTED_SMELLS:
        tp = fp = fn = tn = 0
        for record in templates:
            template_name = record.template_name
            gt = smell in gt_by_template.get(template_name, set())
            pred = smell in pred_by_template.get(template_name, set())
            if gt and pred:
                tp += 1
            elif not gt and pred:
                fp += 1
            elif gt and not pred:
                fn += 1
            else:
                tn += 1

        total_tp += tp
        total_fp += fp
        total_fn += fn
        total_tn += tn

        precision = tp / (tp + fp) if (tp + fp) else 0.0
        recall = tp / (tp + fn) if (tp + fn) else 0.0
        f1 = 2 * precision * recall / (precision + recall) if (precision + recall) else 0.0
        per_smell[smell] = {
            "tp": tp,
            "fp": fp,
            "fn": fn,
            "tn": tn,
            "precision": precision,
            "recall": recall,
            "f1": f1,
        }

    micro_precision = total_tp / (total_tp + total_fp) if (total_tp + total_fp) else 0.0
    micro_recall = total_tp / (total_tp + total_fn) if (total_tp + total_fn) else 0.0
    micro_f1 = (
        2 * micro_precision * micro_recall / (micro_precision + micro_recall)
        if (micro_precision + micro_recall)
        else 0.0
    )
    exact_match = sum(
        1 for t in templates
        if gt_by_template.get(t.template_name, set()) == pred_by_template.get(t.template_name, set())
    )

    return {
        "overall": {
            "tp": total_tp,
            "fp": total_fp,
            "fn": total_fn,
            "tn": total_tn,
            "precision": micro_precision,
            "recall": micro_recall,
            "f1": micro_f1,
            "template_exact_match_accuracy": exact_match / len(templates) if templates else 0.0,
        },
        "per_smell": per_smell,
    }


def _write_predictions_csv(rows: List[Dict[str, str]], output_path: Path) -> None:
    fieldnames = [
        "provider",
        "model",
        "template_name",
        "template_language",
        "ground_truth_smells",
        "predicted_smells",
        "tp_smells",
        "fp_smells",
        "fn_smells",
        "smell_name",
        "element_name",
        "explanation",
        "response_json_path",
        "error",
    ]
    output_path.parent.mkdir(parents=True, exist_ok=True)
    normalized_rows: List[Dict[str, str]] = []
    for row in rows:
        cleaned: Dict[str, str] = {}
        for key in fieldnames:
            value = row.get(key, "")
            cleaned[key] = "" if value is None else str(value)
        normalized_rows.append(cleaned)
    with open(output_path, "w", encoding="utf-8", newline="") as fh:
        writer = csv.DictWriter(fh, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(normalized_rows)


def _safe_filename(value: str, default: str = "template") -> str:
    text = (value or "").strip()
    if not text:
        return default
    text = re.sub(r"[^\w.-]+", "_", text)
    text = text.strip("._")
    return text or default


def _write_response_json(
    *,
    output_dir: Path,
    provider: str,
    template_name: str,
    template_language: str,
    model_name: str,
    predicted_smells: Set[str],
    predicted_findings: List[Dict[str, str]],
    raw_response: str,
    error_message: str,
) -> Path:
    provider_dir = output_dir / provider
    provider_dir.mkdir(parents=True, exist_ok=True)
    safe_name = _safe_filename(template_name)
    out_path = provider_dir / f"{safe_name}.json"
    payload = {
        "provider": provider,
        "model": model_name,
        "template_name": template_name,
        "template_language": template_language,
        "predicted_smells": sorted(predicted_smells),
        "predicted_findings": predicted_findings,
        "response_message": raw_response,
        "error": error_message,
    }
    out_path.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
    return out_path


def evaluate_llms_on_detection(
    dataset_csv: Optional[Path] = None,
    ground_truth_csv: Optional[Path] = None,
    providers: Sequence[str] = PROVIDER_NAMES,
    max_templates: Optional[int] = None,
    template_char_limit: int = 20000,
    request_timeout_s: int = 180,
    sleep_seconds: float = 0.0,
    output_dir: Optional[Path] = None,
) -> Dict[str, Any]:
    """
    Evaluate one-shot LLM detection against oracle ground truth.

    Returns a nested dictionary with provider-level metrics and output file paths.
    """
    templates = _load_dataset(dataset_csv)
    if max_templates is not None:
        templates = templates[: max(0, max_templates)]
    gt_by_template = _load_ground_truth(ground_truth_csv)

    timestamp = dt.datetime.now().strftime("%Y%m%d_%H%M%S")
    all_results: Dict[str, Any] = {
        "dataset_csv": str(dataset_csv),
        "ground_truth_csv": str(ground_truth_csv),
        "timestamp": timestamp,
        "providers": {},
    }

    for provider in providers:
        provider_key = provider.lower()
        prediction_rows: List[Dict[str, str]] = []
        pred_by_template: Dict[str, Set[str]] = {}
        model_name = ""

        for idx, record in enumerate(templates, start=1):
            gt_smells = gt_by_template.get(record.template_name, set())
            template_text = _load_template_text(record.template_path)
            if len(template_text) > template_char_limit:
                template_text = template_text[:template_char_limit]

            prompt = _build_prompt(record.template_language, template_text)
            error_message = ""
            predicted_smells: Set[str] = set()
            predicted_findings: List[Dict[str, str]] = []
            raw_response = ""

            try:
                (
                    predicted_smells,
                    predicted_findings,
                    raw_response,
                    model_name,
                ) = _invoke_provider(
                    provider=provider_key,
                    prompt=prompt,
                    timeout_s=request_timeout_s,
                )
            except Exception as err:  # noqa: BLE001
                error_message = str(err)

            pred_by_template[record.template_name] = predicted_smells
            tp_smells = sorted(gt_smells & predicted_smells)
            fp_smells = sorted(predicted_smells - gt_smells)
            fn_smells = sorted(gt_smells - predicted_smells)
            response_json_path = _write_response_json(
                output_dir=output_dir,
                provider=provider_key,
                template_name=record.template_name,
                template_language=record.template_language,
                model_name=model_name,
                predicted_smells=predicted_smells,
                predicted_findings=predicted_findings,
                raw_response=raw_response,
                error_message=error_message,
            )

            if predicted_findings:
                for finding in predicted_findings:
                    prediction_rows.append(
                        {
                            "provider": provider_key,
                            "model": model_name,
                            "template_name": record.template_name,
                            "template_language": record.template_language,
                            "ground_truth_smells": ";".join(sorted(gt_smells)),
                            "predicted_smells": ";".join(sorted(predicted_smells)),
                            "tp_smells": ";".join(tp_smells),
                            "fp_smells": ";".join(fp_smells),
                            "fn_smells": ";".join(fn_smells),
                            "smell_name": finding.get("smell_name", ""),
                            "element_name": finding.get("element_name", ""),
                            "explanation": finding.get("explanation", ""),
                            "response_json_path": str(response_json_path),
                            "error": error_message,
                        }
                    )
            else:
                prediction_rows.append(
                    {
                        "provider": provider_key,
                        "model": model_name,
                        "template_name": record.template_name,
                        "template_language": record.template_language,
                        "ground_truth_smells": ";".join(sorted(gt_smells)),
                        "predicted_smells": ";".join(sorted(predicted_smells)),
                        "tp_smells": ";".join(tp_smells),
                        "fp_smells": ";".join(fp_smells),
                        "fn_smells": ";".join(fn_smells),
                        "smell_name": "",
                        "element_name": "",
                        "explanation": "",
                        "response_json_path": str(response_json_path),
                        "error": error_message,
                    }
                )

            print(
                f"[{provider_key}] {idx}/{len(templates)} "
                f"{record.template_name} -> pred={sorted(predicted_smells)} "
                f"{'(error)' if error_message else ''}"
            )

            # Keep latest raw response in case debugging is needed in logs.
            _ = raw_response
            if sleep_seconds > 0:
                time.sleep(sleep_seconds)

        metrics = _compute_binary_metrics(templates, gt_by_template, pred_by_template)
        provider_prefix = f"{provider_key}_{timestamp}"
        predictions_csv = output_dir / f"{provider_prefix}_predictions.csv"
        metrics_json = output_dir / f"{provider_prefix}_metrics.json"
        _write_predictions_csv(prediction_rows, predictions_csv)
        metrics_json.parent.mkdir(parents=True, exist_ok=True)
        metrics_json.write_text(
            json.dumps(metrics, ensure_ascii=False, indent=2),
            encoding="utf-8",
        )

        all_results["providers"][provider_key] = {
            "model": model_name,
            "metrics": metrics,
            "predictions_csv": str(predictions_csv),
            "metrics_json": str(metrics_json),
        }

    summary_json = output_dir / f"llm_detection_eval_{timestamp}.json"
    summary_json.parent.mkdir(parents=True, exist_ok=True)
    summary_json.write_text(json.dumps(all_results, ensure_ascii=False, indent=2), encoding="utf-8")
    all_results["summary_json"] = str(summary_json)
    return all_results


def print_report(results: Dict[str, Any]) -> None:
    """Print a compact provider-level report."""
    print("=" * 90)
    print("LLM ONE-SHOT DETECTION EVALUATION")
    print("=" * 90)
    print(f"Dataset      : {results['dataset_csv']}")
    print(f"Ground truth : {results['ground_truth_csv']}")
    print(f"Summary file : {results.get('summary_json', '')}")
    print()

    providers = results.get("providers", {})
    for provider, provider_result in providers.items():
        model = provider_result.get("model", "")
        overall = provider_result.get("metrics", {}).get("overall", {})
        print(f"[{provider}] model={model}")
        print(
            "  TP={tp} FP={fp} FN={fn} TN={tn}  "
            "Precision={p:.3f} Recall={r:.3f} F1={f1:.3f} ExactMatch={acc:.3f}".format(
                tp=int(overall.get("tp", 0)),
                fp=int(overall.get("fp", 0)),
                fn=int(overall.get("fn", 0)),
                tn=int(overall.get("tn", 0)),
                p=float(overall.get("precision", 0.0)),
                r=float(overall.get("recall", 0.0)),
                f1=float(overall.get("f1", 0.0)),
                acc=float(overall.get("template_exact_match_accuracy", 0.0)),
            )
        )
        print(f"  predictions_csv: {provider_result.get('predictions_csv', '')}")
        print(f"  metrics_json   : {provider_result.get('metrics_json', '')}")
        print()


if __name__ == "__main__":
    import argparse

    DEFAULT_DATASET_CSV = PROJECT_ROOT / "evaluation" / "oracle" / "oracle_dataset_tf.csv"
    DEFAULT_GT_CSV = PROJECT_ROOT / "evaluation" / "oracle" / "oracle_ground_truth_tf.csv"
    DEFAULT_OUTPUT_DIR = PROJECT_ROOT / "evaluation" / "oracle" / "llm_eval_outputs_tf"
    DEFAULT_PROVIDERS = "claude"
    # DEFAULT_PROVIDERS = "chatgpt,claude,deepseek"

    parser = argparse.ArgumentParser(
        description="Evaluate one-shot LLM smell detection on oracle dataset",
    )
    parser.add_argument(
        "--dataset",
        type=Path,
        default=DEFAULT_DATASET_CSV,
        help="Path to oracle_dataset_*.csv",
    )
    parser.add_argument(
        "--ground-truth",
        type=Path,
        default=DEFAULT_GT_CSV,
        help="Path to oracle_ground_truth_*.csv",
    )
    parser.add_argument(
        "--providers",
        type=str,
        default=DEFAULT_PROVIDERS,
        help="Comma-separated providers: chatgpt,claude,deepseek",
    )
    parser.add_argument(
        "--max-templates",
        type=int,
        default=None,
        help="Optional cap for quick smoke runs",
    )
    parser.add_argument(
        "--template-char-limit",
        type=int,
        default=20000,
        help="Maximum chars from template content per prompt",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=180,
        help="HTTP request timeout in seconds",
    )
    parser.add_argument(
        "--sleep-seconds",
        type=float,
        default=0.0,
        help="Pause between calls to avoid rate limits",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=DEFAULT_OUTPUT_DIR,
        help="Directory to write prediction/metric artifacts",
    )
    args = parser.parse_args()

    chosen_providers = [
        p.strip().lower() for p in args.providers.split(",") if p.strip()
    ]
    results = evaluate_llms_on_detection(
        dataset_csv=args.dataset,
        ground_truth_csv=args.ground_truth,
        providers=chosen_providers,
        max_templates=args.max_templates,
        template_char_limit=args.template_char_limit,
        request_timeout_s=args.timeout,
        sleep_seconds=args.sleep_seconds,
        output_dir=args.output_dir,
    )
    print_report(results)
