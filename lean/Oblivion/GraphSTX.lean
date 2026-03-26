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


axiom graphSTX_parity_separation :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool),
    graphSTX G →
    let G₀ := Graph.twoLift G (fun _ _ => false)
    let G₁ := Graph.twoLift G σ
    ∃ (α : C1 G₁ →ₗ[𝔽₂] 𝔽₂),
      α ≠ 0 ∧
      α vanishesOn (Z1 G₀) ∧
      ¬ α vanishesOn (Z1 G₁)


axiom twistParityLinear :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool),
    C1 (Graph.twoLift G σ) →ₗ[𝔽₂] 𝔽₂


axiom twistParityFactors :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool),
    ∃ (α : (C1 (Graph.twoLift G σ) ⧸ Z1 (Graph.twoLift G σ)) →ₗ[𝔽₂] 𝔽₂),
      True

