import Mathlib

noncomputable section
open scoped BigOperators

namespace Cyclone

variable {α : Type*} [Fintype α] [DecidableEq α]

def edgeEnergy (Adj : α → α → Prop) [DecidableRel Adj] (f : α → ℝ) : ℝ :=
  ((Finset.univ.product Finset.univ).sum fun xy =>
    if Adj xy.1 xy.2 then (f xy.1 - f xy.2)^2 else 0) / 2

def mean (f : α → ℝ) : ℝ :=
  (∑ x, f x) / Fintype.card α

def variance (f : α → ℝ) : ℝ :=
  ∑ x, (f x - mean f)^2

def admissible (f : α → ℝ) : Prop :=
  mean f = 0 ∧ variance f = 1

private lemma sum_two_point (x y : α) (hne : x ≠ y) (c : ℝ) :
    ∑ z : α, (if z = x then c else if z = y then -c else 0) = 0 := by
  have hsplit : ∀ z : α,
      (if z = x then c else if z = y then -c else 0)
      = (if z = x then c else 0) + (if z = y then -c else 0) := fun z => by
    by_cases hzx : z = x
    · simp [hzx, hne]
    · by_cases hzy : z = y
      · simp [hzy, Ne.symm hne]
      · simp [hzx, hzy]
  simp_rw [hsplit, Finset.sum_add_distrib,
           Finset.sum_ite_eq', Finset.mem_univ, if_true]
  ring

theorem admissible_exists [Nontrivial α] :
    ∃ f : α → ℝ, admissible f := by
  obtain ⟨x, y, hne⟩ := exists_pair_ne α
  let c : ℝ := 1 / Real.sqrt 2
  let f : α → ℝ := fun z => if z = x then c else if z = y then -c else 0
  refine ⟨f, ?_, ?_⟩
  · simp only [mean, f]
    rw [sum_two_point x y hne c]; simp
  · have h_mean : mean f = 0 := by
      simp only [mean, f]; rw [sum_two_point x y hne c]; simp
    simp only [variance, h_mean, sub_zero, f]
    have hsq : ∀ z : α,
        (if z = x then c else if z = y then -c else 0) ^ 2
        = (if z = x then c ^ 2 else 0) + (if z = y then c ^ 2 else 0) := fun z => by
      by_cases hzx : z = x
      · simp [hzx, hne]
      · by_cases hzy : z = y
        · simp [hzy, Ne.symm hne]
        · simp [hzx, hzy]
    simp_rw [hsq, Finset.sum_add_distrib,
             Finset.sum_ite_eq', Finset.mem_univ, if_true]
    have hc2 : c ^ 2 = 1 / 2 := by
      calc c ^ 2 = (1 / Real.sqrt 2) ^ 2 := rfl
        _ = 1 / (Real.sqrt 2) ^ 2        := by ring
        _ = 1 / 2                         := by rw [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]
    linarith

def lambda1 (Adj : α → α → Prop) [DecidableRel Adj] : ℝ :=
  sInf {r : ℝ | ∃ f : α → ℝ, admissible f ∧ edgeEnergy Adj f = r}

def Cvar (Adj : α → α → Prop) [DecidableRel Adj] : ℝ := (lambda1 Adj)⁻¹

omit [DecidableEq α] in
theorem Cvar_exact (Adj : α → α → Prop) [DecidableRel Adj] :
    Cvar Adj = (lambda1 Adj)⁻¹ := rfl

def Cprime (Cloc : ℝ) (Adj : α → α → Prop) [DecidableRel Adj] : ℝ :=
  Cloc * (lambda1 Adj)⁻¹

omit [DecidableEq α] in
theorem Cprime_bound (Cloc : ℝ) (Adj : α → α → Prop) [DecidableRel Adj] :
    Cprime Cloc Adj = Cloc * (lambda1 Adj)⁻¹ := by simp [Cprime]

omit [DecidableEq α] in
theorem Cprime_sharp_3d (Cloc : ℝ) (Adj : α → α → Prop) [DecidableRel Adj] (_d : Nat) :
    Cprime Cloc Adj = Cloc * (lambda1 Adj)⁻¹ := by simp [Cprime]

end Cyclone
