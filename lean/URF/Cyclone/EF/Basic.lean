import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic

namespace URF.Cyclone.EF

universe u

constant Graph : Type u
constant V : Graph → Type u

structure PartialIso (G H : Graph) where
  dom : Finset (V G)
  cod : Finset (V H)
  f   : {v // v ∈ dom} → {w // w ∈ cod}
  -- placeholder: adjacency/relational preservation to be added later

end URF.Cyclone.EF
