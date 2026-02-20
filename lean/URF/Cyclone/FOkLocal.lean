import URF.Cyclone.EF.LocalGame

namespace URF.Cyclone

open URF.Cyclone.EF

constant k r : Nat

def FOkLocalHom (G : Graph) : Prop :=
  ∀ (v w : V G),
    LocalDuplicatorWins k r G v w

end URF.Cyclone
