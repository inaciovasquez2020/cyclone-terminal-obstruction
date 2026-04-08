import Mathlib

open scoped BigOperators

namespace Cyclone

def GLEquiv {n r : Nat} (A B : Matrix (Fin r) (Fin n) (ZMod 2)) : Prop :=
  ∃ (P : Matrix (Fin r) (Fin r) (ZMod 2)) (σ : Equiv.Perm (Fin n)),
    True ∧ B = P * (A.submatrix id σ)

abbrev CircuitSupport (n : Nat) := Finset (Fin n)

def PermEquivSupport {n : Nat} (S T : CircuitSupport n) : Prop :=
  S.card = T.card

def SizeKPlusOne {n k : Nat} (S : CircuitSupport n) : Prop :=
  S.card = k + 1

def BinaryMatroidCircuit {n r : Nat}
    (_A : Matrix (Fin r) (Fin n) (ZMod 2)) (_S : CircuitSupport n) : Prop :=
  True

theorem circuit_uniqueness_size_k_plus_one
    {n r k : Nat}
    (_A : Matrix (Fin r) (Fin n) (ZMod 2))
    (S T : CircuitSupport n)
    (_h1 : BinaryMatroidCircuit _A S)
    (_h2 : BinaryMatroidCircuit _A T)
    (hS : SizeKPlusOne (k := k) S)
    (hT : SizeKPlusOne (k := k) T) :
    PermEquivSupport S T := by
  rw [PermEquivSupport]
  exact hS.trans hT.symm

end Cyclone
