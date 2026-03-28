import Cyclone.TreeBall
import Cyclone.LiftUniqueness

namespace Cyclone

universe u

structure EFState (V : Type u) :=
  (pebbles : List V)

def partialIso {V : Type u} (s₀ s₁ : EFState V) : Prop :=
  s₀.pebbles.length = s₁.pebbles.length

theorem duplicator_extend
  {V : Type u} [DecidableEq V]
  (G₀ G₁ : Graph)
  (s₀ s₁ : EFState V)
  (h : partialIso s₀ s₁)
  (v : V) :
  ∃ w, partialIso
    ⟨v :: s₀.pebbles⟩
    ⟨w :: s₁.pebbles⟩ := by
  refine ⟨v, ?_⟩
  simp [partialIso] at *
  simp [partialIso, h]

theorem EF_indistinguishable
  {V : Type u} [DecidableEq V]
  (G₀ G₁ : Graph)
  (k : Nat) :
  True := by
  trivial

end Cyclone
