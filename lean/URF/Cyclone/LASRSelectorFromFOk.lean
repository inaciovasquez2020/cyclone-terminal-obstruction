import URF.Cyclone.LASRSelector
import URF.Cyclone.LASRTransport
import URF.Cyclone.FOkToLocalHom

namespace URF.Cyclone

axiom Hom_eq_FOkHom :
  ∀ (G : Graph), Hom[k,r] G ↔ FOkHom (k:=k) (r:=r) G

theorem LASR_selector_from_FOkHom (G : Graph)
  (hdeg : deg G ≤ Δ)
  (hFO : FOkHom (k:=k) (r:=r) G) :
  ∃ (W : Finset (V G)),
    W.card ≤ corank⋆ (Δ:=Δ) (k:=k) (r:=r) G ∧
    (∀ i j : CycleIndex G,
      overlap G i j →
      ∃ v : V G, v ∈ W ∧ Witness G (Rstar (k:=k) (r:=r)) v i j) := by
  have : Hom[k,r] G := (Hom_eq_FOkHom (k:=k) (r:=r) G).2 hFO
  exact LASR_witness_selector (Δ:=Δ) (k:=k) (r:=r) G hdeg this

end URF.Cyclone
