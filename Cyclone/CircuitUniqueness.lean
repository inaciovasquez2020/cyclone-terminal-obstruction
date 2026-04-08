import Mathlib.Data.Matrix.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Finset.Basic

open scoped BigOperators

def GLEquiv {n r : Nat} (A B : Matrix (Fin r) (Fin n) (ZMod 2)) : Prop :=
  ∃ (P : Matrix (Fin r) (Fin r) (ZMod 2)) (σ : Equiv.Perm (Fin n)),
    IsUnit (Matrix.det P) ∧ B = P * (A.submatrix id σ)

def CircuitSupport (n : Nat) := Finset (Fin n)

def PermEquivSupport {n : Nat} (S T : CircuitSupport n) : Prop :=
  ∃ σ : Equiv.Perm (Fin n), T = S.map σ.toEmbedding

def SizeKPlusOne {n k : Nat} (S : CircuitSupport n) : Prop := S.card = k + 1

def BinaryMatroidCircuit {n r : Nat}
    (A : Matrix (Fin r) (Fin n) (ZMod 2)) (S : CircuitSupport n) : Prop := True

theorem circuit_uniqueness_size_k_plus_one
    {n r k : Nat}
    (A : Matrix (Fin r) (Fin n) (ZMod 2))
    (S T : CircuitSupport n)
    (h1 : BinaryMatroidCircuit A S)
    (h2 : BinaryMatroidCircuit A T)
    (hS : SizeKPlusOne (k := k) S)
    (hT : SizeKPlusOne (k := k) T) :
    PermEquivSupport S T := by
  sorry
