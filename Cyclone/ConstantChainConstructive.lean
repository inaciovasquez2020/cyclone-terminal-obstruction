import Mathlib
import Cyclone.ConstantChain

noncomputable section
open scoped BigOperators

namespace Cyclone

theorem admissible_exists_constructive
  {α : Type*} [Fintype α] [Nontrivial α] :
  ∃ f : α → ℝ, admissible f := by
  sorry

end Cyclone
