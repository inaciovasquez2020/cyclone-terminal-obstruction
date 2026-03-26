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

