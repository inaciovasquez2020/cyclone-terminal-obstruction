import URF.Cyclone.EF.LocalGame

namespace URF.Cyclone

open URF.Cyclone.EF

constant Graph : Type
constant V : Graph → Type

constant k r : Nat

constant FOkConfEq : Nat → Nat → Graph → Graph → Prop
def FOkHom (G : Graph) : Prop := FOkConfEq k r G G

def FOkLocalHom (G : Graph) : Prop :=
  ∀ (v w : V G), LocalDuplicatorWins k r G v w

axiom FOkHom_implies_localHom :
  ∀ (G : Graph),
    FOkHom (k:=k) (r:=r) G →
    FOkLocalHom (k:=k) (r:=r) G

end URF.Cyclone
