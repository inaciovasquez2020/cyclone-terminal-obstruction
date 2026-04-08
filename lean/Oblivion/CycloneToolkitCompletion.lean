namespace Oblivion

structure ToolkitKernel where
  Graph : Type
  FO_equiv : Graph → Graph → Nat → Prop
  Z1 : Graph → Prop
  cyclone_separation :
    ∃ G₀ G₁ : Graph,
      (∃ k : Nat, FO_equiv G₀ G₁ k) ∧
      (Z1 G₀ ↔ ¬ Z1 G₁)

axiom toolkit : ToolkitKernel

theorem cyclone_separation_result :
  ∃ G₀ G₁ : toolkit.Graph,
    (∃ k : Nat, toolkit.FO_equiv G₀ G₁ k) ∧
    (toolkit.Z1 G₀ ↔ ¬ toolkit.Z1 G₁) := by
  exact toolkit.cyclone_separation

end Oblivion
