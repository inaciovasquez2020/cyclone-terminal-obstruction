import Mathlib.LinearAlgebra.Basic
import Mathlib.LinearAlgebra.Kernel
import Mathlib.Data.ZMod.Basic
import Oblivion.CycloneCore
import Oblivion.EFGameUpdate

abbrev 𝔽₂ := ZMod 2

constant C0 : Graph → Type _
constant C1 : Graph → Type _

constant boundaryLinear :
  ∀ (G : Graph), C1 G →ₗ[𝔽₂] C0 G

def boundaryMap (G : Graph) : C1 G →ₗ[𝔽₂] C0 G :=
  boundaryLinear G

def Z1 (G : Graph) : Submodule 𝔽₂ (C1 G) :=
  LinearMap.ker (boundaryMap G)

constant forest_iff_Z1_zero :
  ∀ (G : Graph), Graph.IsForest G ↔ Z1 G = ⊥

def explicitTwoLift (G : Graph) : Graph :=
  Graph.twoLift G (fun _ _ => false)

constant local_ball_forest
  (G : Graph) (R : ℕ) (v : G.V) :
  Graph.girth G > (2 * R : ℕ) →
  Graph.IsForest (Graph.inducedSubgraph G (Graph.ball G R v))

constant local_Z1_zero
  (G : Graph) (R : ℕ) (v : G.V) :
  Graph.girth G > (2 * R : ℕ) →
  Z1 (Graph.inducedSubgraph G (Graph.ball G R v)) = ⊥

constant ball_cycle_span_zero
  (G : Graph) (R : ℕ) (v : G.V) :
  Graph.girth G > (2 * R : ℕ) →
  Graph.ballCycleSpan G R v = ⊥

constant explicitLiftTwist :
  ∀ (G : Graph), ((x y : G.V) → Bool)

def twistedTwoLift (G : Graph) : Graph :=
  Graph.twoLift G (explicitLiftTwist G)

constant emptyIso_dom_empty :
  ∀ (G₀ G₁ : Graph), (emptyIso G₀ G₁).dom = ∅

constant emptyIso_codom_empty :
  ∀ (G₀ G₁ : Graph), (emptyIso G₀ G₁).codom = ∅

constant local_iso_of_explicit_lifts
  (G : Graph) (k : ℕ) :
  Graph.girth G > (2^(k+1) : ℕ) →
  FO_equiv (explicitTwoLift G) (twistedTwoLift G) k

constant cycle_obstruction :
  ∀ (G : Graph), Z1 (twistedTwoLift G) ≠ Z1 (explicitTwoLift G)

constant cycloneWitness :
  ∃ G : Graph,
    ∀ k : ℕ,
      Graph.girth G > (2^(k+1) : ℕ) →
      FO_equiv (explicitTwoLift G) (twistedTwoLift G) k ∧
      Z1 (explicitTwoLift G) ≠ Z1 (twistedTwoLift G)

constant summaryInvariant : Graph → Nat

constant summaryInvariant_respects_FO
  (G₀ G₁ : Graph) (k : ℕ) :
  FO_equiv G₀ G₁ k →
  summaryInvariant G₀ = summaryInvariant G₁

constant cyclone_separation :
  ∃ G₀ G₁ : Graph,
    (∃ k : ℕ, FO_equiv G₀ G₁ k) ∧
    Z1 G₀ ≠ Z1 G₁

