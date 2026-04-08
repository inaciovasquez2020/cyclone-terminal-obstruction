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
  map_add' := theorem boundaryMap_cycle_eq_zero {G : Graph V E} (σ : Cycle G) :
  boundaryMap σ = 0 := by
  ext v
  unfold boundaryMap
  -- In ZMod 2, the boundary sum at v is (degree v) % 2
  -- Cycles have even degree at every vertex, hence 0 in ZMod 2.
  simp [Cycle.degree_even, ZMod.eq_zero_iff_even]