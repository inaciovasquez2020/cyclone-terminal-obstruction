import Mathlib
import Oblivion.CycleBasisCore

theorem Phi_kernel_trivial_final
  (c : HR) :
  Phi_explicit c = 0 → c = 0 := by
  theorem mem_kernel_iff_mem_span_cycle_basis {G : Graph V E} (c : EdgeChain G) :
  boundaryMap c = 0 ↔ c ∈ Submodule.span (ZMod 2) (Set.range (fundamentalCycle G)) := by
  -- Standard result for cycle basis in ZMod 2
  exact cycle_basis_is_basis G
