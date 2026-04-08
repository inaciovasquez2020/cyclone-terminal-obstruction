import Mathlib

theorem cycle_linear_independence
  (λ : Edge → ZMod 2) :
  (∑ e, λ e • C_e e = 0) →
  ∀ e, λ e = 0 := by
  theorem cycle_basis_linear_independent {G : Graph V E} :
  LinearIndependent (ZMod 2) (fundamentalCycle G) := by
  -- Each fundamental cycle e_i contains exactly one edge from the co-tree
  -- which does not appear in any other basis cycle.
  exact fundamentalCycle.linearIndependent G
