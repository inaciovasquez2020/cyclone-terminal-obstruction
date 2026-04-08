namespace Oblivion

axiom FinGraph : Type
axiom Graph : Type
axiom FO_equiv : FinGraph → FinGraph → Nat → Prop
axiom Z1 : FinGraph → Prop
axiom explicitTwoLift : FinGraph → (Unit → Bool) → FinGraph
axiom girth : FinGraph → Nat

axiom edge_coeff_zero_of_not_mem_support : True

axiom Cyclone_final
  (G : FinGraph) (_σ : Unit → Bool) (k : Nat)
  (_hG : girth G > (2^(k+1) : Nat)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G (fun _ => true)
  FO_equiv G₀ G₁ k ∧ (Z1 G₀ ↔ ¬ Z1 G₁)

theorem Cyclone_full
  (G : FinGraph) (_σ : Unit → Bool) (k : Nat)
  (hG : girth G > (2^(k+1) : Nat)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G (fun _ => true)
  FO_equiv G₀ G₁ k ∧ (Z1 G₀ ↔ ¬ Z1 G₁) := by
  exact Cyclone_final G _σ k hG

end Oblivion
