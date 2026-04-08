import Mathlib
import Oblivion.CycleLinearIndependence

theorem fundamental_cycle_basis_full :
  Basis (fun e => C_e e) := by
  theorem cycle_basis_full {G : Graph V E} :
  Submodule.span (ZMod 2) (Set.range (fundamentalCycle G)) = cycleSpace G := by
  exact fundamentalCycle.is_basis G
