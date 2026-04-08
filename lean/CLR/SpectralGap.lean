import Mathlib

noncomputable section

namespace CLR

variable {α : Type*}

def lambda1 (_w : α → α → ℝ) : ℝ := 1

theorem lambda1_nonneg (w : α → α → ℝ) : 0 ≤ lambda1 w := by
  simp [lambda1]

theorem spectral_gap_placeholder (w : α → α → ℝ) : lambda1 w = 1 := by
  simp [lambda1]

end CLR
