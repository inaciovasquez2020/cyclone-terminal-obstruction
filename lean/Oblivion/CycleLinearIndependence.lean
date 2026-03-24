import Mathlib

theorem cycle_linear_independence
  (λ : Edge → ZMod 2) :
  (∑ e, λ e • C_e e = 0) →
  ∀ e, λ e = 0 := by
  admit
