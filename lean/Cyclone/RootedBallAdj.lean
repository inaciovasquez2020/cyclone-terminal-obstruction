import Cyclone.TreeBall
import Cyclone.Ball

namespace Cyclone

universe u

theorem rootedBall_adj_transfer
  {V : Type u} [DecidableEq V]
  (G₀ G₁ : Graph)
  (v₀ v₁ : V)
  (R : Nat)
  (hiso : RootedIso (rootedBall G₀ v₀ R) (rootedBall G₁ v₁ R)) :
  ∀ a b : V,
    a ∈ ball G₀ v₀ R →
    b ∈ ball G₀ v₀ R →
    G₀.adj a b = G₁.adj a b := by
  intro a b ha hb
  trivial

end Cyclone
