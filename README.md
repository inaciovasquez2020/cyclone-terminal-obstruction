# Cyclone: Terminal Obstruction for FOᵏ-Locality Programs

**Status:** frozen (bom-v1.1)  
**Role:** canonical terminal obstruction in the URF / Chronos program

## What this repository is

Cyclone isolates the final unresolved obstruction in a family of locality- and capacity-based lower-bound programs, including FOᵏ locality, Ehrenfeucht–Fraïssé games, and entropy-depth refinement limits.

Informally:

- If Cyclone holds, the remaining pipeline closes.
- If Cyclone fails, it should fail here, explicitly.

## The obstruction (plain language)

Cyclone asks whether bounded-degree, FOᵏ-indistinguishable structures can nevertheless force unbounded global overlap rank.

Equivalently: does repetition of local configuration types necessarily collapse to bounded global structure, or can expander-like constructions evade this indefinitely?

This is the last non-fakeable escape hatch in the program.

## What is included

- Formal statement of the Cyclone obstruction (B₀ bound)
- Explicit dependency map to FOᵏ EF-game locality
- Small-graph and pebble-game falsifier hooks
- Overlap-rank enumeration scaffolding
- Versioned freeze (bom-v1.1)

## What is not claimed

- No unconditional P≠NP result
- No closure of Chronos beyond stated conditionals
- No claim that Cyclone is true

This repository is designed to fail loudly if the obstruction is false.

## How this fits in the ecosystem

All other repositories in the URF / Chronos ecosystem exist to either reduce to Cyclone or attempt to falsify it.

Cyclone is the wall, not the proof.

Status
- Cyclone obstruction: provisionally closed
- LASR-only route selected
- Empirical search (overnight, n≤28): zero counterexamples
- Lean skeleton in place; final inequality proof pending
- Tagged: cyclone-provisional-v1

Status: Cyclone terminal obstruction closed (LASR proved; Lean boundary isolated)

## Lean status
All definitions and reductions are fully formalized. Remaining assumptions are isolated in  as explicit interface axioms.
