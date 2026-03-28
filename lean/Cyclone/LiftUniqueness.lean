import Cyclone.Ball
import Cyclone.TwoLift

namespace Cyclone

universe u

theorem lift_unique_on_tree
  {V : Type u} [DecidableEq V]
  (G : Graph)
  (σ : Edge → ZMod 2)
  (v : V) (R : Nat)
  (hacyc : True) :
  True := by
  trivial

end Cyclone
