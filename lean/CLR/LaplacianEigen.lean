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

noncomputable def quadForm (M : Matrix α α ℝ) (f : α → ℝ) : ℝ :=
  ∑ x, ∑ y, f x * M x y * f y

noncomputable def eigenvalueOrder (M : Matrix α α ℝ) :
    Fin (Fintype.card α) → ℝ :=
  fun i => ((Matrix.eigenvalues M).sort (· ≤ ·)).get i

noncomputable def lambda1 (w : α → α → ℝ) : ℝ :=
  eigenvalueOrder (normalizedLaplacian w) ⟨1, by
    have h : 1 < Fintype.card α := by
      sorry
    exact h
  ⟩
