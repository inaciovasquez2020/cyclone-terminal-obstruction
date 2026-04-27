import subprocess
import sys

def test_admitted_frontier_status_guard_passes():
    subprocess.run(
        [sys.executable, "scripts/check_admitted_frontier_status.py"],
        check=True,
    )
