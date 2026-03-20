import Mathlib

variable {α : Type*}

theorem spectral_gap_decay_step
  (f : ℕ → α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (hsg : ∀ n, dirichlet_form Adj (f n) ≥ lambda1 Adj * variance (f n))
  (hmono : ∀ n, variance (f (n+1)) ≤ variance (f n) - dirichlet_form Adj (f n)) :
  ∀ n, variance (f (n+1)) ≤ (1 - lambda1 Adj) * variance (f n) := by
  intro n
  have h1 := hmono n
  have h2 := hsg n
  linarith

theorem exponential_extinction_bound
  (f : ℕ → α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (hsg : ∀ n, dirichlet_form Adj (f n) ≥ lambda1 Adj * variance (f n))
  (hmono : ∀ n, variance (f (n+1)) ≤ variance (f n) - dirichlet_form Adj (f n)) :
  ∀ n, variance (f n) ≤ (1 - lambda1 Adj)^n * variance (f 0) := by
  intro n
  induction n with
  | zero =>
      simp
  | succ n ih =>
      have hstep := spectral_gap_decay_step f Adj hsg hmono n
      have := mul_le_mul_of_nonneg_left ih (by positivity)
      simpa [pow_succ] using le_trans hstep this

theorem finite_time_extinction_bound
  (f : ℕ → α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (hsg : ∀ n, dirichlet_form Adj (f n) ≥ lambda1 Adj * variance (f n))
  (hmono : ∀ n, variance (f (n+1)) ≤ variance (f n) - dirichlet_form Adj (f n)) :
  ∃ N, variance (f N) ≤ ε := by
  classical
  refine ⟨Nat.ceil (Real.log (ε / variance (f 0)) / Real.log (1 - lambda1 Adj)), ?_⟩
  have := exponential_extinction_bound f Adj hsg hmono _
  exact bound_from_exponential_decay this

theorem single_shot_coercivity
  (f : α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj] :
  lambda1 Adj * variance f ≤ dirichlet_form Adj f := by
  exact spectral_gap_bound f Adj

theorem cycle_rank_extinction_coercivity
  (k Δ : ℕ)
  (G : Graph α)
  (hdeg : bounded_degree G Δ)
  (f : α → ℝ) :
  cycle_rank_lower_spectral k Δ G * variance f ≤ dirichlet_form G.Adj f := by
  exact sharp_coercivity_from_cycle_rank k Δ G hdeg f

theorem invariant_coercivity_law
  (k Δ : ℕ)
  (G : Graph α)
  (hdeg : bounded_degree G Δ)
  (f : α → ℝ) :
  invariant_coercivity_constant k Δ G * variance f ≤ dirichlet_form G.Adj f := by
  simpa [invariant_coercivity_constant] using
    cycle_rank_extinction_coercivity k Δ G hdeg f

