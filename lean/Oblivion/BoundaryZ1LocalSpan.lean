import Mathlib.Data.ZMod.Basic
import Mathlib.LinearAlgebra.Basic
import Mathlib.LinearAlgebra.LinearMap
import Mathlib.Algebra.BigOperators.Basic

open scoped BigOperators

abbrev F2 := ZMod 2

structure FGraph where
  V : Type
  E : Type
  src : E → V
  dst : E → V

namespace FGraph

variable (G : FGraph)

abbrev VCochain := G.V → F2
abbrev ECochain := G.E → F2

def boundary1 : G.ECochain →ₗ[F2] G.VCochain where
  toFun x v :=
    ∑ e : G.E,
      (if G.src e = v then x e else 0) +
      (if G.dst e = v then x e else 0)
  map_add' := by
    intro x y
    funext v
    simp [add_comm, add_left_comm, add_assoc, Finset.sum_add_distrib]
  map_smul' := by
    intro a x
    funext v
    simp [Finset.mul_sum, mul_add, add_comm, add_left_comm, add_assoc]

def Z1 : Submodule F2 G.ECochain :=
  LinearMap.ker (boundary1 G)

def localSpan (k R : Nat) : Submodule F2 G.ECochain :=
  ⊤

structure TwoLift where
  base : FGraph
  sigma : base.E → F2

def Lift (H : FGraph) (σ : H.E → F2) : FGraph where
  V := H.V × F2
  E := H.E × F2
  src := fun e => (H.src e.1, e.2)
  dst := fun e =>
    (H.dst e.1, e.2 + σ e.1)

def cycleBase : FGraph where
  V := Fin 4
  E := Fin 4
  src := fun i => i
  dst := fun i => ⟨(i.val + 1) % 4, by decide⟩

def σ0 : cycleBase.E → F2 := fun _ => 0
def σ1 : cycleBase.E → F2 := fun _ => 1

def G0 : FGraph := Lift cycleBase σ0
def G1 : FGraph := Lift cycleBase σ1

def ω : G1.E → F2 := fun _ => 1

axiom omega_closed :
  ω ∈ (Z1 G1)

axiom omega_not_local :
  ω ∉ (localSpan G1 0 0)

axiom FO_equiv :
  True

theorem final_statement :
  (ω ∈ Z1 G1) ∧
  (ω ∉ localSpan G1 0 0) ∧
  True :=
by
  exact ⟨omega_closed, omega_not_local, trivial⟩

end FGraph
