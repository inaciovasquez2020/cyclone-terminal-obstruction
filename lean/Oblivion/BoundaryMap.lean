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


theorem girth_gt_2R_local_acyclic
  (G : FinGraph) (R : ℕ) (v : G.V)
  (h : Graph.girth G > (2 * R : ℕ)) :
  Z1 (inducedSubgraph G (ball G R v)) = ⊥
:= by
  admit

def localSpan (G : FinGraph) (R : ℕ) (v : G.V) :=
  Submodule.span 𝔽₂ {f : C1 G | f ∈ Z1 (inducedSubgraph G (ball G R v))}

theorem localSpan_trivial
  (G : FinGraph) (R : ℕ) (v : G.V)
  (h : Graph.girth G > (2 * R : ℕ)) :
  localSpan G R v = ⊥
:= by
  admit

def explicitTwoLift (G : FinGraph) (σ : G.E → Bool) : FinGraph :=
{ V := G.V × Bool,
  E := G.E × Bool,
  src := fun ⟨e,b⟩ => (G.src e, b),
  dst := fun ⟨e,b⟩ => (G.dst e, bxor b (σ e)),
  finite_V := inferInstance,
  finite_E := inferInstance,
  decEq_V := inferInstance,
  decEq_E := inferInstance,
  Adj := fun x y =>
    ∃ e b, ((G.src e, b) = x ∧ (G.dst e, bxor b (σ e)) = y) ∨
           ((G.dst e, bxor b (σ e)) = x ∧ (G.src e, b) = y),
  adj_iff := by intro; constructor <;> intro <;> trivial }

def I (G : FinGraph) : ℕ :=
  Module.rank 𝔽₂ (Z1 G)

theorem I_separates_lifts
  (G : FinGraph) (σ : G.E → Bool) :
  I (explicitTwoLift G (fun _ => false)) ≠ I (explicitTwoLift G σ)
:= by
  admit


theorem localSpan_eq_bot_of_Z1_eq_bot
  (G : FinGraph) (R : ℕ) (v : G.V)
  (hZ : Z1 (inducedSubgraph G (ball G R v)) = ⊥) :
  localSpan G R v = ⊥
:= by
  unfold localSpan
  subst hZ
  simp


theorem girth_localSpan_trivial
  (G : FinGraph) (R : ℕ) (v : G.V)
  (h : Graph.girth G > (2 * R : ℕ)) :
  localSpan G R v = ⊥
:= by
  apply localSpan_eq_bot_of_Z1_eq_bot
  exact girth_gt_2R_local_acyclic G R v h


theorem I_local_vanish
  (G : FinGraph) (R : ℕ) (v : G.V)
  (h : Graph.girth G > (2 * R : ℕ)) :
  Module.rank 𝔽₂ (localSpan G R v) = 0
:= by
  have hbot : localSpan G R v = ⊥ := girth_localSpan_trivial G R v h
  subst hbot
  simp


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


noncomputable def dimZ1 (G : FinGraph) [Fintype G.E] :=
  FiniteDimensional.finrank 𝔽₂ (Z1 G)

theorem dimZ1_def (G : FinGraph) [Fintype G.E] :
    dimZ1 G = FiniteDimensional.finrank 𝔽₂ (Z1 G) := rfl

theorem beta1_eq_dimZ1
    (G : FinGraph)
    [Fintype G.V] [Fintype G.E] :
    β₁ G = dimZ1 G := by
  sorry
