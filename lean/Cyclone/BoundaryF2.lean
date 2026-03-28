import Cyclone.CohomologyF2
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Basic
import Mathlib.LinearAlgebra.Dimension.Basic

namespace Cyclone

open scoped BigOperators

universe u

variable {V : Type u} [DecidableEq V] [Fintype V]

abbrev C0 := V → ZMod 2
abbrev C1 := Edge (V := V) → ZMod 2

def incident (v : V) (e : Edge (V := V)) : Bool :=
  let a := e.val.1
  let b := e.val.2
  (a = v) || (b = v)

def boundary (φ : C1) : C0 :=
  fun v => ∑ e, if incident v e then φ e else 0

def boundaryσ (σ : Edge (V := V) → ZMod 2) (φ : C1) : C0 :=
  fun v => ∑ e, if incident v e then φ e * σ e else 0

def boundaryσLinear (σ : Edge (V := V) → ZMod 2) : C1 →ₗ[ZMod 2] C0 where
  toFun := boundaryσ σ
  map_add' := by
    intro φ ψ; funext v
    simp [boundaryσ, ← Finset.sum_add_distrib, mul_add]
  map_smul' := by
    intro r φ; funext v
    simp [boundaryσ, Finset.mul_sum, mul_comm r, mul_assoc]

theorem boundaryσLinear_zero :
    boundaryσLinear (fun _ => (0 : ZMod 2)) = (0 : C1 →ₗ[ZMod 2] C0) := by
  ext φ v
  simp [boundaryσLinear, boundaryσ]

theorem rank_boundaryσ_zero :
    LinearMap.rank (boundaryσLinear (V := V) (fun _ => 0)) = 0 := by
  rw [boundaryσLinear_zero]
  simp [LinearMap.rank]

theorem rank_boundaryσ_one
    (σ : Edge (V := V) → ZMod 2)
    (e_star : Edge (V := V))
    (hσ : ∀ e, σ e ≠ 0 ↔ e = e_star)
    (hcol : ∃ v, incident v e_star = true) :
    LinearMap.rank (boundaryσLinear σ) = 1 := by
  apply le_antisymm
  ·
    rw [LinearMap.rank_le_iff_exists_finset]
    refine ⟨{boundaryσLinear σ (fun e => if e = e_star then 1 else 0)}, ?_⟩
    ext ψ
    simp [LinearMap.mem_range]
    use fun _ => ψ e_star
    funext v
    simp [boundaryσLinear, boundaryσ]
    congr 1
    apply Finset.sum_congr rfl
    intro e _
    by_cases he : e = e_star
    · subst he; simp
    · have : σ e = 0 := by
        have := (hσ e)
        have : σ e ≠ 0 → False := by
          intro hne; have := this.mp hne; contradiction
        have hzero : σ e = 0 := by
          classical
          by_cases hne : σ e = 0
          · exact hne
          · exact False.elim (this hne)
        exact hzero
      simp [this, he]
  ·
    rw [Nat.one_le_iff_ne_zero]
    intro h
    rw [LinearMap.rank_eq_zero_iff] at h
    obtain ⟨v, hv⟩ := hcol
    have := congr_fun (h (fun e => if e = e_star then 1 else 0)) v
    simp [boundaryσLinear, boundaryσ, hv] at this
    have hneq : σ e_star ≠ 0 := by
      have := (hσ e_star).mpr rfl
      simpa using this
    simp [hneq] at this

theorem rank_shift
    (σ₀ σ₁ : Edge (V := V) → ZMod 2)
    (hσ₀ : σ₀ = fun _ => 0)
    (e_star : Edge (V := V))
    (hσ₁ : ∀ e, σ₁ e ≠ 0 ↔ e = e_star)
    (hcol : ∃ v, incident v e_star = true) :
    LinearMap.rank (boundaryσLinear σ₁) =
    LinearMap.rank (boundaryσLinear σ₀) + 1 := by
  subst hσ₀
  rw [rank_boundaryσ_zero, zero_add]
  exact rank_boundaryσ_one σ₁ e_star hσ₁ hcol

end Cyclone
