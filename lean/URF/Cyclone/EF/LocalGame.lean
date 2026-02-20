import Mathlib.Data.Finset.Basic

namespace URF.Cyclone.EF

universe u

constant Graph : Type u
constant V : Graph → Type u

structure PartialIso (G : Graph) (v w : V G) (R : Nat) where
  dummy : True

constant LocalDuplicatorWins :
  Nat → Nat → Graph → V Graph → V Graph → Prop

axiom LocalWins_to_PartialIso :
  ∀ {k r : Nat} {G : Graph} {v w : V G},
    LocalDuplicatorWins k r G v w → ∃ iso : PartialIso (G:=G) v w r, True

end URF.Cyclone.EF
