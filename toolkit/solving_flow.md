# Solving Flow (Toolkit Action)

## Definition

A **Solving Flow** is a deterministic, layered construction pipeline that converts:
- abstract invariants → explicit algebraic objects → executable proofs → closure theorems

Each step must:
1. Introduce exactly one structural object
2. Immediately integrate it into the proof chain
3. Eliminate one dependency (axiom / admit / placeholder)

---

## Core Pipeline

### Stage 1 — Structural Encoding
- Define concrete representations
  - Graph → FinGraph
  - Chains: C0, C1
  - Boundary map ∂
  - Cycle space Z1 = ker ∂

### Stage 2 — Local Collapse
- Prove:
  - girth ⇒ local acyclicity
  - Z1(B_R) = ⊥
  - localSpan = ⊥
  - local rank = 0

### Stage 3 — Constructive Basis
- Build:
  - spanningTree (BFS)
  - parentEdgeList
  - treePathChain
- Define:
  - fundamentalCycle = edge + tree path
- Prove:
  - fundamentalCycle ∈ Z1
  - fundamental cycles span Z1

### Stage 4 — Functional Extraction
- Define:
  - α : C1 → 𝔽₂ via parity
- Prove:
  - linearity
  - basis-independence
  - α|Z1(G₀)=0
  - α|Z1(G₁)≠0

### Stage 5 — EF Synchronization
- Construct:
  - BFS tree isomorphism
- Extend:
  - PartialIso via local matching
- Conclude:
  - FO^k equivalence

### Stage 6 — Contradiction Closure
- Combine:
  - FO_equiv(G₀,G₁)
  - Z1(G₀) ≠ Z1(G₁)
- Output:
  - Cyclone contradiction theorem

---

## Execution Rules

- One micro-step per commit
- No stacking fixes
- Replace constants immediately after constructive version exists
- Every lemma must:
  - reduce dependencies OR
  - expose a new invariant

---

## Termination Condition

Flow halts when:
- All admits removed
- All axioms replaced OR isolated into a single minimal lemma
- Final theorem is executable and composable

---

## Diagnostic Signal

If no new invariant / reduction occurs:

> No further progress possible without new input.

---

## Reusability

Applicable to:
- Cyclone / Chronos
- Yang–Mills gap (coercivity extraction)
- Navier–Stokes IECP (conditional closure)
- Hodge bounded witness
- Any URF pipeline

