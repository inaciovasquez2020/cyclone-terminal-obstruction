import Mathlib
import Oblivion.CycleLinearIndependence

theorem kernel_zero
  (c : Edge → ZMod 2) :
  (∀ e ∉ T, ∑ e' in C_e e, c e' = 0) →
  c = 0 := by
  admit
