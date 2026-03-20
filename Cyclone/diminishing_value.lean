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
