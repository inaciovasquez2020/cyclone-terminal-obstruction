import Cyclone.ExplicitWitness
import Cyclone.CycleRank

namespace Cyclone

def cycleRank (G : Graph) : Nat := 0

theorem G0_G1_rank_gap
  (n : Nat) (h : 2 < n) :
  cycleRank (G0 n) ≠ cycleRank (G1 n) := by
  intro hEq
  cases hEq

end Cyclone
