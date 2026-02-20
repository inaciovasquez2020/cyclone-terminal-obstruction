namespace URF.Cyclone.Interfaces

-- Finite FO^k_r type bound
axiom finite_types_bound :
  ∀ (Δ k r : Nat) (G : Type), True

-- Boxed inequality interface
axiom Boxed :
  ∀ (Δ k r : Nat) (G : Type), True

-- LASR witness selector interface
axiom LASR_witness_selector :
  ∀ (Δ k r : Nat) (G : Type), True

-- Dimension bound interface
axiom dim_bound_from_LASR :
  ∀ (Δ k r : Nat) (G : Type), True

-- Transport / compilation interface
axiom LASR_from_boxed :
  ∀ (Δ k r : Nat) (G : Type), True

-- Local data invariance under partial isomorphism
axiom localData_invariant :
  ∀ (G : Type), True

end URF.Cyclone.Interfaces
