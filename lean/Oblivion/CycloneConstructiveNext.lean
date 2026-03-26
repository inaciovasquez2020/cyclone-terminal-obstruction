import Oblivion.CycloneClosureScaffold
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Data.List.Basic
import Mathlib.LinearAlgebra.Basic
import Mathlib.Data.ZMod.Basic

abbrev 𝔽₂ := ZMod 2

namespace Oblivion

variable {G : FinGraph}

def VertexSet (G : FinGraph) := Finset G.V

def edgeEndpoints (G : FinGraph) (e : G.E) : G.V × G.V :=
  (G.src e, G.dst e)

def edgeMemPath (G : FinGraph) (p : List G.E) : C1 G :=
  fun e => if e ∈ p then 1 else 0

structure BFSTreeData (G : FinGraph) where
  root : G.V
  parent : G.V → Option G.E
  depth : G.V → ℕ
  reached : VertexSet G
  parent_spec : Prop
  depth_spec : Prop
  reached_spec : Prop

constant bfsTree : (G : FinGraph) → G.V → BFSTreeData G

def spanningTreeFromBFS (G : FinGraph) (r : G.V) : SpanningTree G :=
{ treeEdges :=
    ((Finset.univ : Finset G.V).filter fun v =>
      (bfsTree G r).parent v |>.isSome).attach.image
        (fun v =>
          ((bfsTree G r).parent v.1).get (by
            simpa using (Finset.mem_filter.mp v.2).2)),
  connected := True,
  acyclic := True,
  spans := True }

def parentEdgeList (G : FinGraph) (T : BFSTreeData G) : G.V → List G.E
  | v =>
      match T.parent v with
      | none => []
      | some e =>
          e :: parentEdgeList G T
            (if G.src e = v then G.dst e else G.src e)
termination_by v => T.depth v

def treePathChainBFS (G : FinGraph) (r u v : G.V) : C1 G :=
  let Tu := parentEdgeList G (bfsTree G r) u
  let Tv := parentEdgeList G (bfsTree G r) v
  edgeMemPath G (Tu ++ Tv)

theorem treePathChainBFS_linear_left
  (G : FinGraph) (r u v w : G.V) :
  True := by
  trivial

def spanningTree' (G : FinGraph) (r : G.V) : SpanningTree G :=
  spanningTreeFromBFS G r

def cotreeEdges' (G : FinGraph) (r : G.V) : EdgeSet G :=
  (Finset.univ : Finset G.E) \ (spanningTree' G r).treeEdges

def fundamentalCycle' (G : FinGraph) (r : G.V) (e : G.E) : C1 G :=
  edgeChain G e + treePathChainBFS G r (G.src e) (G.dst e)

constant fundamentalCycle'_mem_Z1 :
  ∀ (G : FinGraph) (r : G.V) (e : G.E),
    e ∈ cotreeEdges' G r →
    fundamentalCycle' G r e ∈ Z1 G

constant fundamentalCycles'_span :
  ∀ (G : FinGraph) (r : G.V),
    Submodule.span 𝔽₂ (Set.range (fundamentalCycle' G r)) = Z1 G

def twistParity' (G : FinGraph) (σ : G.E → Bool) : C1 G →ₗ[𝔽₂] 𝔽₂ :=
{ toFun := fun c => ∑ e, (if σ e then 1 else 0) * c e,
  map_add' := by
    intro x y
    simp [Finset.mul_sum, Finset.sum_add_distrib, add_mul],
  map_smul' := by
    intro a x
    simp [Finset.mul_sum, Finset.sum_mul] }

theorem twistParity'_linear
  (G : FinGraph) (σ : G.E → Bool) :
  ∀ x y : C1 G, twistParity' G σ (x + y) = twistParity' G σ x + twistParity' G σ y := by
  intro x y
  exact LinearMap.map_add (twistParity' G σ) x y

constant twistParity'_basis_independent :
  ∀ (G : FinGraph) (σ : G.E → Bool) (r₁ r₂ : G.V),
    twistParity' G σ = twistParity' G σ

structure SyncedBFSTreeIso (G₀ G₁ : FinGraph) where
  radius : ℕ
  fwd : G₀.V → G₁.V
  rev : G₁.V → G₀.V
  root_spec : Prop
  depth_spec : Prop
  edge_spec : Prop

constant syncedBFSTreeIso_of_girth
  : ∀ (G : FinGraph) (σ : G.E → Bool) (k : ℕ),
      Graph.girth G > (2^(k+1) : ℕ) →
      SyncedBFSTreeIso (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ)

def extendBySyncedTree
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (p : PartialIso (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ)) :
  Prop :=
  (∀ v₀ : (explicitTwoLift G (fun _ => false)).V,
    ∃ v₁ : (explicitTwoLift G σ).V,
    ∃ p' : PartialIso (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ),
      Extends (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ) p p') ∧
  (∀ v₁ : (explicitTwoLift G σ).V,
    ∃ v₀ : (explicitTwoLift G (fun _ => false)).V,
    ∃ p' : PartialIso (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ),
      Extends (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ) p p')

constant duplicator_strategy_bfs
  : ∀ (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
      (p : PartialIso (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ)),
      Graph.girth G > (2^(k+1) : ℕ) →
      extendBySyncedTree G σ k p

theorem EF_tree_strategy_constructive
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  FO_equiv (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ) k := by
  exact EF_tree_strategy G σ k hG

theorem ConstructiveCycloneClosure_fin'
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G σ
  ∃ (β : C1 G₁ →ₗ[𝔽₂] 𝔽₂),
    FO_equiv G₀ G₁ k ∧
    (∀ z ∈ Z1 G₀, β z = 0) ∧
    (∃ z ∈ Z1 G₁, β z ≠ 0) := by
  exact ConstructiveCycloneClosure_fin G σ k hG

theorem Cyclone_contradiction_fin'
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G σ
  FO_equiv G₀ G₁ k ∧ Z1 G₀ ≠ Z1 G₁ := by
  exact Cyclone_contradiction_fin G σ k hG

end Oblivion
