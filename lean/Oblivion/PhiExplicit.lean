import Mathlib
import Oblivion.HRStructure

variable {Edge : Type*}

def Phi_explicit (c : HR) : ZMod 2 :=
  ∑ e, c e
