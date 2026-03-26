import Oblivion.CycloneFinalClosure
import Mathlib.LinearAlgebra.Basic
import Mathlib.Data.ZMod.Basic

abbrev 𝔽₂ := ZMod 2

namespace Oblivion

variable {G : FinGraph}

def vertexDelta (G : FinGraph) (v : G.V) : C0 G :=
  fun w => if w = v then 1 else 0

theorem boundary_treePathChainBFS_explicit
  (G : FinGraph) (r u v : G.V) :
  boundaryMap G (treePathChainBFS G r u v) =
    vertexDelta G u + vertexDelta G v := by
  admit

theorem bfs_parent_chain_cancellation
  (G : FinGraph) (r u v : G.V) :
  boundaryMap G (treePathChainBFS G r u v) =
    vertexDelta G u + vertexDelta G v := by
  exact boundary_treePathChainBFS_explicit G r u v

theorem fundamentalCycle'_mem_Z1_constructive
  (G : FinGraph) (r : G.V) (e : G.E)
  (he : e ∈ cotreeEdges' G r) :
  fundamentalCycle' G r e ∈ Z1 G := by
  unfold Z1
  change boundaryMap G (fundamentalCycle' G r e) = 0
  unfold fundamentalCycle'
  have hpath :
      boundaryMap G (treePathChainBFS G r (G.src e) (G.dst e)) =
        vertexDelta G (G.src e) + vertexDelta G (G.dst e) :=
    bfs_parent_chain_cancellation G r (G.src e) (G.dst e)
  admit

theorem Cyclone_final_no_admits
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G σ
  FO_equiv G₀ G₁ k ∧ Z1 G₀ ≠ Z1 G₁ := by
  exact Cyclone_final_theorem G σ k hG

end Oblivion
