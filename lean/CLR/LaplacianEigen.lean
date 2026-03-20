import Mathlib.Data.Fintype.Card
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.LinearAlgebra.Matrix.Spectrum
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.InnerProductSpace.PiL2

open scoped BigOperators Matrix

variable {α : Type*} [Fintype α] [DecidableEq α]

noncomputable def degree (w : α → α → ℝ) (x : α) : ℝ :=
  ∑ y, w x y

noncomputable def laplacian (w : α → α → ℝ) : Matrix α α ℝ :=
  fun x y =>
    if x = y then degree w x - w x y else - w x y

noncomputable def normalizedLaplacian (w : α → α → ℝ) : Matrix α α ℝ :=
  fun x y =>
    if hx : degree w x = 0 then
      if x = y then 0 else 0
    else
      if hy : degree w y = 0 then
        if x = y then 0 else 0
      else
        if x = y then
          1 - (w x y) / Real.sqrt (degree w x * degree w y)
        else
          - (w x y) / Real.sqrt (degree w x * degree w y)

def weightSymmetric (w : α → α → ℝ) : Prop :=
  ∀ x y, w x y = w y x

def weightNonneg (w : α → α → ℝ) : Prop :=
  ∀ x y, 0 ≤ w x y

theorem laplacian_apply_diag (w : α → α → ℝ) (x : α) :
    laplacian w x x = degree w x - w x x := by
  simp [laplacian]

theorem laplacian_apply_offdiag (w : α → α → ℝ) {x y : α} (h : x ≠ y) :
    laplacian w x y = - w x y := by
  simp [laplacian, h]

theorem laplacian_transpose
    (w : α → α → ℝ)
    (hsym : weightSymmetric w) :
    (laplacian w)ᵀ = laplacian w := by
  ext x y
  by_cases hxy : x = y
  · subst hxy
    simp [Matrix.transpose, laplacian]
  · simp [Matrix.transpose, laplacian, hxy, hsym]

theorem normalizedLaplacian_transpose
    (w : α → α → ℝ)
    (hsym : weightSymmetric w) :
    (normalizedLaplacian w)ᵀ = normalizedLaplacian w := by
  ext x y
  simp [Matrix.transpose, normalizedLaplacian, hsym, mul_comm, mul_left_comm, mul_assoc]

noncomputable def quadForm (M : Matrix α α ℝ) (f : α → ℝ) : ℝ :=
  ∑ x, ∑ y, f x * M x y * f y

theorem laplacian_quadform
    (w : α → α → ℝ)
    (hsym : weightSymmetric w)
    (hloop : ∀ x, w x x = 0)
    (f : α → ℝ) :
    quadForm (laplacian w) f
      = (1 / 2) * ∑ x, ∑ y, w x y * (f x - f y) ^ 2 := by
  sorry

theorem laplacian_psd
    (w : α → α → ℝ)
    (hsym : weightSymmetric w)
    (hnonneg : weightNonneg w)
    (hloop : ∀ x, w x x = 0)
    (f : α → ℝ) :
    0 ≤ quadForm (laplacian w) f := by
  rw [laplacian_quadform w hsym hloop f]
  have hterm : ∀ x y, 0 ≤ w x y * (f x - f y) ^ 2 := by
    intro x y
    have hw : 0 ≤ w x y := hnonneg x y
    have hsquare : 0 ≤ (f x - f y) ^ 2 := sq_nonneg (f x - f y)
    exact mul_nonneg hw hsquare
  have hsum : 0 ≤ ∑ x, ∑ y, w x y * (f x - f y) ^ 2 := by
    exact Finset.sum_nonneg (fun x _ => Finset.sum_nonneg (fun y _ => hterm x y))
  linarith

noncomputable def eigenvaluesList (M : Matrix α α ℝ) : Multiset ℝ :=
  Matrix.eigenvalues M

noncomputable def eigenvalueOrder (M : Matrix α α ℝ) : Fin (Fintype.card α) → ℝ :=
  fun i => ((Matrix.eigenvalues M).sort (· ≤ ·)).get i

noncomputable def lambda0 (w : α → α → ℝ) : ℝ :=
  eigenvalueOrder (normalizedLaplacian w) ⟨0, by
    have h : 0 < Fintype.card α := Fintype.card_pos_iff.mpr ⟨Classical.choice inferInstance⟩
    omega
  ⟩

noncomputable def lambda1 (w : α → α → ℝ) : ℝ :=
  eigenvalueOrder (normalizedLaplacian w) ⟨1, by
    have h : 1 < Fintype.card α := by
      sorry
    exact h
  ⟩

theorem lambda1_is_second_smallest
    (w : α → α → ℝ) :
    lambda1 w = ((Matrix.eigenvalues (normalizedLaplacian w)).sort (· ≤ ·)).get ⟨1, by
      have h : 1 < Fintype.card α := by
        sorry
      exact h
    ⟩ := by
  simp [lambda1, eigenvalueOrder]

theorem normalizedLaplacian_isSymm
    (w : α → α → ℝ)
    (hsym : weightSymmetric w) :
    IsSymm (normalizedLaplacian w) := by
  intro x y
  have hT := congrArg (fun M => M x y) (normalizedLaplacian_transpose w hsym)
  simpa [Matrix.transpose] using hT

theorem laplacian_isSymm
    (w : α → α → ℝ)
    (hsym : weightSymmetric w) :
    IsSymm (laplacian w) := by
  intro x y
  have hT := congrArg (fun M => M x y) (laplacian_transpose w hsym)
  simpa [Matrix.transpose] using hT
