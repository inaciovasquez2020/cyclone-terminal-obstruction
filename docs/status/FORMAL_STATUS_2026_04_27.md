# Formal Status — 2026-04-27

Status: Admitted Frontier / Not Verified

## Build status

The repository builds, but build success is not theorem verification.

## Theorem status

This repository currently contains admitted proof obligations.

- `sorry` count is not the controlling metric.
- `admit` is a proof hole.
- Any theorem depending on admitted terms is not verified.
- No theorem depending on admitted terms should be described as proved, closed, final, terminal, or machine-verified.

## Current status

- Current classification: Admitted Frontier / Not Verified
- Strongest verified theorem: none asserted at repository level
- Weakest missing theorem: discharge or quarantine every admitted proof obligation
- Frontier inventory: `docs/status/ADMIT_INVENTORY_2026_04_27.md`

## Boundary rule

If `sorry + admit + axiom > 0`, no theorem-closure claim is allowed.
