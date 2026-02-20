import URF.Cyclone.EF.FOk

namespace URF.Cyclone

constant Δ k r : Nat
def Rstar : Nat := r

constant deg : Graph → Nat

constant LocalData : Graph → Nat → Type
constant localData : ∀ (G : Graph), V G → LocalData G Rstar

axiom FOk_transport_local :
  ∀ (G : Graph) (v w : V G),
    deg G ≤ Δ →
    FOkConfEq k r G G →
    True

end URF.Cyclone
