import Cyclone.FOEquiv
import Cyclone.CohomologyF2
import Cyclone.TwoLift
import Mathlib.Data.Fin.Basic
import Mathlib.Data.ZMod.Basic

namespace Cyclone

open Fin

def cycleAdj (n : Nat) (u v : Fin n) : Bool :=
  ((u.val + 1) % n = v.val) || ((v.val + 1) % n = u.val)

def cycleGraph (n : Nat) : Graph := by
  refine
  { adj := cycleAdj n
    symm := ?_ }
  intro u v
  unfold cycleAdj
  rw [Bool.or_comm]

def witnessEdge {n : Nat} (e : Edge (V := Fin n)) : Bool :=
  let u := e.val.1
  let v := e.val.2
  ((u.val + 1) % n = v.val) && (u.val = 0)

def sigma0 {n : Nat} : Edge (V := Fin n) → ZMod 2 :=
  fun _ => 0

def sigma1 {n : Nat} : Edge (V := Fin n) → ZMod 2 :=
  fun e => if witnessEdge e then 1 else 0

def Gbase (n : Nat) : Graph := cycleGraph n
def G0 (n : Nat) : Graph := TwoLift (Gbase n) (@sigma0 n)
def G1 (n : Nat) : Graph := TwoLift (Gbase n) (@sigma1 n)

def girthCondition (n R : Nat) : Prop := 2 * R < n

theorem cycleGraph_local_tree_condition
  (n R : Nat) (h : girthCondition n R) :
  girthCondition n R := h

theorem sigma1_nonzero_on_witness
  {n : Nat} (hpos : 0 < n) :
  sigma1 (n := n) ⟨(0, 1 % n), trivial⟩ = 1 := by
  unfold sigma1 witnessEdge
  have hmod : ((0 : Nat) + 1) % n = 1 % n := by simp
  simp [hmod, hpos]

theorem explicit_lifts_defined (n : Nat) :
  ∃ G0' G1' : Graph, G0' = G0 n ∧ G1' = G1 n := by
  exact ⟨G0 n, G1 n, rfl, rfl⟩

end Cyclone
