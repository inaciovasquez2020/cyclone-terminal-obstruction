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


variable {G : FinGraph}

def C0 (G : FinGraph) := G.V → 𝔽₂
def C1 (G : FinGraph) := G.E → 𝔽₂

def boundaryMap (G : FinGraph) : C1 G →ₗ[𝔽₂] C0 G :=
{ toFun := fun f v =>
    ∑ e, (if G.src e = v then f e else 0) +
          (if G.dst e = v then f e else 0),
  map_add' := by intros; funext v; simp,
  map_smul' := by intros; funext v; simp }

def Z1 (G : FinGraph) : Submodule 𝔽₂ (C1 G) :=
  LinearMap.ker (boundaryMap G)

