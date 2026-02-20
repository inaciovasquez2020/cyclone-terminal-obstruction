import URF.Core.Interfaces
namespace URF
/-
EF-type encoding layer (next logical layer).
This file defines:
Rooted balls (radius-r neighborhoods, abstracted)
An abstract EF-equivalence relation (to be instantiated later)
A "type id" function as a placeholder for the quotient map
-/
structure RootedBall where
r : Nat
n : Nat
root : Nat
edges : List (Nat × Nat)
def EFEquiv (k rounds : Nat) (A B : RootedBall) : Prop := True
abbrev EFTypeId := String
def EFType (k rounds : Nat) (B : RootedBall) : EFTypeId :=
"EF(" ++ toString k ++ "," ++ toString rounds ++ "):r=" ++ toString B.r ++ ":n=" ++ toString B.n
end URF
