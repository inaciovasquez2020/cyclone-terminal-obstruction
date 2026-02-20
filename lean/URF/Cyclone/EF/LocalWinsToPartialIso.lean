import URF.Cyclone.EF.LocalGame
import URF.Cyclone.EF.LocalBall

namespace URF.Cyclone.EF

open Classical

theorem localWins_to_partialIso
  {G : Graph} {v w : V G} (k r : Nat) :
  LocalDuplicatorWins k r G v w → ∃ iso : PartialIso (G:=G) v w r, True := by
  intro hwin
  simpa [LocalDuplicatorWins] using hwin

end URF.Cyclone.EF
