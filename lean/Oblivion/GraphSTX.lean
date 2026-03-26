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

