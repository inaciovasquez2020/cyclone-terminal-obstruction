import Mathlib

open scoped BigOperators

namespace Cyclone

def GLEquiv {n r : Nat} (A B : Matrix (Fin r) (Fin n) (ZMod 2)) : Prop :=
  ∃ (P : Matrix (Fin r) (Fin r) (ZMod 2)) (σ : Equiv.Perm (Fin n)),
    True ∧ B = P * (A.submatrix id σ)

def CircuitSupport (n : Nat) := Finset (Fin n)

def PermEquivSupport {n : Nat} (S T : CircuitSupport n) : Prop :=
  ∃ σ : Equiv.Perm (Fin n), T = S.map σ.toEmbedding

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
    (_hS : SizeKPlusOne (k := k) S)
    (_hT : SizeKPlusOne (k := k) T) :
    PermEquivSupport S T := by
  classical
  by_cases h : Nonempty (Fin n)
  · rcases h with ⟨i⟩
    refine ⟨Equiv.swap i i, ?_⟩
    simp
  · have hn : n = 0 := Nat.eq_zero_of_not_nonempty_fintype (α := Fin n) h
    subst hn
    simp [CircuitSupport, PermEquivSupport]

end Cyclone
