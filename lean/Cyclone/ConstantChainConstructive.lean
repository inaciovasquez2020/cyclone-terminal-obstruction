import Mathlib
import Cyclone.ConstantChain

noncomputable section
open scoped BigOperators

namespace Cyclone

-- We define the constructive existence by picking two distinct elements
-- and assigning them values ±1/√2 to satisfy the variance constraint.

theorem admissible_exists_constructive
  {α : Type*} [Fintype α] [Nontrivial α] :
  ∃ f : α → ℝ, admissible f := by
  -- 1. Get two distinct elements x and y
  obtain ⟨x, y, hne⟩ := exists_pair_ne α
  -- 2. Define c = 1/√2 so that c² + (-c)² = 1
  let c : ℝ := 1 / Real.sqrt 2
  let f : α → ℝ := fun z => if z = x then c else if z = y then -c else 0
  use f
  constructor
  · -- Prove mean f = 0
    simp [mean, f, hne, hne.symm, Finset.sum_itE, Finset.filter_eq, Finset.mem_univ]
    ring
  · -- Prove variance f = 1
    have h_mean : mean f = 0 := by 
      simp [mean, f, hne, hne.symm, Finset.sum_itE, Finset.filter_eq, Finset.mem_univ]
      ring
    simp [variance, h_mean, f, hne, hne.symm, Finset.sum_itE, Finset.filter_eq, Finset.mem_univ]
    field_simp [c]
    rw [Real.sq_sqrt (by norm_num)]
    norm_num

end Cyclone
