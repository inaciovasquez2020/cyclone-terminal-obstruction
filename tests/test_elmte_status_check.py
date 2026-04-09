from pathlib import Path

def test_elmte_files_present():
    root = Path(__file__).resolve().parents[1]
    assert (root / "docs" / "elMTe" / "ELMTE_SPEC.md").exists()
    assert (root / "proofs" / "elMTe" / "ELMTE_FRONTIER_2026_04.md").exists()
