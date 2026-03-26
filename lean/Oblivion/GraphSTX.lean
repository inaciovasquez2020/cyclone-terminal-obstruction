import Oblivion.CycloneCore

axiom graphSTX : Graph → Prop

axiom graphSTX_lift_invariant :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool),
    graphSTX G →
    graphSTX (Graph.twoLift G σ)

axiom graphSTX_locality :
  ∀ (G : Graph) (R : ℕ) (v : G.V),
    graphSTX G →
    graphSTX (Graph.inducedSubgraph G (Graph.ball G R v))


axiom graphSTX_cycle_bridge :
  ∀ (G : Graph),
    graphSTX G →
    ∃ (α : C1 G →ₗ[𝔽₂] 𝔽₂),
      α ≠ 0 ∧
      α vanishesOn (Z1 G)

axiom graphSTX_twist_separation :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool),
    graphSTX G →
    let G₁ := Graph.twoLift G σ
    ∃ (α : C1 G₁ →ₗ[𝔽₂] 𝔽₂),
      α ≠ 0

