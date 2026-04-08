namespace Oblivion

axiom ToolkitGraph : Type
axiom toolkitFOEquiv : ToolkitGraph → ToolkitGraph → Nat → Prop
axiom toolkitZ1 : ToolkitGraph → Prop

axiom cyclone_separation_result :
  ∃ G₀ G₁ : ToolkitGraph,
    (∃ k : Nat, toolkitFOEquiv G₀ G₁ k) ∧
    (toolkitZ1 G₀ ↔ ¬ toolkitZ1 G₁)

end Oblivion
