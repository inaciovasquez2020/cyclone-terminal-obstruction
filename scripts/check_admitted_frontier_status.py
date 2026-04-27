#!/usr/bin/env python3
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
STATUS_DOC = ROOT / "docs/status/ADMIT_INVENTORY_2026_04_27.md"
FORMAL_DOC = ROOT / "docs/status/FORMAL_STATUS_2026_04_27.md"

def lean_files():
    return [
        p for p in ROOT.rglob("*.lean")
        if ".lake" not in p.parts and ".git" not in p.parts
    ]

def count_pattern(pattern: str) -> int:
    rx = re.compile(pattern)
    total = 0
    for p in lean_files():
        total += sum(1 for line in p.read_text(encoding="utf-8", errors="ignore").splitlines() if rx.search(line))
    return total

def misleading_zero_sorry_claims() -> list[str]:
    patterns = [
        re.compile(r"zero[- ]sorr(?:y|ies)", re.IGNORECASE),
        re.compile(r"no[- ]sorr(?:y|ies)", re.IGNORECASE),
        re.compile(r"sorry[- ]free", re.IGNORECASE),
    ]
    allowed = {
        Path("docs/status/ADMIT_INVENTORY_2026_04_27.md"),
    }
    hits: list[str] = []
    for p in list(ROOT.glob("README*")) + list((ROOT / "docs").rglob("*.md")):
        rel = p.relative_to(ROOT)
        if rel in allowed:
            continue
        text = p.read_text(encoding="utf-8", errors="ignore")
        for i, line in enumerate(text.splitlines(), 1):
            if any(rx.search(line) for rx in patterns):
                hits.append(f"{rel}:{i}: {line.strip()}")
    return hits


def main() -> int:
    if not STATUS_DOC.exists():
        print(f"missing status document: {STATUS_DOC.relative_to(ROOT)}")
        return 1

    if not FORMAL_DOC.exists():
        print(f"missing formal status document: {FORMAL_DOC.relative_to(ROOT)}")
        return 1

    text = STATUS_DOC.read_text(encoding="utf-8", errors="ignore")
    formal_text = FORMAL_DOC.read_text(encoding="utf-8", errors="ignore")
    admit_count = count_pattern(r"\badmit\b")

    required = [
        "Status: Admitted Frontier / Not Verified",
        "`admit` is a proof hole",
        f"Admit count: {admit_count}",
    ]

    missing = [s for s in required if s not in text]
    if missing:
        print("admitted-frontier status check failed")
        for s in missing:
            print(f"missing: {s}")
        return 1

    formal_required = [
        "Status: Admitted Frontier / Not Verified",
        "The repository builds, but build success is not theorem verification.",
        "If `sorry + admit + axiom > 0`, no theorem-closure claim is allowed.",
    ]
    formal_missing = [s for s in formal_required if s not in formal_text]
    if formal_missing:
        print("formal theorem-status boundary check failed")
        for s in formal_missing:
            print(f"missing: {s}")
        return 1

    misleading = misleading_zero_sorry_claims()
    if admit_count > 0 and misleading:
        print("misleading zero-sorry claims remain while admits exist")
        for hit in misleading:
            print(hit)
        return 1

    print({
        "status": "PASS",
        "admit_count": admit_count,
        "status_doc": str(STATUS_DOC.relative_to(ROOT)),
        "formal_status_doc": str(FORMAL_DOC.relative_to(ROOT)),
        "misleading_zero_sorry_claims": 0,
    })
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
