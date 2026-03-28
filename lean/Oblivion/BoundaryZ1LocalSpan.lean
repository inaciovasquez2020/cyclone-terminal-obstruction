import Mathlib.Data.ZMod.Basic
import Mathlib.LinearAlgebra.Basic
import Mathlib.LinearAlgebra.LinearMap
import Mathlib.Algebra.BigOperators.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Order.CompleteLattice
import Mathlib.Data.Set.Lattice

open scoped BigOperators

abbrev F2 := ZMod 2

structure FGraph where
  V : Type
  E : Type
  src : E → V
  dst : E → V
  [finV : Fintype V]
  [decV : DecidableEq V]
  [finE : Fintype E]
  [decE : DecidableEq E]

attribute [instance] FGraph.finV FGraph.decV FGraph.finE FGraph.decE

namespace FGraph

variable (G : FGraph)

abbrev VCochain := G.V → F2
abbrev ECochain := G.E → F2

def Adj (u v : G.V) : Prop :=
  ∃ e : G.E, (G.src e = u ∧ G.dst e = v) ∨ (G.src e = v ∧ G.dst e = u)

def boundary1 : G.ECochain →ₗ[F2] G.VCochain where
  toFun x v :=
    ∑ e : G.E,
      (if G.src e = v then x e else 0) +
      (if G.dst e = v then x e else 0)
  map_add' := by
    intro x y
    funext v
    simp [Finset.sum_add_distrib, add_comm, add_left_comm, add_assoc]
  map_smul' := by
    intro a x
    funext v
    simp [Finset.mul_sum, mul_add, add_comm, add_left_comm, add_assoc]

def Z1 : Submodule F2 G.ECochain :=
  LinearMap.ker (boundary1 G)

def ballVertices (v : G.V) : Nat → Set G.V
  | 0 => {u | u = v}
  | n + 1 => {u | u ∈ ballVertices v n ∨ ∃ w, w ∈ ballVertices v n ∧ G.Adj w u}

def inducedSubgraph (S : Set G.V) : FGraph where
  V := {v : G.V // v ∈ S}
  E := {e : G.E // G.src e ∈ S ∧ G.dst e ∈ S}
  src := fun e => ⟨G.src e.1, e.2.1⟩
  dst := fun e => ⟨G.dst e.1, e.2.2⟩

def edgeRestrictSet (S : Set G.V) : Set G.E :=
  {e : G.E | G.src e ∈ S ∧ G.dst e ∈ S}

def extendEdgeCochain (S : Set G.V) :
    (inducedSubgraph G S).ECochain →ₗ[F2] G.ECochain where
  toFun x e :=
    if h : e ∈ edgeRestrictSet G S then
      x ⟨e, h⟩
    else
      0
  map_add' := by
    intro x y
    funext e
    by_cases h : e ∈ edgeRestrictSet G S <;> simp [extendEdgeCochain, h]
  map_smul' := by
    intro a x
    funext e
    by_cases h : e ∈ edgeRestrictSet G S <;> simp [extendEdgeCochain, h]

def localCycleImage (R : Nat) (v : G.V) : Submodule F2 G.ECochain :=
  Submodule.map (extendEdgeCochain G (ballVertices G v R))
    ((FGraph.Z1 (inducedSubgraph G (ballVertices G v R))))

def localSpan (k R : Nat) : Submodule F2 G.ECochain :=
  ⨆ v : G.V, localCycleImage G R v

end FGraph
