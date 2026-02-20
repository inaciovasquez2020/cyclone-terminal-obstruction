# Cyclone Freeze

Tag: v1.0.0-cyclone-closed
Commit: $(git rev-parse HEAD)

Lean toolchain:
$(cat lean-toolchain)

Reproduce:
  lake update
  lake build
- Referee closure note: docs/REFEREE_CLOSURE_NOTE.md
