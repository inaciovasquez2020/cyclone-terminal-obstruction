import Mathlib.Data.Finset.Basic
import Mathlib.Data.SetLike.Basic
import Mathlib.Order.Basic

universe u

class Graph where
  V : Type u
  Adj : V → V → Prop

namespace Graph

variable (G : Graph)

abbrev Vertex := G.V

constant cycleSpace : Graph → Type u
constant inducedSubgraph : (G : Graph) → Finset G.V → Graph
constant ball : (G : Graph) → ℕ → G.V → Finset G.V
constant girth : Graph → ℕ∞
constant twoLift : (G : Graph) → ((x y : G.V) → Bool) → Graph
constant ballCycleSpan : (G : Graph) → ℕ → G.V → Type u
constant CycleSpaceTrivial : Graph → Prop

def IsForest (G : Graph) : Prop :=
  CycleSpaceTrivial G

constant CycleSpaceTrivial_of_girth_gt_2R_ball
  (G : Graph) (R : ℕ) (v : G.V) :
  girth G > (2 * R : ℕ) →
  CycleSpaceTrivial (inducedSubgraph G (ball G R v))

constant ballCycleSpan_eq_bot_of_girth_gt_2R
  (G : Graph) (R : ℕ) (v : G.V) :
  girth G > (2 * R : ℕ) →
  ballCycleSpan G R v = ⊥

end Graph

structure PartialIso (G₀ G₁ : Graph) where
  dom   : Finset G₀.V
  codom : Finset G₁.V
  map   : {v // v ∈ dom} → {w // w ∈ codom}

def DuplicatorWins (G₀ G₁ : Graph) : ℕ → PartialIso G₀ G₁ → Prop
  | 0, _ => True
  | Nat.succ k, p =>
      (∀ v₀ : G₀.V, ∃ v₁ : G₁.V, True) ∧
      (∀ v₁ : G₁.V, ∃ v₀ : G₀.V, True)

constant emptyIso (G₀ G₁ : Graph) : PartialIso G₀ G₁

def FO_equiv (G₀ G₁ : Graph) (k : ℕ) : Prop :=
  DuplicatorWins G₀ G₁ k (emptyIso G₀ G₁)

constant local_iso_of_lifts
  (G : Graph) (k : ℕ) (σ : (x y : G.V) → Bool) :
  girth G > (2^(k+1) : ℕ) →
  FO_equiv
    (Graph.twoLift G (fun _ _ => false))
    (Graph.twoLift G σ)
    k

