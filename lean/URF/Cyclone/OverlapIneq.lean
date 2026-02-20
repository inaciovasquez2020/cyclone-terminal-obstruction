import Mathlib.LinearAlgebra.Matrix
import Mathlib.Data.ZMod.Basic
import Mathlib.LinearAlgebra.FiniteDimensional

namespace URF.Cyclone

abbrev 𝔽 := ZMod 2

structure OverlapModel where
  m : Nat
  c : Nat
  M : Matrix (Fin m) (Fin m) 𝔽

def ovrank (X : OverlapModel) : Nat := Matrix.rank X.M
def corank (X : OverlapModel) : Nat := X.c

theorem ovrank_le_corank_sq (X : OverlapModel) :
  ovrank X ≤ (corank X) ^ 2 := by
  classical
  simpa [ovrank, corank]

end URF.Cyclone
