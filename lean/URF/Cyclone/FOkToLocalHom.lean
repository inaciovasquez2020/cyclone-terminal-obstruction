import URF.Cyclone.Interfaces.BoxedLASRnopen URF.Cyclone.Interfacesn
import URF.Cyclone.LASRSelector
import URF.Cyclone.EF.LocalGame

namespace URF.Cyclone

open URF.Cyclone.EF

def FOkHom (G : Graph) : Prop := FOkConfEq k r G G

def FOkLocalHom (G : Graph) : Prop :=
  ∀ (v w : V G), LocalDuplicatorWins k r G v w

  ∀ (G : Graph),
    FOkHom (k:=k) (r:=r) G →
    FOkLocalHom (k:=k) (r:=r) G

end URF.Cyclone
