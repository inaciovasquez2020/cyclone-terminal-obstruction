import lean.Oblivion.CycloneLemmas
import Oblivion.CycloneEndpointCancellation
import Mathlib.LinearAlgebra.Basic
import Mathlib.Data.ZMod.Basic

abbrev 𝔽₂ := ZMod 2

namespace Oblivion

variable {G : FinGraph}

theorem boundaryMap_edgeChain_expanded
  (G : FinGraph) (e : G.E) (v : G.V) :
  boundaryMap G (edgeChain G e) v =
    vertexDelta G (G.src e) v + vertexDelta G (G.dst e) v := by

  (G : FinGraph) (e : G.E) :
  boundaryMap G (edgeChain G e) =
    vertexDelta G (G.src e) + vertexDelta G (G.dst e) := by
  funext v

theorem boundaryMap_treePathChainBFS_split_expanded
  (G : FinGraph) (r u v : G.V) :
  boundaryMap G (treePathChainBFS G r u v) =
    boundaryMap G (edgeMemPath G (parentEdgeList G (bfsTree G r) u)) +
    boundaryMap G (edgeMemPath G (parentEdgeList G (bfsTree G r) v)) := by

theorem bfs_parent_edges_cancel_expanded
  (G : FinGraph) (r u v : G.V) :
  boundaryMap G (edgeMemPath G (parentEdgeList G (bfsTree G r) u)) +
  boundaryMap G (edgeMemPath G (parentEdgeList G (bfsTree G r) v)) =
    vertexDelta G u + vertexDelta G v := by

  (G : FinGraph) (r u v : G.V) :
  boundaryMap G (treePathChainBFS G r u v) =
    vertexDelta G u + vertexDelta G v := by

theorem fundamentalCycle'_mem_Z1_closed
  (G : FinGraph) (r : G.V) (e : G.E)
  (he : e ∈ cotreeEdges' G r) :
  fundamentalCycle' G r e ∈ Z1 G := by
  unfold Z1
  change boundaryMap G (fundamentalCycle' G r e) = 0
  unfold fundamentalCycle'
  simp [vertexDelta]

theorem Cyclone_full_simp_closed
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G σ
  FO_equiv G₀ G₁ k ∧ Z1 G₀ ≠ Z1 G₁ := by

end Oblivion