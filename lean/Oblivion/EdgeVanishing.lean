import Mathlib
import Oblivion.CycleBasisCore

theorem edge_vanishes
  (c : Edge → ZMod 2)
  (e : Edge)
  (h : e ∉ T)
  (hC : ∀ e ∉ T, ∑ e' in C_e e, c e' = 0) :
  c e = 0 := by
  admit
