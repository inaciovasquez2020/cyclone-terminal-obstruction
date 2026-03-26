import Oblivion.CycloneCore

def DuplicatorWins (G₀ G₁ : Graph) : ℕ → PartialIso G₀ G₁ → Prop
  | 0, _ => True
  | Nat.succ k, p =>
      (∀ v₀ : G₀.V,
        ∃ v₁ : G₁.V, ∃ p' : PartialIso G₀ G₁,
          p.dom ⊆ p'.dom ∧
          p.codom ⊆ p'.codom ∧
          DuplicatorWins G₀ G₁ k p') ∧
      (∀ v₁ : G₁.V,
        ∃ v₀ : G₀.V, ∃ p' : PartialIso G₀ G₁,
          p.dom ⊆ p'.dom ∧
          p.codom ⊆ p'.codom ∧
          DuplicatorWins G₀ G₁ k p')


def Extends (G₀ G₁ : Graph) (p p' : PartialIso G₀ G₁) : Prop :=
  p.dom ⊆ p'.dom ∧
  p.codom ⊆ p'.codom

theorem duplicator_step
  (G₀ G₁ : Graph) (k : ℕ) (p : PartialIso G₀ G₁) :
  DuplicatorWins G₀ G₁ (Nat.succ k) p →
  (∀ v₀ : G₀.V, ∃ v₁ p', Extends G₀ G₁ p p' ∧ DuplicatorWins G₀ G₁ k p') ∧
  (∀ v₁ : G₁.V, ∃ v₀ p', Extends G₀ G₁ p p' ∧ DuplicatorWins G₀ G₁ k p')
:= by
  intro h
  exact h


theorem duplicator_monotone
  (G₀ G₁ : Graph) (k : ℕ) (p p' : PartialIso G₀ G₁) :
  Extends G₀ G₁ p p' →
  DuplicatorWins G₀ G₁ k p' →
  DuplicatorWins G₀ G₁ k p
:= by
  intro _ h
  exact h

