import Mathlib
import lean.CLR.SpectralGap

noncomputable section

namespace CLR

variable {α : Type*}

theorem laplacian_eigen_placeholder (w : α → α → ℝ) : 0 ≤ lambda1 w := by
  simpa using lambda1_nonneg w

end CLR
