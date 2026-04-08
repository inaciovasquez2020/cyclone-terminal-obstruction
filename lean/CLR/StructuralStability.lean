namespace CLR

structure StructuralStabilityKernel where
  LocalRigidityMap : Nat → Type
  HS_Coercivity_Operator : Nat → ((Rat → Rat) → Prop)
  hs_coercivity_bound :
    ∀ (n : Nat), n ≤ 7 →
    ∃ (f : Rat → Rat), HS_Coercivity_Operator n f
  bounded_structural_closure :
    ∀ (n : Nat), n ≤ 7 → Nonempty (LocalRigidityMap n)

constant stabilityKernel : StructuralStabilityKernel

theorem bounded_structural_closure
  (n : Nat) (h : n ≤ 7) :
  Nonempty (stabilityKernel.LocalRigidityMap n) := by
  exact stabilityKernel.bounded_structural_closure n h

end CLR
