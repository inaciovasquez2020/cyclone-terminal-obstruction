import Mathlib.LinearAlgebra.Matrix
import Mathlib.Data.ZMod.Basic

namespace URF.Cyclone

abbrev 𝔽 := ZMod 2

structure OverlapModel where
  m : Nat
  c : Nat
  M : Matrix (Fin m) (Fin m) 𝔽
  dim_bound : m ≤ c ^ 2

def ovrank (X : OverlapModel) : Nat := Matrix.rank X.M
def corank (X : OverlapModel) : Nat := X.c

theorem ovrank_le_corank_sq_from_dim_bound (X : OverlapModel) :
  ovrank X ≤ (corank X) ^ 2 := by
  classical
  have h0 : Matrix.rank X.M ≤ X.m := by
    simpa using (Matrix.rank_le_left (A := X.M))
  have h1 : X.m ≤ X.c ^ 2 := X.dim_bound
  exact Nat.le_trans h0 (by simpa [corank] using h1)

end URF.Cyclone
