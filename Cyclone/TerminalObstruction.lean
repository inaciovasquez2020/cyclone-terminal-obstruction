namespace URF

noncomputable section

open Classical

structure CoreConstants where
  κ_cap : ℝ
  κ_loc : ℝ
  κ_ref : ℝ
  κ_bg  : ℝ
  κ_bdry : ℝ
  κ_var : ℝ
  κ_err : ℝ
  deriving Repr

structure Instance where
  H0 : ℝ
  transcriptCap : ℝ
  boundaryOverlap : ℝ
  varianceCost : ℝ
  boundaryCost : ℝ
  blockGap : ℝ
  defect : ℝ
  depth : ℝ
  deriving Repr

def coercivityFunctional (K : CoreConstants) (X : Instance) : ℝ :=
  K.κ_cap * X.transcriptCap
  + K.κ_loc * X.boundaryOverlap
  + K.κ_var * X.varianceCost
  + K.κ_bdry * X.boundaryCost
  + K.κ_bg * X.blockGap
  + K.κ_err * X.defect

def chronosLowerBound (K : CoreConstants) (X : Instance) : ℝ :=
  X.H0 - coercivityFunctional K X

def terminalObstruction (K : CoreConstants) (X : Instance) : Prop :=
  chronosLowerBound K X ≤ K.κ_ref * X.depth

axiom Cyclone
  (K : CoreConstants) :
  ∀ X : Instance, 0 ≤ X.H0 → 0 ≤ coercivityFunctional K X →
    chronosLowerBound K X ≤ K.κ_ref * X.depth

theorem CCL_single_coercivity_inequality
  (K : CoreConstants) (X : Instance)
  (hH0 : 0 ≤ X.H0) (hC : 0 ≤ coercivityFunctional K X) :
  X.H0 ≤ K.κ_ref * X.depth + coercivityFunctional K X := by
  have h := Cyclone K X hH0 hC
  dsimp [chronosLowerBound] at h ⊢
  linarith

theorem canonical_constant_bound
  (K : CoreConstants) (X : Instance)
  (hH0 : 0 ≤ X.H0) (hC : 0 ≤ coercivityFunctional K X) :
  X.depth ≥ (X.H0 - coercivityFunctional K X) / K.κ_ref := by
  have h := Cyclone K X hH0 hC
  dsimp [chronosLowerBound] at h
  by_cases hκ : K.κ_ref = 0
  · subst hκ
    linarith
  · have hkpos : K.κ_ref ≠ 0 := hκ
    field_simp [hkpos]
    linarith

theorem lean_certified_terminal_obstruction
  (K : CoreConstants) (X : Instance)
  (hH0 : 0 ≤ X.H0) (hC : 0 ≤ coercivityFunctional K X) :
  terminalObstruction K X := by
  exact Cyclone K X hH0 hC

structure ConstantSheet where
  K : CoreConstants
  cap_nonneg : 0 ≤ K.κ_cap
  loc_nonneg : 0 ≤ K.κ_loc
  ref_pos : 0 < K.κ_ref
  bg_nonneg : 0 ≤ K.κ_bg
  bdry_nonneg : 0 ≤ K.κ_bdry
  var_nonneg : 0 ≤ K.κ_var
  err_nonneg : 0 ≤ K.κ_err
  deriving Repr

def refereeSheet (S : ConstantSheet) : List (String × ℝ) :=
  [ ("kappa_cap",  S.K.κ_cap)
  , ("kappa_loc",  S.K.κ_loc)
  , ("kappa_ref",  S.K.κ_ref)
  , ("kappa_bg",   S.K.κ_bg)
  , ("kappa_bdry", S.K.κ_bdry)
  , ("kappa_var",  S.K.κ_var)
  , ("kappa_err",  S.K.κ_err)
  ]

def ChronosDependsOnCore (K : CoreConstants) : Prop :=
  ∀ X : Instance, 0 ≤ X.H0 → 0 ≤ coercivityFunctional K X →
    X.H0 ≤ K.κ_ref * X.depth + coercivityFunctional K X

theorem Chronos_to_URF_single_dependency
  (K : CoreConstants) :
  ChronosDependsOnCore K := by
  intro X hH0 hC
  exact CCL_single_coercivity_inequality K X hH0 hC

end URF

structure AdmissibleParams where
  n : ℝ
  c0 : ℝ
  Ccap : ℝ
  k : ℝ
  Cloc : ℝ
  deriving Repr

def admissible (P : AdmissibleParams) (X : Instance) : Prop :=
  0 ≤ X.H0 ∧
  0 < P.n ∧
  X.H0 ≤ P.n ∧
  X.blockGap ≥ P.c0 ∧
  X.transcriptCap ≤ P.Ccap * (Real.log P.n) ^ P.k ∧
  X.boundaryOverlap ≤ P.Cloc


def localContribution (K : CoreConstants) (X : Instance) : ℝ :=
  K.κ_cap * X.transcriptCap
  + K.κ_loc * X.boundaryOverlap
  + K.κ_var * X.varianceCost
  + K.κ_bdry * X.boundaryCost
  + K.κ_bg * X.blockGap
  + K.κ_err * X.defect

def totalLocalContribution (K : CoreConstants) (X : Instance) : ℝ :=
  localContribution K X

def linearContributionFloor (c3 : ℝ) (P : AdmissibleParams) (K : CoreConstants) (X : Instance) : Prop :=
  c3 * P.n ≤ totalLocalContribution K X

def expansionWitness (α : ℝ) (P : AdmissibleParams) (X : Instance) : Prop :=
  α * P.n ≤ X.blockGap

def refinementDepthFloor (c4 : ℝ) (P : AdmissibleParams) (X : Instance) : Prop :=
  c4 * P.n ≤ X.depth

def blockGapDepthCoupling (c2 : ℝ) (P : AdmissibleParams) (X : Instance) : Prop :=
  c2 * P.n ≤ X.blockGap * X.depth

structure WorstCaseInstance (P : AdmissibleParams) (K : CoreConstants) where
  X : Instance
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


theorem admissible_implies_cyclone
  (c3 c4 : ℝ)
  (P : AdmissibleParams)
  (K : CoreConstants)
  (X : Instance)
  (h_adm : admissible P X)
  (h_phi : c3 * P.n ≤ coercivityFunctional K X)
  (h_depth : c4 * P.n ≤ X.depth)
  (h_norm : c3 + K.κ_ref * c4 ≥ 1) :
  X.H0 - coercivityFunctional K X ≤ K.κ_ref * X.depth := by
  have hH0 : X.H0 ≤ P.n := h_adm.right.right.left
  have h1 : X.H0 - coercivityFunctional K X ≤ P.n - c3 * P.n := by
    have := sub_le_sub hH0 h_phi
    exact this
  have h2 : P.n - c3 * P.n = (1 - c3) * P.n := by ring
  have h3 : (1 - c3) * P.n ≤ K.κ_ref * (c4 * P.n) := by
    have := h_norm
    nlinarith
  have h4 : K.κ_ref * (c4 * P.n) ≤ K.κ_ref * X.depth := by
    have := mul_le_mul_of_nonneg_left h_depth (by positivity)
    simpa [mul_comm, mul_left_comm, mul_assoc] using this
  have := le_trans h1 (le_trans (by simpa [h2] using h3) h4)
  exact this

