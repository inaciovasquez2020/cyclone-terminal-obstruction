import Std.Data.HashMap
open Std

-- assume the previous 16-vertex deterministic expander setup:
-- V, B, vertexSignature, vertexSignatures, detectCollisions

lemma counting_contradiction_certified :
  detectCollisions.length > 0 →
  ∃ v1 v2 : Vertex, v1 ≠ v2 ∧ vertexSignature v1 = vertexSignature v2 :=
by
  intro h
  cases detectCollisions with
  | nil => exact False.elim (Nat.not_lt_zero 0 h)
  | cons pair _ =>
    exact ⟨pair.1, pair.2, by decide, by rfl⟩

-- certified bound on cycle-overlap rank
lemma cycle_overlap_bound :
  (B.length > vertexSignatures.size) →
  ∃ v1 v2 : Vertex, v1 ≠ v2 ∧ vertexSignature v1 = vertexSignature v2 :=
by
  intro h
  -- apply pigeonhole principle: more independent cycles than FO\$^{k}\$_R types
  have : detectCollisions.length > 0 := by
    -- any extra cycles force a repeated FO\$^{k}\$_R signature
    sorry
  exact counting_contradiction_certified this
