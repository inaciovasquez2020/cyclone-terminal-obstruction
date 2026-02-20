import URF.Cyclone.EF.Basic

namespace URF.Cyclone.EF

variable {G H : Graph}

inductive Player where
  | Spoiler
  | Duplicator

structure Position (G H : Graph) where
  pebbles : Nat
  mapG : Finset (V G)
  mapH : Finset (V H)

def Legal (G H : Graph) (p : Position G H) : Prop := True

def DuplicatorWins (k r : Nat) (G H : Graph) : Prop := True

end URF.Cyclone.EF
