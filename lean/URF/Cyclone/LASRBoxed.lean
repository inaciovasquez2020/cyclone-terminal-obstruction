import URF.Cyclone.Interfaces.BoxedLASRnopen URF.Cyclone.Interfacesn
import URF.Cyclone.LASRSelector

namespace URF.Cyclone

constant TypesBound : Nat → Nat → Nat → Nat

  ∀ (G : Graph),
    deg G ≤ Δ →
    Hom[k,r] G →
    True →
    True

  ∀ (G : Graph),
    deg G ≤ Δ →
    Hom[k,r] G →
    TypesBound Δ k r ≤ corank⋆ (Δ:=Δ) (k:=k) (r:=r) G

  ∀ (G : Graph),
    deg G ≤ Δ →
    Hom[k,r] G →
    ∃ (W : Finset (V G)),
      W.card ≤ corank⋆ (Δ:=Δ) (k:=k) (r:=r) G ∧
      (∀ i j : CycleIndex G,
        overlap G i j →
        ∃ v : V G, v ∈ W ∧ Witness G (Rstar (k:=k) (r:=r)) v i j)

end URF.Cyclone
