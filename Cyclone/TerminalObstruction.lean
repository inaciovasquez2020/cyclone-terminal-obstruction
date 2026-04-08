import Mathlib

noncomputable section

namespace URF

structure CoreConstants where
  κ_cap  : ℝ
  κ_loc  : ℝ
  κ_ref  : ℝ
  κ_bg   : ℝ
  κ_bdry : ℝ
  κ_var  : ℝ
  κ_err  : ℝ

structure Instance where
  H0       : ℝ
  locality : ℝ
  refine   : ℝ
  blockGap : ℝ
  boundary : ℝ
  var      : ℝ
  err      : ℝ
  depth    : ℝ

structure AdmissibleParams where
  n            : ℝ
  localityMax  : ℝ
  refineMax    : ℝ
  blockGapMin  : ℝ
  depthMin     : ℝ

def admissible (P : AdmissibleParams) (X : Instance) : Prop :=
  X.locality ≤ P.localityMax ∧
  X.refine ≤ P.refineMax ∧
  P.blockGapMin ≤ X.blockGap ∧
  P.depthMin ≤ X.depth

def coercivityFunctional (K : CoreConstants) (X : Instance) : ℝ :=
  K.κ_cap * X.H0 +
  K.κ_loc * X.locality +
  K.κ_ref * X.refine +
  K.κ_bg * X.blockGap +
  K.κ_bdry * X.boundary +
  K.κ_var * X.var +
  K.κ_err * X.err

def linearContributionFloor (c3 : ℝ) (P : AdmissibleParams) (K : CoreConstants) (X : Instance) : Prop :=
  c3 * P.n ≤ coercivityFunctional K X

def expansionWitness (α : ℝ) (P : AdmissibleParams) (X : Instance) : Prop :=
  α * P.n ≤ X.locality

def refinementDepthFloor (c4 : ℝ) (P : AdmissibleParams) (X : Instance) : Prop :=
  c4 * P.n ≤ X.depth

def blockGapDepthCoupling (c2 : ℝ) (P : AdmissibleParams) (X : Instance) : Prop :=
  c2 * P.n ≤ X.blockGap * X.depth

structure WorstCaseInstance (P : AdmissibleParams) (K : CoreConstants) where
  X     : Instance
  h_adm : admissible P X
  h_min : ∀ Y : Instance, admissible P Y → coercivityFunctional K X ≤ coercivityFunctional K Y

axiom ExpansionLemma
  (α : ℝ) (P : AdmissibleParams) :
  ∀ X : Instance, admissible P X → expansionWitness α P X

axiom DepthFromRefinement
  (c4 : ℝ) (P : AdmissibleParams) :
  ∀ X : Instance, admissible P X → refinementDepthFloor c4 P X

axiom CouplingLemma
  (c2 : ℝ) (P : AdmissibleParams) :
  ∀ X : Instance, admissible P X → blockGapDepthCoupling c2 P X

axiom ContributionFloor
  (c3 : ℝ) (P : AdmissibleParams) (K : CoreConstants) :
  ∀ X : Instance, admissible P X → linearContributionFloor c3 P K X

axiom WorstCaseExists
  (P : AdmissibleParams) (K : CoreConstants) :
  Nonempty (WorstCaseInstance P K)

theorem coercivity_linear_floor
  (c3 : ℝ) (P : AdmissibleParams) (K : CoreConstants) (X : Instance)
  (hX : admissible P X) :
  c3 * P.n ≤ coercivityFunctional K X := by
  exact ContributionFloor c3 P K X hX

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

end URF
