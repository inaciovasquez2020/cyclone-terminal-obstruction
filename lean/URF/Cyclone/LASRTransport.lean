import URF.Cyclone.EF.LocalGame
import URF.Cyclone.FOkLocal

namespace URF.Cyclone

open URF.Cyclone.EF

constant Δ : Nat
constant deg : Graph → Nat

constant LocalData : Graph → Nat → Type
constant localData : ∀ (G : Graph), V G → LocalData G r

axiom localData_invariant :
  ∀ (G : Graph) (v w : V G),
    ∀ (iso : PartialIso (G:=G) v w r),
      localData G v = localData G w

theorem LASR_transport :
  ∀ (G : Graph) (v w : V G),
    deg G ≤ Δ →
    FOkLocalHom (k:=k) (r:=r) G →
    localData G v = localData G w := by
  intro G v w hdeg hhom
  have hw : LocalDuplicatorWins k r G v w := hhom v w
  rcases URF.Cyclone.EF.partialIso_of_localWins (k:=k) (r:=r) (G:=G) (v:=v) (w:=w) hw with ⟨iso, _⟩
  exact localData_invariant G v w iso

end URF.Cyclone
