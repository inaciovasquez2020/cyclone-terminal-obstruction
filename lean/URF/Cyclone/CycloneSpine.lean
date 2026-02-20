import URF.Core.Interfaces
import URF.Math.EntropyDepth
import URF.Cyclone.Cyclone

namespace URF

def CapCeiling (C : Nat) (P : RefinementProc) (I : GraphInst) (T : Nat) : Prop :=
  sumΔI P I T ≤ C

theorem Cyclone_contradicts_ceiling
  (c C : Nat) (P : RefinementProc) (I : GraphInst) (T : Nat) :
  Cyclone c P I T → CapCeiling C P I T → c * ED I.n ≤ C := by
  intro hCy hCap
  have h1 : c * ED I.n ≤ sumΔI P I T := hCy
  have h2 : sumΔI P I T ≤ C := hCap
  exact Nat.le_trans h1 h2

end URF
