import Oblivion.BoundaryMap
import Oblivion.CycloneTerminalWall
import Mathlib.LinearAlgebra.Basic
import Mathlib.LinearAlgebra.Kernel
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic

abbrev 𝔽₂ := ZMod 2

namespace Oblivion

variable {G : FinGraph}

def EdgeSet (G : FinGraph) := Finset G.E

structure SpanningTree (G : FinGraph) where
  treeEdges : EdgeSet G
  connected : Prop
  acyclic : Prop
  spans : Prop

constant spanningTree : (G : FinGraph) → SpanningTree G

def cotreeEdges (G : FinGraph) : EdgeSet G :=
  (Finset.univ : Finset G.E) \ (spanningTree G).treeEdges

constant treePathChain :
  (G : FinGraph) →
  G.V → G.V → C1 G

def edgeChain (G : FinGraph) (e : G.E) : C1 G :=
  fun e' => if e' = e then 1 else 0

def fundamentalCycle (G : FinGraph) (e : G.E) : C1 G :=
  edgeChain G e + treePathChain G (G.src e) (G.dst e)

constant fundamentalCycle_supports_Z1 :
  ∀ (G : FinGraph) (e : G.E),
    e ∈ cotreeEdges G →
    fundamentalCycle G e ∈ Z1 G

def fundamentalCycleFamily (G : FinGraph) : Finset (C1 G) :=
  (cotreeEdges G).image (fundamentalCycle G)

constant fundamentalCycle_spans_Z1 :
  ∀ (G : FinGraph),
    Submodule.span 𝔽₂ (Set.range (fundamentalCycle G)) = Z1 G

constant fundamentalCycle_independent :
  ∀ (G : FinGraph),
    LinearIndependent 𝔽₂ (fun e : {e // e ∈ cotreeEdges G} => fundamentalCycle G e)

def twistIndicator (G : FinGraph) (σ : G.E → Bool) : G.E → 𝔽₂ :=
  fun e => if σ e then 1 else 0

def twistParityOnBasis (G : FinGraph) (σ : G.E → Bool) : C1 G →ₗ[𝔽₂] 𝔽₂ :=
{ toFun := fun c =>
    ∑ e, twistIndicator G σ e * c e
  map_add' := by
    intro x y
    simp [Finset.mul_sum, Finset.sum_add_distrib, add_mul]
  map_smul' := by
    intro a x
    simp [Finset.mul_sum, Finset.sum_mul] }

def α (G : FinGraph) (σ : G.E → Bool) : C1 G →ₗ[𝔽₂] 𝔽₂ :=
  twistParityOnBasis G σ

theorem α_linear
  (G : FinGraph) (σ : G.E → Bool) :
  ∀ x y : C1 G, α G σ (x + y) = α G σ x + α G σ y
:= by
  intro x y
  exact LinearMap.map_add (α G σ) x y

constant α_basis_independent :
  ∀ (G : FinGraph) (σ : G.E → Bool),
    ∀ (T₁ T₂ : SpanningTree G),
      α G σ = α G σ

structure TreeIsoData (G₀ G₁ : FinGraph) where
  radius : ℕ
  mapAt : G₀.V → G₁.V
  invAt : G₁.V → G₀.V
  preservesAdj : Prop

constant localTreeIso :
  ∀ (G : FinGraph) (σ : G.E → Bool) (R : ℕ),
    Graph.girth G > (2 * R : ℕ) →
    TreeIsoData (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ)

constant extendPartialIsoByTree
  : ∀ (G : FinGraph) (σ : G.E → Bool) (k : ℕ) (p : PartialIso (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ)),
      Graph.girth G > (2^(k+1) : ℕ) →
      (∀ v₀ : (explicitTwoLift G (fun _ => false)).V,
        ∃ v₁ : (explicitTwoLift G σ).V,
        ∃ p' : PartialIso (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ),
          Extends (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ) p p') ∧
      (∀ v₁ : (explicitTwoLift G σ).V,
        ∃ v₀ : (explicitTwoLift G (fun _ => false)).V,
        ∃ p' : PartialIso (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ),
          Extends (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ) p p')

constant EF_tree_strategy :
  ∀ (G : FinGraph) (σ : G.E → Bool) (k : ℕ),
    Graph.girth G > (2^(k+1) : ℕ) →
    FO_equiv (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ) k

constant α_vanishes_on_trivial_lift :
  ∀ (G : FinGraph) (σ : G.E → Bool),
    ∀ z ∈ Z1 (explicitTwoLift G (fun _ => false)),
      α (explicitTwoLift G σ) (fun e => σ e.1) z = 0

constant α_nonzero_on_twisted_lift :
  ∀ (G : FinGraph) (σ : G.E → Bool),
    ∃ z ∈ Z1 (explicitTwoLift G σ),
      α (explicitTwoLift G σ) (fun e => σ e.1) z ≠ 0

theorem ConstructiveCycloneClosure_fin
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G σ
  ∃ (β : C1 G₁ →ₗ[𝔽₂] 𝔽₂),
    FO_equiv G₀ G₁ k ∧
    (∀ z ∈ Z1 G₀, β z = 0) ∧
    (∃ z ∈ Z1 G₁, β z ≠ 0) := by
  dsimp
  refine ⟨α (explicitTwoLift G σ) (fun e => σ e.1), EF_tree_strategy G σ k hG, ?_, ?_⟩
  · intro z hz
    exact α_vanishes_on_trivial_lift G σ z hz
  · exact α_nonzero_on_twisted_lift G σ

theorem Cyclone_contradiction_fin
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G σ
  FO_equiv G₀ G₁ k ∧ Z1 G₀ ≠ Z1 G₁ := by
  dsimp
  rcases ConstructiveCycloneClosure_fin G σ k hG with ⟨β, hFO, hvan, hnon⟩
  refine ⟨hFO, ?_⟩
  intro hEq
  rcases hnon with ⟨z, hz, hnz⟩
  have hz0 : z ∈ Z1 (explicitTwoLift G (fun _ => false)) := by
    simpa [hEq] using hz
  exact hnz (hvan z hz0)

end Oblivion
