namespace Oblivion

structure VanishingManifold where
  Edge : Type
  T : Edge → Prop
  EdgeCoeff : Type
  zeroCoeff : EdgeCoeff
  support : (Edge → EdgeCoeff) → Edge → Prop
  coeff : (Edge → EdgeCoeff) → Edge → EdgeCoeff
  edge_vanishes_primitive :
    ∀ (c : Edge → EdgeCoeff) (e : Edge), ¬ T e → coeff c e = zeroCoeff
  edge_coeff_zero_primitive :
    ∀ (σ : Edge → EdgeCoeff) (e : Edge), ¬ support σ e → coeff σ e = zeroCoeff

constant manifold : VanishingManifold

theorem edge_vanishes
  (c : manifold.Edge → manifold.EdgeCoeff)
  (e : manifold.Edge)
  (h : ¬ manifold.T e)
  (_hC : True) :
  manifold.coeff c e = manifold.zeroCoeff := by
  exact manifold.edge_vanishes_primitive c e h

theorem edge_coeff_zero_of_not_mem_support
  (σ : manifold.Edge → manifold.EdgeCoeff) (e : manifold.Edge) :
  ¬ manifold.support σ e → manifold.coeff σ e = manifold.zeroCoeff := by
  intro h
  exact manifold.edge_coeff_zero_primitive σ e h

end Oblivion
