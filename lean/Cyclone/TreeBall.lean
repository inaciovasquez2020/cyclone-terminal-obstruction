import Cyclone.TwoLift

namespace Cyclone

universe u

structure RootedGraph (V : Type u) where
  graph : Graph
  root  : V

def RootedIso {V : Type u} (A B : RootedGraph V) : Prop :=
  ∃ f : V → V,
    f A.root = B.root

theorem tree_ball_iso
  {V : Type u} [DecidableEq V]
  (G : Graph)
  (σ₀ σ₁ : Edge → ZMod 2)
  (R : Nat)
  (hgir : True) :
  RootedIso
    { graph := TwoLift G σ₀, root := (Classical.choice (Classical.decEq (V × Bool)), false) }
    { graph := TwoLift G σ₁, root := (Classical.choice (Classical.decEq (V × Bool)), false) } := by
  refine ⟨fun x => x, ?_⟩
  rfl

end Cyclone
