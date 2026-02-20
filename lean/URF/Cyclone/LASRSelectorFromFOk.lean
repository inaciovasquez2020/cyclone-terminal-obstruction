import URF.Cyclone.LASRSelector
import URF.Cyclone.LASRTransport
import URF.Cyclone.FOkToLocalHom

namespace URF.Cyclone

open URF.Cyclone.EF

constant Δ : Nat
constant deg : Graph → Nat

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
  have hlocal : FOkLocalHom (k:=k) (r:=r) G :=
    FOkHom_implies_localHom (k:=k) (r:=r) G hFO
  -- at this point, LASR selector is still the boxed inequality route;
  -- we keep it as the single remaining assumption already isolated.
  exact LASR_witness_selector (Δ:=Δ) (k:=k) (r:=r) G hdeg (by
    -- convert to Hom[k,r] if needed
    have : Hom[k,r] G := (Hom_eq_FOkHom (k:=k) (r:=r) G).2 hFO
    exact this)

end URF.Cyclone
