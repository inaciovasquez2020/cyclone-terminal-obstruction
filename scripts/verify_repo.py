#!/usr/bin/env python3
from pathlib import Path
import sys

required = [
    "README.md",
    "STATUS.md",
    "CITATION.cff",
    "README.sha256",
    "ECOSYSTEM.md",
    "lean-toolchain",
    "lakefile.lean",
]

missing = [p for p in required if not Path(p).exists()]
if missing:
    print({"valid": False, "missing": missing})
    sys.exit(1)

checks = {}

readme = Path("README.md").read_text(errors="ignore").lower()
checks["mentions_cyclone"] = "cyclone" in readme
checks["mentions_terminal_obstruction"] = "terminal obstruction" in readme

status = Path("STATUS.md").read_text(errors="ignore").lower()
checks["status_mentions_status"] = (
    "status" in status or "freeze" in status or "canonical" in status
)

ecosystem = Path("ECOSYSTEM.md").read_text(errors="ignore").lower()
checks["ecosystem_nonempty"] = len(ecosystem.strip()) > 0

failed = [k for k, v in checks.items() if not v]
if failed:
    print({"valid": False, "failed_checks": failed, "checks": checks})
    sys.exit(1)

print({"valid": True, "checked": required, "checks": checks})
