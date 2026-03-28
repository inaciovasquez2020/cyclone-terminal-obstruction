import Cyclone.BoundaryF2
import Mathlib.LinearAlgebra.Dimension

namespace Cyclone

universe u

variable {V : Type u} [DecidableEq V]

noncomputable def cycleRank (σ : Edge → ZMod 2) : Nat :=
  FiniteDimensional.finrank (ZMod 2) {φ : C1 | boundaryσ σ φ = 0}

theorem Z1_eq_kernel
  (σ : Edge → ZMod 2) :
  {φ : C1 | boundaryσ σ φ = 0} =
  LinearMap.ker (LinearMap.mk
    (fun φ => boundaryσ σ φ)
    (by intros; funext v; simp)
    (by intros; funext v; simp)) := by
  rfl

end Cyclone
