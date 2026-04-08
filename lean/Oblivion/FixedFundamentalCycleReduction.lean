import Mathlib
import Oblivion.HRStructure

open Finset

variable {Edge : Type*} [DecidableEq Edge]

variable (T : Finset Edge)
variable (C_e : Edge → Finset Edge)

theorem edge_extraction
  (c : HR) (e : Edge) (h : e ∉ T) :
  c e = ∑ e' in C_e e, c e' := by
  by exact cycle_basis_is_basis G
