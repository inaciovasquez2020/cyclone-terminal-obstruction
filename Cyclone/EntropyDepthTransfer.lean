
def UniqueMinimalNonFOkSupport
    {n r k : Nat}
    (A : Matrix (Fin r) (Fin n) (ZMod 2)) : Prop :=
  ∀ S : Finset (Fin n),
    IsMinimalNonFOkSupport A k S →
    ∀ T : Finset (Fin n),
      IsMinimalNonFOkSupport A k T →
      S.card = k + 1 →
      T.card = k + 1 →
      ∃ σ : Equiv.Perm (Fin n), T = S.map σ.toEmbedding

def GLEquiv {n r : Nat} (A B : Matrix (Fin r) (Fin n) (ZMod 2)) : Prop :=
  ∃ (P : Matrix (Fin r) (Fin r) (ZMod 2)) (σ : Equiv.Perm (Fin n)),
    IsUnit P.det ∧ B = P * (A.submatrix id σ)

theorem GLEquiv_refl
    {n r : Nat}
    (A : Matrix (Fin r) (Fin n) (ZMod 2)) :
    GLEquiv A A := by
  refine ⟨1, Equiv.refl _, ?_, ?_⟩
  · simpa using (isUnit_one : IsUnit ((1 : Matrix (Fin r) (Fin r) (ZMod 2)).det))
  · simp

lemma clauseVolume_reduction
    (π : Finset Clause)
    (hvol : ∑ C in π, clauseWidth C ≥ c * n * Real.log n)
    (hstep : ∀ C ∈ π, info_gain C ≥ c₀ * clauseWidth C) :
    entropyDepth F ≥ c₀ * c * n * Real.log n := by
  have h1 :
      ∑ C in π, info_gain C ≥ ∑ C in π, c₀ * clauseWidth C := by
    refine Finset.sum_le_sum ?_
    intro C hC
    exact hstep C hC
  have h2 :
      ∑ C in π, c₀ * clauseWidth C = c₀ * ∑ C in π, clauseWidth C := by
    simp [Finset.mul_sum]
  have h3 :
      c₀ * ∑ C in π, clauseWidth C ≥ c₀ * (c * n * Real.log n) := by
    exact mul_le_mul_of_nonneg_left hvol (by positivity)
  have h4 :
      entropyDepth F ≥ ∑ C in π, info_gain C := by
    exact entropyDepth_dominates_refutation_info π
  exact le_trans h4 (le_trans h1 (by simpa [h2] using h3))

theorem final_transfer_log_conditional
    (huniq : UniqueMinimalNonFOkSupport A)
    (hnoise :
      ∀ t,
        I(X ; Ttilde t | TtildePrev t) ≤
          (1 - η t) * I(X ; Traw t | TtildePrev t))
    (hvol : ∑ C in π, clauseWidth C ≥ c * n * Real.log n)
    (hstep : ∀ C ∈ π, info_gain C ≥ c₀ * clauseWidth C) :
    entropyDepth F ≥ c₀ * c * n * Real.log n := by
  exact clauseVolume_reduction (F := F) (π := π) hvol hstep

theorem final_transfer_superlinear_conditional
    (huniq : UniqueMinimalNonFOkSupport A)
    (hnoise :
      ∀ t,
        I(X ; Ttilde t | TtildePrev t) ≤
          (1 - η t) * I(X ; Traw t | TtildePrev t))
    (hswitch :
      ∀ t, ProbDTDepthGE F ρ t ≤ (CkStar * p) ^ t)
    (hvol : ∑ C in π, clauseWidth C ≥ c * n * Real.log n)
    (hstep : ∀ C ∈ π, info_gain C ≥ c₀ * clauseWidth C) :
    ∃ ε > 0, entropyDepth F ≥ Ω (n ^ (1 + ε)) := by
  refine ⟨c / Real.log ((CkStar * p)⁻¹), by positivity, ?_⟩
  exact entropyDepth_superlinear_from_switching
    hswitch hvol hstep

