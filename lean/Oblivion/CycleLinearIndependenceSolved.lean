import lean.Oblivion.CycleLinearIndependence

theorem fundamentalCycle_independent_final : 
  LinearIndependent (ZMod 2) (fundamentalCycle G) := cycle_basis_linear_independent