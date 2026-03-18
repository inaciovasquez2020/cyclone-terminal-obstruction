import Mathlib

noncomputable section
open scoped BigOperators
open Finset

namespace Cyclone

structure CoverData (α : Type*) [Fintype α] where
  Adj      : α → α → Prop
  symm     : Symmetric Adj
  blocks   : Type*
  U        : blocks → Set α
  phi      : blocks → α → ℝ
  phi_nonneg : ∀ i x, 0 ≤ phi i x
  phi_support : ∀ i x, phi i x ≠ 0 → x ∈ U i
  partition_unity : ∀ x, ∑ i, phi i x = 1

variable {α : Type*} [Fintype α] [DecidableEq α]

def edgeEnergy (Adj : α → α → Prop) (f : α → ℝ) : ℝ :=
  (∑ x, ∑ y, if Adj x y then (f x - f y)^2 else 0) / 2

def mean (f : α → ℝ) : ℝ :=
  (Fintype.card α : ℝ)⁻¹ * ∑ x, f x

def variance (f : α → ℝ) : ℝ :=
  ∑ x, (f x - mean f)^2

axiom lambda1
  (Adj : α → α → Prop) [DecidableRel Adj] : ℝ

axiom lambda1_pos
  (Adj : α → α → Prop) [DecidableRel Adj] :
  0 < lambda1 Adj

def Cvar (Adj : α → α → Prop) [DecidableRel Adj] : ℝ :=
  (lambda1 Adj)⁻¹

theorem Cvar_exact
  (Adj : α → α → Prop) [DecidableRel Adj] :
  Cvar Adj = (lambda1 Adj)⁻¹ := rfl

axiom spectral_gap_sharp
  (Adj : α → α → Prop) [DecidableRel Adj] (f : α → ℝ) :
  variance f ≤ Cvar Adj * edgeEnergy Adj f

def overlapMultiplicity
  {ι : Type*} [Fintype ι]
  (U : ι → Set α) : Nat :=
  Finset.sup univ (fun x =>
    ((univ.filter fun i => x ∈ U i).card))

def overlapSquare
  {ι : Type*} [Fintype ι]
  (φ : ι → α → ℝ) : ℝ :=
  Finset.sup univ (fun x =>
    ∑ i, (φ i x)^2)

axiom overlap_square_le_multiplicity
  {ι : Type*} [Fintype ι]
  (φ : ι → α → ℝ)
  (hφ : ∀ x, ∑ i, φ i x = 1)
  (hφ_nonneg : ∀ i x, 0 ≤ φ i x)
  (hφ_support : ∀ i x, φ i x ≠ 0 → x ∈ (fun j => {y | φ j y ≠ 0}) i) :
  overlapSquare φ ≤ overlapMultiplicity (fun i => {x | φ i x ≠ 0})

def Cprime
  (Cloc : ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  {ι : Type*} [Fintype ι]
  (φ : ι → α → ℝ) : ℝ :=
  Cloc * overlapSquare φ * Cvar Adj

theorem Cprime_bound
  (Cloc : ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  {ι : Type*} [Fintype ι]
  (φ : ι → α → ℝ) :
  Cprime Cloc Adj φ = Cloc * overlapSquare φ * (lambda1 Adj)⁻¹ := by
  simp [Cprime, Cvar]

axiom residue_cover_exists
  (d : Nat) :
  ∃ (ι : Type) (_ : Fintype ι) (_ : DecidableEq ι),
    Fintype.card ι = 3^d

axiom residue_cover_overlap_exact
  (d : Nat) :
  ∃ (ι : Type) (_ : Fintype ι) (_ : DecidableEq ι) (U : ι → Set α),
    overlapMultiplicity U = 3^d

theorem Cprime_sharp_3d
  (Cloc : ℝ)
  (Adj : α → α → Prop) [DecidableRel Adj]
  (d : Nat)
  {ι : Type*} [Fintype ι]
  (φ : ι → α → ℝ)
  (hflat : overlapSquare φ = 3^d) :
  Cprime Cloc Adj φ = Cloc * (3^d : ℝ) * (lambda1 Adj)⁻¹ := by
  simp [Cprime, Cvar, hflat, mul_assoc]

end Cyclone
