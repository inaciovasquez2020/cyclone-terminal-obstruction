#!/usr/bin/env python3
from pathlib import Path
import re
import sys

status = Path("docs/status/EXTERNAL_STATUS_LOCK.md")
if not status.exists():
    raise SystemExit("missing docs/status/EXTERNAL_STATUS_LOCK.md")

text = status.read_text(encoding="utf-8")

required = [
    "Axioms, admits, `sorry`, placeholder witnesses, string witnesses, dashboards, ledgers, and narrative wrappers are not theorem proofs.",
    "CI/build success means the checked surface compiles or verifies; it does not upgrade conditional mathematics into theorem-level closure.",
    "Any result depending on an axiom, admit, `sorry`, synthetic placeholder, or explicitly named missing lemma is conditional.",
    "Forbidden public description:",
]

for s in required:
    if s not in text:
        raise SystemExit(f"missing required status boundary: {s}")

readme_paths = [Path("README.md"), Path("README"), Path("readme.md")]
readme_text = "\n".join(p.read_text(encoding="utf-8", errors="ignore") for p in readme_paths if p.exists())

dangerous_patterns = [
    r"\bwe prove the Riemann Hypothesis\b",
    r"\bwe prove RH\b",
    r"\bwe prove P\s*(?:!=|≠)\s*NP\b",
    r"\bwe prove the Hodge Conjecture\b",
    r"\bwe prove (?:BSD|Birch[-– ]Swinnerton[-– ]Dyer)\b",
    r"\bwe prove Navier[-– ]Stokes\b",
    r"\bwe prove Yang[-– ]Mills\b",
    r"\bwe prove the mass gap\b",
    r"\bwe solve the Clay\b",
    r"\bMillennium Prize solution\b",
    r"\bunconditional solution\b",
    r"\btheorem-complete solution\b",
]

for pat in dangerous_patterns:
    if re.search(pat, readme_text, flags=re.IGNORECASE):
        raise SystemExit(f"dangerous README claim matched: {pat}")

print("external status lock: PASS")
