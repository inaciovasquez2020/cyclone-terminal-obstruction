import Mathlib.Data.Finset.Basic

namespace URF.Cyclone.EF

universe u

constant Graph : Type u
constant V : Graph → Type u

constant Ball : Graph → V Graph → Nat → Type

structure PartialIso (G : Graph) (v w : V G) (R : Nat) where
  map : Ball G v R → Ball G w R
  inv : Ball G w R → Ball G v R
  left_inv : True
  right_inv : True

constant LocalDuplicatorWins :
  Nat → Nat → Graph → V Graph → V Graph → Prop

end URF.Cyclone.EF
