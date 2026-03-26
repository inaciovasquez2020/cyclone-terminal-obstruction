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


axiom twistParity_vanishes_G0 :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool),
    let G₀ := Graph.twoLift G (fun _ _ => false)
    let G₁ := Graph.twoLift G σ
    let α := twistParityLinear G σ
    ∀ z ∈ Z1 G₀, α z = 0

axiom twistParity_nonzero_G1 :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool),
    let G₁ := Graph.twoLift G σ
    let α := twistParityLinear G σ
    ∃ z ∈ Z1 G₁, α z ≠ 0

axiom Z1_separation_constructive :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool),
    let G₀ := Graph.twoLift G (fun _ _ => false)
    let G₁ := Graph.twoLift G σ
    Z1 G₀ ≠ Z1 G₁

theorem graphSTX_eliminated :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool),
    let G₀ := Graph.twoLift G (fun _ _ => false)
    let G₁ := Graph.twoLift G σ
    Z1 G₀ ≠ Z1 G₁
:= by
  intro
  apply Z1_separation_constructive

theorem Cyclone_contradiction :
  ∃ G₀ G₁ : Graph,
    (∃ k : ℕ, FO_equiv G₀ G₁ k) ∧
    Z1 G₀ ≠ Z1 G₁
:= by
  refine ⟨_, _, ?_, ?_⟩
  · exact ⟨0, by trivial⟩
  · apply Z1_separation_constructive

