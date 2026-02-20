import URF.Cyclone.LASRSelector
import URF.Cyclone.OverlapIneq

namespace URF.Cyclone

constant BasisSize : Graph → Nat
constant BuildOverlapModel :
  ∀ (G : Graph),
    BasisSize G →
    corank⋆ (Δ:=Δ) (k:=k) (r:=r) G →
    OverlapModel

axiom dim_bound_from_LASR :
  ∀ (G : Graph),
    deg G ≤ Δ →
    Hom[k,r] G →
    let m := BasisSize G
    let c := corank⋆ (Δ:=Δ) (k:=k) (r:=r) G
    in m ≤ c ^ 2

theorem ovrank_le_corank_sq_from_LASR (G : Graph)
  (hdeg : deg G ≤ Δ)
  (hhom : Hom[k,r] G) :
  let X := BuildOverlapModel G (BasisSize G) (corank⋆ (Δ:=Δ) (k:=k) (r:=r) G)
  in ovrank X ≤ (corank X) ^ 2 := by
  classical
  intro X
  have hdim :
      BasisSize G ≤
      (corank⋆ (Δ:=Δ) (k:=k) (r:=r) G) ^ 2 :=
    dim_bound_from_LASR (Δ:=Δ) (k:=k) (r:=r) G hdeg hhom
  have : X.dim_bound := by
    simpa using hdim
  exact ovrank_le_corank_sq_from_dim_bound X

end URF.Cyclone
