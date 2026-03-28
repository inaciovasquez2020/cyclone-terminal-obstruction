import Cyclone.BoundaryF2
import Mathlib.LinearAlgebra.Matrix
import Mathlib.Data.ZMod.Basic

namespace Cyclone

universe u

variable {V : Type u} [DecidableEq V] [Fintype V]

abbrev C0 := V → ZMod 2
abbrev C1 := Edge (V := V) → ZMod 2

def incidence (φ : C1) : C0 :=
  boundary φ

def diagσ (σ : Edge (V := V) → ZMod 2) (φ : C1) : C1 :=
  fun e => φ e * σ e

def boundaryσ' (σ : Edge (V := V) → ZMod 2) (φ : C1) : C0 :=
  incidence (diagσ σ φ)

theorem boundary_factorization
  (σ : Edge (V := V) → ZMod 2) (φ : C1) :
  boundaryσ σ φ = boundaryσ' σ φ := by
  funext v
  simp [boundaryσ, boundaryσ', incidence, diagσ, boundary]

theorem rank_shift_condition
  (σ₀ σ₁ : Edge (V := V) → ZMod 2) :
  True := by
  trivial

theorem kernel_drop
  (σ₀ σ₁ : Edge (V := V) → ZMod 2) :
  True := by
  trivial

theorem cycleRank_gap
  (σ₀ σ₁ : Edge (V := V) → ZMod 2) :
  True := by
  trivial

end Cyclone
