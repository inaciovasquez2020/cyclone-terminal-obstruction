namespace URF

structure GraphInst where
  n : Nat
  edges : List (Nat × Nat)
  maxDeg : Nat

inductive Answer
| sat | unsat | other

abbrev Alg := GraphInst → Answer

inductive Event
| query  (payload : ByteArray)
| refine (cellId : Nat) (payload : ByteArray)
| output (a : Answer)

abbrev Transcript := List Event

structure RefinementProc where
  step : GraphInst → Nat → Transcript
  out  : GraphInst → Answer

structure AdmissParams where
  k : Nat
  Δ : Nat
  r : Nat
  cap : Nat

def Admissible (_ : RefinementProc) (_ : GraphInst) (_ : AdmissParams) : Prop := True
def ΔI (_ : RefinementProc) (_ : GraphInst) (_ : Nat) : Nat := 0

end URF
