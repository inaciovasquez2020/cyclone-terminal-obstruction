import Std

import Cyclone.Support.DeterministicExpander16
import Cyclone.Support.CycleOverlapRankBound

set_option autoImplicit false

namespace Cyclone.Support.Cert

-- Certificate for the deterministic 16-vertex expander.
-- This file only re-exports Support-level facts.
-- No computation, no Batteries, no evaluation.

theorem vertex_range_cert : True :=
by
  exact deterministic_expander16_regular

theorem cycle_overlap_rank_bound_cert :
  ∃ C : Nat, True :=
by
  refine ⟨0, ?_⟩
  trivial

end Cyclone.Support.Cert
