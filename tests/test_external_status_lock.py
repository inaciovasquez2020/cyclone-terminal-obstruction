from pathlib import Path
import subprocess
import sys

def test_external_status_lock_present():
    p = Path("docs/status/EXTERNAL_STATUS_LOCK.md")
    assert p.exists()
    text = p.read_text(encoding="utf-8")
    assert "not theorem proofs" in text
    assert "does not upgrade conditional mathematics" in text
    assert "Forbidden public description:" in text

def test_external_status_lock_verifier_passes():
    script = Path("scripts/verify_external_status_lock.py")
    assert script.exists()
    result = subprocess.run(
        [sys.executable, str(script)],
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    assert result.returncode == 0, result.stdout
