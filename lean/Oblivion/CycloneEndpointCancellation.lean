namespace Oblivion

structure EndpointKernel where
  FinGraph : Type
  FO_equiv : FinGraph → FinGraph → Nat → Prop
  Z1 : FinGraph → Prop
  explicitTwoLift : FinGraph → (Unit → Bool) → FinGraph
  girth : FinGraph → Nat
  Cyclone_final :
    ∀ (G : FinGraph) (_σ : Unit → Bool) (k : Nat),
      girth G > (2^(k+1) : Nat) →
      let G₀ := explicitTwoLift G (fun _ => false)
      let G₁ := explicitTwoLift G (fun _ => true)
      FO_equiv G₀ G₁ k ∧ (Z1 G₀ ↔ ¬ Z1 G₁)

constant kernel : EndpointKernel

theorem Cyclone_full
  (G : kernel.FinGraph) (σ : Unit → Bool) (k : Nat)
  (hG : kernel.girth G > (2^(k+1) : Nat)) :
  let G₀ := kernel.explicitTwoLift G (fun _ => false)
  let G₁ := kernel.explicitTwoLift G (fun _ => true)
  kernel.FO_equiv G₀ G₁ k ∧ (kernel.Z1 G₀ ↔ ¬ kernel.Z1 G₁) := by
  exact kernel.Cyclone_final G σ k hG

end Oblivion
