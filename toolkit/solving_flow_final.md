# Solving Flow — Finalized Toolkit Action

## Status
FINALIZED / CANONICAL / REUSABLE

---

## Definition

A **Solving Flow** is a deterministic construction pipeline that converts:

    abstract invariants → explicit algebra → executable proofs → contradiction/closure

All steps are:
- local
- composable
- dependency-reducing

---

## Full Pipeline (Canonical Form)

### Stage 1 — Structural Encoding
- Replace abstractions with concrete objects:
  - Graph → FinGraph
  - C0, C1 chain spaces
  - boundaryMap (explicit)
  - Z1 := ker(boundaryMap)

---

### Stage 2 — Local Collapse (Rigidity Trigger)
- Prove:
  - girth > 2R ⇒ Z1(B_R) = ⊥
  - localSpan = ⊥
  - local rank = 0

→ Result: no local cycles → purely tree structure

---

### Stage 3 — Constructive Basis
- Build explicitly:
  - BFS spanning tree
  - parent pointers
  - treePathChain
- Define:
  - fundamentalCycle = edge + tree path

- Prove:
  - fundamentalCycle ∈ Z1
  - fundamental cycles span Z1

---

### Stage 4 — Functional Extraction (Invariant Layer)
- Define:
  - α : C1 → 𝔽₂ via parity over twist edges

- Prove:
  - linearity
  - independence of basis
  - α vanishes on trivial lift
  - α nonzero on twisted lift

→ Result: invariant separating global structure

---

### Stage 5 — EF Synchronization (Local Indistinguishability)
- Construct:
  - BFS tree isomorphism
- Extend:
  - PartialIso step-by-step
- Conclude:
  - FO^k indistinguishability

---

### Stage 6 — Contradiction Closure
Combine:

    FO_equiv(G₀,G₁)
    +
    Z1(G₀) ≠ Z1(G₁)

→ Cyclone contradiction

---

## Execution Laws

1. One structural addition per step
2. Immediate integration into proof chain
3. Immediate elimination of replaced abstraction
4. No stacked fixes
5. Every lemma must:
   - reduce entropy OR
   - expose invariant

---

## Terminal Condition

Flow is complete when:

- All admits = removed
- All axioms = eliminated or isolated to one irreducible lemma
- Final theorem = executable + composable

---

## Residual Classification

If remaining gap is:

    mechanical expansion + cancellation

→ problem is **closed structurally**

---

## Diagnostic Signal

If no new invariant / reduction:

    No further progress possible without new input.

---

## Canonical Use Cases

- Cyclone (FO^k vs cycle space)
- Chronos / EntropyDepth
- Yang–Mills (coercivity extraction)
- Navier–Stokes (IECP closure)
- Hodge bounded witness
- General URF pipelines

---

## Classification

Type: Deterministic Proof Compiler  
Layer: Tier-0 Toolkit  
Status: Frozen Canonical  

