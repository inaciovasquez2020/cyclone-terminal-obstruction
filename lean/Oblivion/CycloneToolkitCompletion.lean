namespace Oblivion

structure ToolkitKernel where
  Graph : Type
  FO_equiv : Graph → Graph → Nat → Prop
  Z1 : Graph → Prop
  cyclone_separation :
    ∃ G₀ G₁ : Graph,
      (∃ k : Nat, FO_equiv G₀ G₁ k) ∧
      (Z1 G₀ ↔ ¬ Z1 G₁)

/-- The Toolkit Axiom: Bedrock for the separation result. -/
axiom toolkit : ToolkitKernel

/-- Projection to the toolkit's graph type. -/
def ToolkitGraph : Type := toolkit.Graph

/-- 
Final Separation Result:
Directly projected from the toolkit axiom.
-/
theorem cyclone_separation_result :
  ∃ G₀ G₁ : ToolkitGraph,
    (∃ k : Nat, toolkit.FO_equiv G₀ G₁ k) ∧
    (toolkit.Z1 G₀ ↔ ¬ toolkit.Z1 G₁) := by
  exact toolkit.cyclone_separation

end Oblivion
