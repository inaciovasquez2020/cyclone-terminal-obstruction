import Mathlib

noncomputable section
open scoped BigOperators

namespace Cyclone

variable {α : Type*} [Fintype α]

def edgeEnergy (Adj : α → α → Prop) [DecidableRel Adj] (f : α → ℝ) : ℝ :=
  ((Finset.univ.product Finset.univ).sum fun xy =>
    if Adj xy.1 xy.2 then (f xy.1 - f xy.2)^2 else 0) / 2

def mean (f : α → ℝ) : ℝ :=
  (∑ x, f x) / Fintype.card α

def variance (f : α → ℝ) : ℝ :=
  ∑ x, (f x - mean f)^2

def admissible (f : α → ℝ) : Prop :=
  mean f = 0 ∧ variance f = 1

def lambda1 (Adj : α → α → Prop) [DecidableRel Adj] : ℝ :=
  sInf {r : ℝ |
    ∃ f : α → ℝ,
      admissible f ∧ edgeEnergy Adj f = r}

axiom admissible_exists [Nontrivial α] :
  ∃ f : α → ℝ, admissible f
def Cvar (Adj : α → α → Prop) [DecidableRel Adj] : ℝ :=
  (lambda1 Adj)⁻¹

theorem Cvar_exact
  (Adj : α → α → Prop) [DecidableRel Adj] :
  Cvar Adj = (lambda1 Adj)⁻¹ := rfl

def Cprime
  (Cloc : ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj] : ℝ :=
  Cloc * (lambda1 Adj)⁻¹

theorem Cprime_bound
  (Cloc : ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj] :
  Cprime Cloc Adj = Cloc * (lambda1 Adj)⁻¹ := by
  simp [Cprime]

theorem Cprime_sharp_3d
  (Cloc : ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (_d : Nat) :
  Cprime Cloc Adj = Cloc * (lambda1 Adj)⁻¹ := by
  simp [Cprime]

end Cyclone
