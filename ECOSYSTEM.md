# Cyclone Ecosystem Map (One Page)

This document provides a compact mental model of how Cyclone fits into the URF / Chronos program.
It is conceptual, not a dependency graph.

## Logical reduction (top → bottom)

    Foundational Axioms
    (URF, locality, FOᵏ)
              ↓
    EntropyDepth / Chronos
    (refinement limits)
              ↓
    Configuration Locality
    (EF games, pumping)
              ↓
    Cyclone Obstruction
    (overlap-rank B₀)

Cyclone is the unique terminal bottleneck in this chain.

## Resolution directions (bottom → outward)

              Cyclone
                │
        ┌───────┴────────┐
        ↓                ↓
    Falsifiers       Conditional
    (EF solvers,     Consequences
     small graphs)   (lower bounds)

- Bottom → left: explicit falsification attempts
- Bottom → right: conditional consequences if Cyclone holds

## Interpretation

- All upstream work reduces to Cyclone.
- No downstream claim bypasses it.
- Failure, if any, must occur here.

Cyclone is the wall, not the proof.
