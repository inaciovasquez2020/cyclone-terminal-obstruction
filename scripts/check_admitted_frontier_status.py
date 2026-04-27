#!/usr/bin/env python3
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
STATUS_DOC = ROOT / "docs/status/ADMIT_INVENTORY_2026_04_27.md"

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

def main() -> int:
    if not STATUS_DOC.exists():
        print(f"missing status document: {STATUS_DOC.relative_to(ROOT)}")
        return 1

    text = STATUS_DOC.read_text(encoding="utf-8", errors="ignore")
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

    print({
        "status": "PASS",
        "admit_count": admit_count,
        "status_doc": str(STATUS_DOC.relative_to(ROOT)),
    })
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
