from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

REQUIRED = [
    ROOT / "docs" / "elMTe" / "ELMTE_SPEC.md",
    ROOT / "proofs" / "elMTe" / "ELMTE_FRONTIER_2026_04.md",
]

def main() -> int:
    missing = [str(p.relative_to(ROOT)) for p in REQUIRED if not p.exists()]
    if missing:
        print("MISSING:")
        for m in missing:
            print(m)
        return 1
    print("PASS: ElMTe frontier files present")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
