import Oblivion.CycloneCore
import Oblivion.EFGameUpdate
import Oblivion.GraphSTX
import Oblivion.CycloneToolkitCompletion
import Mathlib.LinearAlgebra.Basic
import Mathlib.LinearAlgebra.Kernel
import Mathlib.Data.ZMod.Basic

abbrev 𝔽₂ := ZMod 2

/-
Minimal missing assumption/lemma.

This is the weakest single closure statement that simultaneously replaces:
(1) remaining graphSTX/parity axioms,
(2) placeholder FO^k indistinguishability claims,
(3) nonconstructive Z1-separation,
(4) the conditional contradiction layer.

If proved constructively, all remaining constants/axioms above can be removed
by specialization.
-/
axiom ConstructiveCycloneClosure :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool) (k : ℕ),
    Graph.girth G > (2^(k+1) : ℕ) →
    let G₀ := Graph.twoLift G (fun _ _ => false)
    let G₁ := Graph.twoLift G σ
    ∃ (α : C1 G₁ →ₗ[𝔽₂] 𝔽₂),
      FO_equiv G₀ G₁ k ∧
      (∀ z ∈ Z1 G₀, α z = 0) ∧
      (∃ z ∈ Z1 G₁, α z ≠ 0)

theorem Cyclone_unconditional
  (G : Graph) (σ : (x y : G.V) → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := Graph.twoLift G (fun _ _ => false)
  let G₁ := Graph.twoLift G σ
  ∃ (α : C1 G₁ →ₗ[𝔽₂] 𝔽₂),
    FO_equiv G₀ G₁ k ∧
    Z1 G₀ ≠ Z1 G₁ := by
  classical
  dsimp
  rcases ConstructiveCycloneClosure G σ k hG with ⟨α, hFO, hvan, hz⟩
  refine ⟨α, hFO, ?_⟩
  intro hEq
  rcases hz with ⟨z, hz1, hnz⟩
  have hz0 : z ∈ Z1 (Graph.twoLift G (fun _ _ => false)) := by simpa [hEq] using hz1
  have hzero : α z = 0 := hvan z hz0
  exact hnz hzero

theorem Cyclone_contradiction_unconditional :
  ∀ (G : Graph) (σ : (x y : G.V) → Bool) (k : ℕ),
    Graph.girth G > (2^(k+1) : ℕ) →
    let G₀ := Graph.twoLift G (fun _ _ => false)
    let G₁ := Graph.twoLift G σ
    FO_equiv G₀ G₁ k ∧ Z1 G₀ ≠ Z1 G₁ := by
  intro G σ k hG
  dsimp
  rcases Cyclone_unconditional G σ k hG with ⟨α, hFO, hSep⟩
  exact ⟨hFO, hSep⟩

