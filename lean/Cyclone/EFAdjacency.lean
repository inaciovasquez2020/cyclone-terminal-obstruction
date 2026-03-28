import Cyclone.EFDuplicator

namespace Cyclone

universe u

structure EFState (V : Type u) :=
  (pebbles : List V)

def adjPreserving
  {V : Type u}
  (G₀ G₁ : Graph)
  (s₀ s₁ : EFState V) : Prop :=
  ∀ i j,
    i < s₀.pebbles.length →
    j < s₀.pebbles.length →
    G₀.adj (s₀.pebbles.get ⟨i,by assumption⟩)
           (s₀.pebbles.get ⟨j,by assumption⟩)
    =
    G₁.adj (s₁.pebbles.get ⟨i,by assumption⟩)
           (s₁.pebbles.get ⟨j,by assumption⟩)

theorem adj_extension
  {V : Type u} [DecidableEq V]
  (G₀ G₁ : Graph)
  (s₀ s₁ : EFState V)
  (h : adjPreserving G₀ G₁ s₀ s₁)
  (v : V) :
  ∃ w, adjPreserving G₀ G₁
    ⟨v :: s₀.pebbles⟩
    ⟨w :: s₁.pebbles⟩ := by
  refine ⟨v, ?_⟩
  intro i j hi hj
  cases i <;> cases j <;> simp

end Cyclone
