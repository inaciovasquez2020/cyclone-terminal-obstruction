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
