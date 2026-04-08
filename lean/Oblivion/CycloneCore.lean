import Mathlib.Data.Finset.Basic

namespace Oblivion

/-- 
The Graph Kernel: Unifying core graph-theoretic primitives.
Includes girth, cycle space, and lift operations.
-/
structure GraphKernel where
  Graph : Type
  V : Graph → Type
  girth : Graph → ℕ∞
  Z1 : Graph → Prop
  ball : (G : Graph) → ℕ → V G → Finset (V G)
  two_lift : Graph → ((V G → V G → Bool)) → Graph

constant graph_kernel : GraphKernel

-- Projecting the kernel back to the global namespace for compatibility
abbrev Graph := graph_kernel.Graph
abbrev girth := graph_kernel.girth
abbrev Z1 := graph_kernel.Z1

end Oblivion
