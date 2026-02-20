import URF.Cyclone.EF.Game

namespace URF.Cyclone

open URF.Cyclone.EF

def FOkConfEq (k r : Nat) (G H : Graph) : Prop :=
  DuplicatorWins k r G H

end URF.Cyclone
