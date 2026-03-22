import Mathlib

variable {α : Type*}

def diminishing_value (f : ℕ → ℝ) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |f n| ≤ ε

def strictly_diminishing (f : ℕ → ℝ) : Prop :=
  ∀ n, |f (n+1)| ≤ |f n|

theorem diminishing_limit_zero
  (f : ℕ → ℝ)
  (hmono : strictly_diminishing f)
  (h : diminishing_value f) :
  Filter.Tendsto f Filter.atTop (nhds 0) := by
  exact tendsto_of_diminishing hmono h

theorem diminishing_energy_vanish
  (f : ℕ → α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (hmono : ∀ n, dirichlet_form Adj (f (n+1)) ≤ dirichlet_form Adj (f n))
  (hvanish : diminishing_value (fun n => dirichlet_form Adj (f n))) :
  Filter.Tendsto (fun n => dirichlet_form Adj (f n)) Filter.atTop (nhds 0) := by
  exact tendsto_of_diminishing_energy hmono hvanish

def finite_diminishing_value (f : ℕ → ℝ) : Prop :=
  ∃ N, ∀ n ≥ N, f n = 0

theorem finite_diminishing_implies_zero_limit
  (f : ℕ → ℝ)
  (h : finite_diminishing_value f) :
  Filter.Tendsto f Filter.atTop (nhds 0) := by
  rcases h with ⟨N, hN⟩
  refine Filter.tendsto_atTop.2 ?_
  intro ε hε
  refine ⟨N, ?_⟩
  intro n hn
  have := hN n hn
  simp [this, hε.le]

theorem finite_energy_extinction
  (f : ℕ → α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (h : finite_diminishing_value (fun n => dirichlet_form Adj (f n))) :
  ∃ N, ∀ n ≥ N, dirichlet_form Adj (f n) = 0 := by
  exact h


theorem finite_energy_implies_constant_tail
  (f : ℕ → α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (h : ∃ N, ∀ n ≥ N, dirichlet_form Adj (f n) = 0) :
  ∃ N, ∀ n ≥ N, ∀ x y, Adj x y → f n x = f n y := by
  rcases h with ⟨N, hN⟩
  refine ⟨N, ?_⟩
  intro n hn x y hxy
  have hE := hN n hn
  exact dirichlet_zero_implies_constant hE x y hxy

theorem finite_energy_implies_global_constant
  (f : ℕ → α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (hconn : graph_connected Adj)
  (h : ∃ N, ∀ n ≥ N, dirichlet_form Adj (f n) = 0) :
  ∃ N c, ∀ n ≥ N, ∀ x, f n x = c := by
  rcases h with ⟨N, hN⟩
  refine ⟨N, ?_⟩
  intro n hn
  have hconst :=
    finite_energy_implies_constant_tail f Adj ⟨N, hN⟩ n hn
  obtain ⟨c, hc⟩ := connected_constant_of_local hconn (hconst n hn)
  exact ⟨c, hc⟩


theorem finite_energy_constant_zero
  (f : ℕ → α → ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (hconn : graph_connected Adj)
  (hmean : ∀ n, mean (f n) = 0)
  (h : ∃ N, ∀ n ≥ N, dirichlet_form Adj (f n) = 0) :
  ∃ N, ∀ n ≥ N, ∀ x, f n x = 0 := by
  rcases finite_energy_implies_global_constant f Adj hconn h with ⟨N, hN⟩
  refine ⟨N, ?_⟩
  intro n hn x
  rcases hN n hn with ⟨c, hc⟩
  have hmean0 := hmean n
  have hcst : mean (fun _ => c) = c := by
    exact mean_const c
  have : c = 0 := by
    simpa [hcst, hc] using hmean0
  simpa [this] using hc x

