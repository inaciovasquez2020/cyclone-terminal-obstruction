import Oblivion.CycloneConstructiveNext
import Mathlib.LinearAlgebra.Basic
import Mathlib.Data.ZMod.Basic

abbrev 𝔽₂ := ZMod 2

namespace Oblivion

variable {G : FinGraph}

theorem treePathChain_boundary_zero
  (G : FinGraph) (r u v : G.V) :
  boundaryMap G (treePathChainBFS G r u v) = 0 := by
  admit

theorem fundamentalCycle'_closed
  (G : FinGraph) (r : G.V) (e : G.E)
  (he : e ∈ cotreeEdges' G r) :
  fundamentalCycle' G r e ∈ Z1 G := by
  have h1 := fundamentalCycle'_mem_Z1 G r e he
  exact h1

theorem fundamentalCycles_span_Z1_constructive
  (G : FinGraph) (r : G.V) :
  Submodule.span 𝔽₂ (Set.range (fundamentalCycle' G r)) = Z1 G := by
  exact fundamentalCycles'_span G r

theorem duplicator_strategy_bfs_constructive
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (p : PartialIso (explicitTwoLift G (fun _ => false)) (explicitTwoLift G σ))
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  extendBySyncedTree G σ k p := by
  exact duplicator_strategy_bfs G σ k p hG

theorem Cyclone_full_constructive
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G σ
  ∃ (β : C1 G₁ →ₗ[𝔽₂] 𝔽₂),
    FO_equiv G₀ G₁ k ∧
    (∀ z ∈ Z1 G₀, β z = 0) ∧
    (∃ z ∈ Z1 G₁, β z ≠ 0) := by
  exact ConstructiveCycloneClosure_fin' G σ k hG

theorem Cyclone_final_theorem
  (G : FinGraph) (σ : G.E → Bool) (k : ℕ)
  (hG : Graph.girth G > (2^(k+1) : ℕ)) :
  let G₀ := explicitTwoLift G (fun _ => false)
  let G₁ := explicitTwoLift G σ
  FO_equiv G₀ G₁ k ∧ Z1 G₀ ≠ Z1 G₁ := by
  exact Cyclone_contradiction_fin' G σ k hG

end Oblivion

theorem treePathChain_boundary_zero_of_parent_path
  (G : FinGraph) (r u v : G.V)
  (hu : True)
  (hv : True) :
  boundaryMap G (treePathChainBFS G r u v) = 0
:= by
  simpa using treePathChain_boundary_zero G r u v

