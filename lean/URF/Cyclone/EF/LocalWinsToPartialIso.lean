import URF.Cyclone.EF.LocalGame
import URF.Cyclone.EF.LocalBall

namespace URF.Cyclone.EF

open Classical

-- The single Cyclone-local closure target:
theorem localWins_to_partialIso
  {G : Graph} {v w : V G} (k r : Nat) :
  LocalDuplicatorWins k r G v w → ∃ iso : PartialIso (G:=G) v w r, True := by
  intro hwin
  -- TODO: explicit construction from the Duplicator strategy on radius-r balls
  -- Replace this sorry with the extracted partial isomorphism proof.
  sorry

end URF.Cyclone.EF
