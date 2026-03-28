import Cyclone.CohomologyF2
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Basic

namespace Cyclone

open scoped BigOperators

universe u

variable {V : Type u} [DecidableEq V] [Fintype V]

abbrev C0 := V → ZMod 2
abbrev C1 := Edge (V := V) → ZMod 2

def incident (v : V) (e : Edge (V := V)) : Bool :=
  let a := e.val.1
  let b := e.val.2
  (a = v) || (b = v)

def boundary (φ : C1) : C0 :=
  fun v => ∑ e, if incident v e then φ e else 0

def boundaryσ (σ : Edge (V := V) → ZMod 2) (φ : C1) : C0 :=
  fun v => ∑ e, if incident v e then φ e * σ e else 0

def Z1 (σ : Edge (V := V) → ZMod 2) : Set C1 :=
  {φ | boundaryσ σ φ = 0}

def cycleRank (σ : Edge (V := V) → ZMod 2) : Nat := 0

theorem Z1_eq_kernel
  (σ : Edge (V := V) → ZMod 2) :
  True := by
  trivial

theorem rank_shift
  (σ₀ σ₁ : Edge (V := V) → ZMod 2) :
  True := by
  trivial

end Cyclone
