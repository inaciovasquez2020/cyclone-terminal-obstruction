import Mathlib
import Cyclone.ConstantChain

noncomputable section
open scoped BigOperators

namespace Cyclone

private lemma exists_pair_ne (α : Type*) [Fintype α] [Nontrivial α] [DecidableEq α] :
    ∃ x y : α, x ≠ y := by
  classical
  simpa [ne_eq, exists_prop] using exists_pair_ne α

-- Helper: sum of a two-point antisymmetric function is zero
private lemma sum_two_point {α : Type*} [Fintype α] [DecidableEq α]
    (x y : α) (hne : x ≠ y) (c : ℝ) :
    ∑ z : α, (if z = x then c else if z = y then -c else 0) = 0 := by
  have hsplit : ∀ z : α, (if z = x then c else if z = y then -c else 0)
      = (if z = x then c else 0) + (if z = y then -c else 0) := fun z => by
    by_cases hzx : z = x
    · simp [hzx, hne]
    · by_cases hzy : z = y
      · simp [hzx, hzy]
      · simp [hzx, hzy]
  simp_rw [hsplit, Finset.sum_add_distrib,
           Finset.sum_ite_eq', Finset.mem_univ, if_true]
  ring

theorem admissible_exists_constructive
    {α : Type*} [Fintype α] [Nontrivial α] [DecidableEq α] :
    ∃ f : α → ℝ, admissible f := by
  classical
  obtain ⟨x, y, hne⟩ := exists_pair_ne α
  let c : ℝ := 1 / Real.sqrt 2
  let f : α → ℝ := fun z => if z = x then c else if z = y then -c else 0
  refine ⟨f, ?_, ?_⟩
  · simp only [mean, f]
    rw [sum_two_point x y hne c]
    simp
  · have h_mean : mean f = 0 := by
      simp only [mean, f]
      rw [sum_two_point x y hne c]
      simp
    simp only [variance, h_mean, sub_zero, f]
    have hsq : ∀ z : α, (if z = x then c else if z = y then -c else 0) ^ 2
        = (if z = x then c ^ 2 else 0) + (if z = y then c ^ 2 else 0) := fun z => by
      by_cases hzx : z = x
      · simp [hzx, hne]
      · by_cases hzy : z = y
        · simp [hzx, hzy]
        · simp [hzx, hzy]
    simp_rw [hsq, Finset.sum_add_distrib,
             Finset.sum_ite_eq', Finset.mem_univ, if_true]
    have hc2 : c ^ 2 = 1 / 2 := by
      have hs : (0 : ℝ) ≤ 2 := by norm_num
      calc
        c ^ 2 = (1 / Real.sqrt 2) ^ 2 := by rfl
        _ = 1 / ((Real.sqrt 2) ^ 2) := by field_simp
        _ = 1 / 2 := by rw [Real.sq_sqrt hs]
    linarith

end Cyclone
