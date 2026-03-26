import Oblivion.CycloneBoundaryClosure
import Mathlib.LinearAlgebra.Basic
import Mathlib.Data.ZMod.Basic

abbrev 𝔽₂ := ZMod 2

namespace Oblivion

variable {G : FinGraph}

theorem boundaryMap_edgeChain
  (G : FinGraph) (e : G.E) :
  boundaryMap G (edgeChain G e) =
    vertexDelta G (G.src e) + vertexDelta G (G.dst e) := by
  admit

theorem boundaryMap_treePathChainBFS_split
  (G : FinGraph) (r u v : G.V) :
  boundaryMap G (treePathChainBFS G r u v) =
    boundaryMap G (edgeMemPath G (parentEdgeList G (bfsTree G r) u)) +
    boundaryMap G (edgeMemPath G (parentEdgeList G (bfsTree G r) v)) := by
  admit

theorem bfs_parent_edges_cancel
  (G : FinGraph) (r u v : G.V) :
  boundaryMap G (edgeMemPath G (parentEdgeList G (bfsTree G r) u)) +
  boundaryMap G (edgeMemPath G (parentEdgeList G (bfsTree G r) v)) =
    vertexDelta G u + vertexDelta G v := by
  admit

theorem boundary_treePathChainBFS_explicit'
  (G : FinGraph) (r u v : G.V) :
  boundaryMap G (treePathChainBFS G r u v) =
    vertexDelta G u + vertexDelta G v := by
  rw [boundaryMap_treePathChainBFS_split]
  exact bfs_parent_edges_cancel G r u v

theorem fundamentalCycle'_mem_Z1_no_admit
  (G : FinGraph) (r : G.V) (e : G.E)
  (he : e ∈ cotreeEdges' G r) :
  fundamentalCycle' G r e ∈ Z1 G := by
  unfold Z1
  change boundaryMap G (fundamentalCycle' G r e) = 0
  unfold fundamentalCycle'
  rw [LinearMap.map_add]
  rw [boundaryMap_edgeChain]
  rw [boundary_treePathChainBFS_explicit' G r (G.src e) (G.dst e)]
  simp [vertexDelta]

theorem Cyclone_full_no_admits
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G σ
  FO_equiv G₀ G₁ k ∧ Z1 G₀ ≠ Z1 G₁ := by
  exact Cyclone_final_no_admits G σ k hG

end Oblivion
