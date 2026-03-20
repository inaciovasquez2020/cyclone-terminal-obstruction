import Mathlib

variable {α : Type*}

def coercivity_ratio
  (Adj : α → α → Prop) [DecidableRel Adj]
  (𝒰 : Finset (Set α)) : ℝ :=
  (lambda1 Adj) / (cover_overlap 𝒰 : ℝ)

theorem coercivity_from_poincare
  (f : α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (𝒰 : Finset (Set α))
  (hλ : 0 < lambda1 Adj)
  (hvar : variance f ≤ ((cover_overlap 𝒰 : ℝ) / lambda1 Adj) * dirichlet_form Adj f) :
  ((lambda1 Adj) / (cover_overlap 𝒰 : ℝ)) * variance f ≤ dirichlet_form Adj f := by
  by_cases hcov : (cover_overlap 𝒰 : ℝ) = 0
  · have hvar0 : variance f ≤ 0 := by
      simpa [hcov] using hvar
    have hvar_eq : variance f = 0 := le_antisymm hvar0 (variance_nonneg f)
    simp [hvar_eq, hcov, hλ.le]
  · have hcovpos : 0 < (cover_overlap 𝒰 : ℝ) := by
      linarith [show 0 ≤ (cover_overlap 𝒰 : ℝ) by exact_mod_cast Nat.zero_le _]
    have hmul :=
      mul_le_mul_of_nonneg_left hvar (div_nonneg hλ.le hcovpos.le)
    have hcancel :
        ((lambda1 Adj) / (cover_overlap 𝒰 : ℝ)) *
          (((cover_overlap 𝒰 : ℝ) / lambda1 Adj) * dirichlet_form Adj f)
        = dirichlet_form Adj f := by
      field_simp [hλ.ne', hcov]
      ring
    simpa [mul_assoc, mul_left_comm, mul_comm, hcancel] using hmul
