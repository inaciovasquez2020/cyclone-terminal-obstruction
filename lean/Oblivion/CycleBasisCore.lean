import Mathlib
import Oblivion.HRStructure

open Finset

variable {Edge : Type*} [DecidableEq Edge]

variable (T : Finset Edge)
variable (C_e : Edge → Finset Edge)

theorem fundamental_cycle_basis_core
  (c : Edge → ZMod 2) :
  (∀ e ∉ T, ∑ e' in C_e e, c e' = 0) →
  c = 0 := by
  by intros; exact fundamentalCycle.is_cycle G _
