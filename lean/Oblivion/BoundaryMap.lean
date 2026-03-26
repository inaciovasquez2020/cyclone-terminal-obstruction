import Mathlib.LinearAlgebra.Finrank
import Mathlib.Data.Finsupp.Basic

open FiniteDimensional

structure FinGraph where
  V : Type*
  E : Type*
  src : E → V
  dst : E → V

variable (Γ : FinGraph)

abbrev C0 := Γ.V →₀ ℚ
abbrev C1 := Γ.E →₀ ℚ

noncomputable def boundaryMap : C1 Γ →ₗ[ℚ] C0 Γ :=
  0

noncomputable def beta1 : ℕ :=
  finrank ℚ (LinearMap.ker (boundaryMap Γ))

class FinGraph extends Graph where
  E : Type u
  src : E → V
  dst : E → V
  finite_V : Fintype V
  finite_E : Fintype E
  decEq_V : DecidableEq V
  decEq_E : DecidableEq E
  adj_iff :
    ∀ u v : V, Adj u v ↔ ∃ e : E, (src e = u ∧ dst e = v) ∨ (src e = v ∧ dst e = u)

