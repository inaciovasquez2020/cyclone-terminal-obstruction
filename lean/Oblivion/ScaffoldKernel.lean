import lean.Oblivion.CycloneCore

namespace Oblivion

/-- 
The Scaffold Kernel: Unifying tree constructions and 
isomorphism strategies for local-to-global rigidity.
-/
structure ScaffoldKernel where
  spanningTree : Graph → Type
  bfsTree : Graph → Type
  treePathChain : Graph → Type
  ef_strategy : Graph → Graph → ℕ → Prop
  vanishes_on_lift : Prop
  nonzero_on_twist : Prop

constant scaffold : ScaffoldKernel

end Oblivion
