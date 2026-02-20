import URF.Cyclone.EFGame
import URF.Cyclone.OverlapIneq

namespace URF.Cyclone

constant Δ k r : Nat
def Rstar : Nat := r

constant Graph : Type
constant deg : Graph → Nat

constant corankR : Nat → Graph → Nat
def corank⋆ (G : Graph) : Nat := corankR Rstar G

constant ovrankR : Nat → Graph → Nat
def ovrank⋆ (G : Graph) : Nat := ovrankR Rstar G

end URF.Cyclone
