namespace URF

/-
Overlap-rank orank(C) over F2, represented as a matrix over Bool with XOR arithmetic.
We keep this abstract: orank is provided by a certificate witness (RREF transcript).
-/

abbrev F2 := Bool

def f2add (a b : F2) : F2 := xor a b
def f2mul (a b : F2) : F2 := a && b

abbrev F2Row := List F2
abbrev F2Mat := List F2Row

structure OrankWitness where
  pivots : List Nat
  rrefRows : F2Mat

def orank_from_witness (w : OrankWitness) : Nat :=
  w.pivots.length

end URF
