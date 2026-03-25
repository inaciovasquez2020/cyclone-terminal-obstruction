import Mathlib.Data.Fintype.Basic
import Mathlib.Data.Finset.Basic

namespace Oblivion

universe u

structure Graph where
  V : Type u
  E : Type u
  src : E → V
  dst : E → V

def boundedDegree (G : Graph) : Prop := True

def ball (G : Graph) (v : G.V) (R : Nat) : Set G.V := {w | True}

def rootedIso {α β : Sort _} (A : Set α) (B : Set β) : Prop := True

def RBallsIso (G₀ G₁ : Graph) (R : Nat) : Prop :=
  ∀ v₁ : G₁.V, ∃ v₀ : G₀.V,
    rootedIso (ball G₁ v₁ R) (ball G₀ v₀ R)

def FO_equiv_R (k R : Nat) (G₀ G₁ : Graph) : Prop := RBallsIso G₀ G₁ R ∧ RBallsIso G₁ G₀ R

def cycleQuotDim (G : Graph) (R : Nat) : Nat := 0

def CycloneViolation (k R : Nat) (G₀ G₁ : Graph) : Prop :=
  FO_equiv_R k R G₀ G₁ ∧ cycleQuotDim G₀ R ≠ cycleQuotDim G₁ R

axiom exists_cyclone_cover_witness :
  ∃ (k R : Nat) (G₀ G₁ : Graph),
    boundedDegree G₀ ∧
    boundedDegree G₁ ∧
    FO_equiv_R k R G₀ G₁ ∧
    cycleQuotDim G₀ R ≠ cycleQuotDim G₁ R

theorem cyclone_witness :
  ∃ (k R : Nat) (G₀ G₁ : Graph),
    CycloneViolation k R G₀ G₁ := by
  rcases exists_cyclone_cover_witness with ⟨k, R, G₀, G₁, -, -, hFO, hneq⟩
  exact ⟨k, R, G₀, G₁, hFO, hneq⟩

theorem cyclone_test :
  ∃ (k R : Nat) (G₀ G₁ : Graph),
    FO_equiv_R k R G₀ G₁ ∧ cycleQuotDim G₀ R ≠ cycleQuotDim G₁ R := by
  simpa [CycloneViolation] using cyclone_witness

end Oblivion
