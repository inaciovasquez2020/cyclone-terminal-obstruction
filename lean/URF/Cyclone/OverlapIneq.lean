import Mathlib.LinearAlgebra.Matrix
import Mathlib.LinearAlgebra.FiniteDimensional
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

namespace URF.Cyclone

abbrev 𝔽 := ZMod 2

structure OverlapModel where
  m : Nat
  c : Nat
  M : Matrix (Fin m) (Fin m) 𝔽
  row_supports :
    ∀ i : Fin m, ∃ (U : Submodule 𝔽 (Fin m → 𝔽)),
      FiniteDimensional.finrank 𝔽 U ≤ c ∧
      (∀ j, M i j ≠ 0 → (fun k => if k = j then (1:𝔽) else 0) ∈ U)

def ovrank (X : OverlapModel) : Nat := Matrix.rank X.M
def corank (X : OverlapModel) : Nat := X.c

theorem ovrank_le_corank_sq (X : OverlapModel) :
  ovrank X ≤ (corank X) ^ 2 := by
  classical
  sorry

end URF.Cyclone
