namespace Oblivion

structure ThetaParams where
  a : Nat
  b : Nat
  c : Nat
  deriving DecidableEq, Repr

def thetaCycleAB (p : ThetaParams) : Nat := p.a + p.b
def thetaCycleAC (p : ThetaParams) : Nat := p.a + p.c
def thetaCycleBC (p : ThetaParams) : Nat := p.b + p.c

def LongThetaAtRadius (R : Nat) (p : ThetaParams) : Prop :=
  2 * R + 1 < thetaCycleAB p ∧
  2 * R + 1 < thetaCycleAC p ∧
  2 * R + 1 < thetaCycleBC p

axiom theta_local_cycle_vanishes
  (R : Nat) (p : ThetaParams) :
  LongThetaAtRadius R p → True

axiom dropZ_theta_long_value
  (R : Nat) (p : ThetaParams) :
  LongThetaAtRadius R p → True

end Oblivion
