import URF.Cyclone.Interfaces.BoxedLASRnopen URF.Cyclone.Interfacesn
import URF.Cyclone.Defs

namespace URF.Cyclone

constant B0 : Nat → Nat → Nat → Nat

  ∀ (G : Graph),
    deg G ≤ Δ →
    G ≡conf[k,r] G →
    corank⋆ (Δ:=Δ) (k:=k) (r:=r) G ≤ B0 Δ k r

  ∀ (G : Graph),
    ovrank⋆ (Δ:=Δ) (k:=k) (r:=r) G ≤
    (corank⋆ (Δ:=Δ) (k:=k) (r:=r) G) ^ 2

theorem Cyclone :
  ∀ (G : Graph),
    deg G ≤ Δ →
    G ≡conf[k,r] G →
    ovrank⋆ (Δ:=Δ) (k:=k) (r:=r) G ≤ (B0 Δ k r) ^ 2 :=
by
  intro G hdeg hconf
  have h1 := Boxed (Δ:=Δ) (k:=k) (r:=r) G hdeg hconf
  have h2 := ovrank_le_corank_sq (Δ:=Δ) (k:=k) (r:=r) G
  exact Nat.le_trans h2 (by
    have := Nat.pow_le_pow_of_le_left (Nat.zero_le _) h1 2
    simpa)

end URF.Cyclone
