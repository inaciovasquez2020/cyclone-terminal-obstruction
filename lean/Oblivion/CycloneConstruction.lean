namespace Oblivion

universe u

structure Graph where
  V : Type u
  E : Type u
  src : E → V
  dst : E → V

def signedLift (G : Graph) : Graph := G

def hasOddLiftCycle (G : Graph) : Prop := True

axiom lift_preserves_R_balls :
  ∀ (G : Graph) (R : Nat),
    hasOddLiftCycle G →
    True

axiom lift_creates_global_cycle :
  ∀ (G : Graph),
    hasOddLiftCycle G →
    True

end Oblivion
