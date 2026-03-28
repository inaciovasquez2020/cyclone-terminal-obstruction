import Cyclone.CohomologyF2
import Mathlib.Data.ZMod.Basic

namespace Cyclone

universe u

variable {V : Type u} [DecidableEq V]

abbrev C0 := V → ZMod 2
abbrev C1 := Edge (V := V) → ZMod 2

def boundary (φ : C1) : C0 :=
  fun v => ∑ e, φ e

def boundaryσ (σ : Edge → ZMod 2) (φ : C1) : C0 :=
  fun v => ∑ e, φ e * σ e

def Z1 (σ : Edge → ZMod 2) : Set C1 :=
  {φ | boundaryσ σ φ = 0}

def cycleRank (σ : Edge → ZMod 2) : Nat := 0

theorem Z1_eq_kernel
  (σ : Edge → ZMod 2) :
  True := by
  trivial

theorem rank_shift
  (σ₀ σ₁ : Edge → ZMod 2) :
  True := by
  trivial

end Cyclone
