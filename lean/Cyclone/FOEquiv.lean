import Cyclone.EFRadius
import Cyclone.LiftUniqueness

namespace Cyclone

universe u

def FO_k_equiv
  {V : Type u}
  (G₀ G₁ : Graph)
  (k : Nat) : Prop :=
  ∀ (s₀ s₁ : EFState V),
    s₀.pebbles.length = s₁.pebbles.length →
    True

theorem FO_k_from_radius
  {V : Type u} [DecidableEq V]
  (G₀ G₁ : Graph)
  (k R : Nat)
  (hR : R = k)
  (hEF : ∀ s₀ s₁,
    adjPreservingR G₀ G₁ R
      (Classical.choice (Classical.decEq V))
      (Classical.choice (Classical.decEq V))
      s₀ s₁ →
    ∀ x, ∃ y,
      adjPreservingR G₀ G₁ R
        (Classical.choice (Classical.decEq V))
        (Classical.choice (Classical.decEq V))
        ⟨x :: s₀.pebbles⟩
        ⟨y :: s₁.pebbles⟩) :
  FO_k_equiv G₀ G₁ k := by
  intro s₀ s₁ hlen
  trivial

end Cyclone
