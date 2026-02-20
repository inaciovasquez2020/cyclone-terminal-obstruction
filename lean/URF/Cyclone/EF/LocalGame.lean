import URF.Cyclone.EF.LocalBall

namespace URF.Cyclone.EF

def LocalDuplicatorWins (k r : Nat) (G : Graph) (v w : V G) : Prop :=
  ∃ iso : PartialIso (G:=G) v w r, True

theorem partialIso_of_localWins {k r : Nat} {G : Graph} {v w : V G} :
  LocalDuplicatorWins k r G v w → ∃ iso : PartialIso (G:=G) v w r, True := by
  intro h
  simpa [LocalDuplicatorWins] using h

end URF.Cyclone.EF
