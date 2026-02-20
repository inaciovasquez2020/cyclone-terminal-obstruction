import URF.Cyclone.LASRSelector
import URF.Cyclone.LASRTransport

namespace URF.Cyclone

axiom LASR_selector_from_transport :
  ∀ (G : Graph),
    deg G ≤ Δ →
    Hom[k,r] G →
    ∃ (W : Finset (V G)),
      W.card ≤ corank⋆ (Δ:=Δ) (k:=k) (r:=r) G ∧
      (∀ i j : CycleIndex G,
        overlap G i j →
        ∃ v : V G, v ∈ W ∧ Witness G (Rstar (k:=k) (r:=r)) v i j)

end URF.Cyclone
