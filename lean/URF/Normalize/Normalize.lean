import URF.Core.Interfaces

namespace URF

def Normalize (A : Alg) : RefinementProc :=
{ step := fun _ _ => []
, out  := fun I => A I }

theorem Normalize_preserves_out (A : Alg) :
  ∀ I, (Normalize A).out I = A I := by
  intro I; rfl

end URF
