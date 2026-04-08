import Mathlib

noncomputable section

variable {α : Type*}

axiom variance (f : α → ℝ) : ℝ

axiom dirichlet_form (w : α → α → ℝ) (f : α → ℝ) : ℝ

axiom lambda1 (w : α → α → ℝ) : ℝ

axiom spectral_gap_bound
  (w : α → α → ℝ)
  (f : α → ℝ) :
  lambda1 w * variance f ≤ dirichlet_form w f

end
