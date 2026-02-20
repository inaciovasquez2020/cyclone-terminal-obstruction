import URF.Cyclone.Boxed

namespace URF.Cyclone

def ΔChronos : Nat := 0
def kChronos : Nat := 0
def rChronos : Nat := 0

theorem Cyclone_Chronos :
  ∀ (G : Graph),
    deg G ≤ ΔChronos →
    G ≡conf[kChronos,rChronos] G →
    ovrank⋆ (Δ:=ΔChronos) (k:=kChronos) (r:=rChronos) G ≤ (B0 ΔChronos kChronos rChronos) ^ 2 :=
by
  intro G hdeg hconf
  simpa [ΔChronos, kChronos, rChronos, ovrank⋆, corank⋆, Rstar] using
    (Cyclone (Δ:=ΔChronos) (k:=kChronos) (r:=rChronos) G hdeg hconf)

end URF.Cyclone
