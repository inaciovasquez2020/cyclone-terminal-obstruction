import Cyclone.EFAdjacency
import Cyclone.Ball
import Cyclone.RootedBallAdj

namespace Cyclone

universe u

def adjPreservingR
  {V : Type u}
  (G₀ G₁ : Graph)
  (R : Nat)
  (v₀ v₁ : V)
  (s₀ s₁ : EFState V) : Prop :=
  ∀ i j,
    i < s₀.pebbles.length →
    j < s₀.pebbles.length →
    s₀.pebbles.get ⟨i,by assumption⟩ ∈ ball G₀ v₀ R →
    s₀.pebbles.get ⟨j,by assumption⟩ ∈ ball G₀ v₀ R →
    G₀.adj (s₀.pebbles.get ⟨i,by assumption⟩)
           (s₀.pebbles.get ⟨j,by assumption⟩)
    =
    G₁.adj (s₁.pebbles.get ⟨i,by assumption⟩)
           (s₁.pebbles.get ⟨j,by assumption⟩)

theorem EF_radius_extend
  {V : Type u} [DecidableEq V]
  (G₀ G₁ : Graph)
  (R : Nat)
  (v₀ v₁ : V)
  (s₀ s₁ : EFState V)
  (h : adjPreservingR G₀ G₁ R v₀ v₁ s₀ s₁)
  (x : V) :
  ∃ y, adjPreservingR G₀ G₁ R v₀ v₁
    ⟨x :: s₀.pebbles⟩
    ⟨y :: s₁.pebbles⟩ := by
  refine ⟨x, ?_⟩
  intro i j hi hj hiR hjR
  cases i <;> cases j <;> simp

end Cyclone
