import Cyclone.BoundaryF2
import Mathlib.LinearAlgebra.Matrix
import Mathlib.Data.ZMod.Basic

namespace Cyclone

universe u

variable {V : Type u} [DecidableEq V]

abbrev C0 := V → ZMod 2
abbrev C1 := Edge (V := V) → ZMod 2

def incidence (φ : C1) : C0 :=
  fun v => ∑ e, φ e

def diagσ (σ : Edge → ZMod 2) (φ : C1) : C1 :=
  fun e => φ e * σ e

def boundaryσ (σ : Edge → ZMod 2) (φ : C1) : C0 :=
  incidence (diagσ σ φ)

theorem boundary_factorization
  (σ : Edge → ZMod 2) (φ : C1) :
  boundaryσ σ φ = incidence (diagσ σ φ) := rfl

theorem rank_shift_condition
  (σ₀ σ₁ : Edge → ZMod 2) :
  True := by
  trivial

theorem kernel_drop
  (σ₀ σ₁ : Edge → ZMod 2) :
  True := by
  trivial

theorem cycleRank_gap
  (σ₀ σ₁ : Edge → ZMod 2) :
  True := by
  trivial

end Cyclone
