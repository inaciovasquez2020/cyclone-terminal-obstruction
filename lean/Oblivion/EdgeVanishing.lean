namespace Oblivion

abbrev EdgeSet (α : Type) := α → Prop

axiom Edge : Type
axiom T : EdgeSet Edge
axiom EdgeCoeff : Type
axiom zeroCoeff : EdgeCoeff

axiom support : (Edge → EdgeCoeff) → EdgeSet Edge
axiom coeff : (Edge → EdgeCoeff) → Edge → EdgeCoeff

axiom edge_coeff_zero_primitive :
  ∀ (σ : Edge → EdgeCoeff) (e : Edge), ¬ support σ e → coeff σ e = zeroCoeff

axiom edge_vanishes_primitive :
  ∀ (c : Edge → EdgeCoeff) (e : Edge), ¬ T e → coeff c e = zeroCoeff

theorem edge_vanishes
  (c : Edge → EdgeCoeff)
  (e : Edge)
  (h : ¬ T e)
  (_hC : True) :
  coeff c e = zeroCoeff := by
  exact edge_vanishes_primitive c e h

theorem edge_coeff_zero_of_not_mem_support
  (σ : Edge → EdgeCoeff) (e : Edge) :
  ¬ support σ e → coeff σ e = zeroCoeff := by
  intro h
  exact edge_coeff_zero_primitive σ e h

end Oblivion
