import Mathlib

noncomputable section

variable {α : Type*}

def variance (f : α → ℝ) : ℝ := sorry

def dirichlet_form (w : α → α → ℝ) (f : α → ℝ) : ℝ := sorry

def lambda1 (w : α → α → ℝ) : ℝ := sorry

theorem spectral_gap_bound
  (w : α → α → ℝ)
  (f : α → ℝ) :
  lambda1 w * variance f ≤ dirichlet_form w f := by
  sorry

end
