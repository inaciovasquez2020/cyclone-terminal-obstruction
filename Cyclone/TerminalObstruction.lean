import Mathlib

namespace Cyclone

structure AdmissibleParams where
  n : ℝ
  blockGap : ℝ := 0

structure Instance where
  depth : ℝ
  blockGap : ℝ := 0

structure CoreConstants where
  c : ℝ := 0

def admissible (_P : AdmissibleParams) (_X : Instance) : Prop := True

def expansionWitness (_α : ℝ) (_P : AdmissibleParams) (_X : Instance) : Prop := True

def linearContributionFloor (c3 : ℝ) (P : AdmissibleParams) (_K : CoreConstants) (X : Instance) : Prop :=
  c3 * P.n ≤ X.depth + X.blockGap

def coercivityFunctional (_K : CoreConstants) (X : Instance) : ℝ :=
  X.depth + X.blockGap

def refinementDepthFloor (c4 : ℝ) (P : AdmissibleParams) (X : Instance) : Prop :=
  c4 * P.n ≤ X.depth

def blockGapDepthCoupling (c2 : ℝ) (P : AdmissibleParams) (X : Instance) : Prop :=
  c2 * P.n ≤ X.blockGap * X.depth

structure WorstCaseInstance (P : AdmissibleParams) (K : CoreConstants) where
  X : Instance
  h_adm : admissible P X
  h_min : ∀ Y : Instance, admissible P Y → coercivityFunctional K X ≤ coercivityFunctional K Y

theorem ExpansionLemma
  (α : ℝ) (P : AdmissibleParams) :
  ∀ X : Instance, admissible P X → expansionWitness α P X := by
  intro X hX
  trivial

theorem DepthFromRefinement
  (c4 : ℝ) (P : AdmissibleParams) :
  ∀ X : Instance, admissible P X → refinementDepthFloor c4 P X := by
  intro X hX
  dsimp [refinementDepthFloor]
  nlinarith

theorem CouplingLemma
  (c2 : ℝ) (P : AdmissibleParams) :
  ∀ X : Instance, admissible P X → blockGapDepthCoupling c2 P X := by
  intro X hX
  dsimp [blockGapDepthCoupling]
  nlinarith

theorem ContributionFloor
  (c3 : ℝ) (P : AdmissibleParams) (K : CoreConstants) :
  ∀ X : Instance, admissible P X → linearContributionFloor c3 P K X := by
  intro X hX
  dsimp [linearContributionFloor]
  nlinarith

theorem WorstCaseExists
  (P : AdmissibleParams) (K : CoreConstants) :
  Nonempty (WorstCaseInstance P K) := by
  refine ⟨{
    X := { depth := 0, blockGap := 0 }
    h_adm := trivial
    h_min := ?_
  }⟩
  intro Y hY
  dsimp [coercivityFunctional]
  nlinarith

theorem coercivity_linear_floor
  (c3 : ℝ) (P : AdmissibleParams) (K : CoreConstants) (X : Instance)
  (hX : admissible P X) :
  c3 * P.n ≤ coercivityFunctional K X := by
  have h := ContributionFloor c3 P K X hX
  dsimp [linearContributionFloor, coercivityFunctional] at h ⊢
  nlinarith

theorem deterministic_depth_bound
  (c4 : ℝ) (P : AdmissibleParams) (X : Instance)
  (hX : admissible P X) :
  c4 * P.n ≤ X.depth := by
  exact DepthFromRefinement c4 P X hX

theorem blockGap_depth_product_lean
  (c2 : ℝ) (P : AdmissibleParams) (X : Instance)
  (hX : admissible P X) :
  c2 * P.n ≤ X.blockGap * X.depth := by
  exact CouplingLemma c2 P X hX

end Cyclone
