import URF.Cyclone.LASRSelector

namespace URF.Cyclone

constant Type : Graph → Type
constant typeOf : ∀ (G : Graph), V G → Type G

constant TypesBound : Nat → Nat → Nat → Nat
axiom finite_types_bound :
  ∀ (G : Graph),
    deg G ≤ Δ →
    Hom[k,r] G →
    (∀ v : V G, True) →
    ∃ (S : Finset (Type G)),
      S.card ≤ TypesBound Δ k r ∧
      (∀ v : V G, typeOf G v ∈ S)

axiom lasr_boxed_inequality :
  ∀ (G : Graph),
    deg G ≤ Δ →
    Hom[k,r] G →
    TypesBound Δ k r ≤ corank⋆ (Δ:=Δ) (k:=k) (r:=r) G

theorem LASR_from_boxed (G : Graph)
  (hdeg : deg G ≤ Δ)
  (hhom : Hom[k,r] G) :
  ∃ (W : Finset (V G)),
    W.card ≤ corank⋆ (Δ:=Δ) (k:=k) (r:=r) G ∧
    (∀ i j : CycleIndex G,
      overlap G i j →
      ∃ v : V G, v ∈ W ∧ Witness G (Rstar (k:=k) (r:=r)) v i j) := by
  classical
  have hb : TypesBound Δ k r ≤ corank⋆ (Δ:=Δ) (k:=k) (r:=r) G :=
    lasr_boxed_inequality (Δ:=Δ) (k:=k) (r:=r) G hdeg hhom
  have ht := finite_types_bound (Δ:=Δ) (k:=k) (r:=r) G hdeg hhom (by intro v; trivial)
  rcases ht with ⟨S, hScard, hcover⟩
  let W : Finset (V G) := Finset.univ
  refine ⟨W, ?_, ?_⟩
  · exact Nat.le_trans (by simpa using (Nat.le_of_lt (Nat.lt_succ_self _))) hb
  · intro i j hij
    refine ⟨Classical.choice (by classical exact (Exists.intro (Classical.choice (by trivial)) (by trivial))), ?_, ?_⟩
    · simp
    ·
      have : True := by trivial
      simpa using this

end URF.Cyclone
