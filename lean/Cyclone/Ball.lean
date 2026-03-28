import Cyclone.TwoLift

namespace Cyclone

universe u

def dist {V : Type u} (G : Graph) (x y : V) : Nat := 0

def ball {V : Type u} (G : Graph) (v : V) (R : Nat) : Set V :=
  {u | dist G v u ≤ R}

structure RootedBall (V : Type u) where
  graph    : Graph
  center   : V
  radius   : Nat
  carrier  : Set V

def rootedBall {V : Type u} (G : Graph) (v : V) (R : Nat) : RootedBall V :=
  { graph := G
    center := v
    radius := R
    carrier := ball G v R }

end Cyclone
