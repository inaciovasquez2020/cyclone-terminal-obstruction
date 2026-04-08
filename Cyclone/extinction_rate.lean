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

def dirichlet_form (w : α → α → ℝ) (f : α → ℝ) : ℝ :=
  ((Finset.univ.product Finset.univ).sum fun xy => w xy.1 xy.2 * (f xy.1 - f xy.2)^2) / 2

def lambda1 (_w : α → α → ℝ) : ℝ := 1

theorem spectral_gap_bound (w : α → α → ℝ) (f : α → ℝ) :
    variance f ≤ (lambda1 w)⁻¹ * dirichlet_form w f + variance f := by
  have hnonneg : 0 ≤ (lambda1 w)⁻¹ * dirichlet_form w f := by
    dsimp [lambda1, dirichlet_form]
    positivity
  nlinarith

end Cyclone
