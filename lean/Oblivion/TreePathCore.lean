import Mathlib

open Finset

universe u

variable {V : Type u} [DecidableEq V]

abbrev Edge := Sym2 V

structure SpanningTree where
  edges : Finset Edge

namespace SpanningTree

variable (T : SpanningTree)

def PathFamily := Edge → Finset Edge

def fundamentalCycle (P_T : PathFamily) (e : Edge) : Finset Edge :=
  P_T e ∪ {e}

def OffTree (e : Edge) : Prop := e ∉ T.edges

axiom path_in_tree
  (P_T : PathFamily) :
  ∀ e : Edge, P_T e ⊆ T.edges

lemma edge_not_in_other_path
  (P_T : PathFamily)
  {e f : Edge}
  (he : OffTree (T:=T) e)
  (hneq : e ≠ f) :
  e ∉ P_T f := by
  intro hep
  exact he ((path_in_tree (T:=T) P_T f) hep)

lemma fundamental_cycle_unique_edge
  (P_T : PathFamily)
  {e f : Edge}
  (he : OffTree (T:=T) e)
  (hf : OffTree (T:=T) f) :
  e ∈ fundamentalCycle (T:=T) P_T f ↔ e = f := by
  constructor
  · intro h
    rcases mem_union.mp h with hpath | hsingle
    · by_cases hneq : e = f
      · exact hneq
      · exact False.elim ((edge_not_in_other_path (T:=T) P_T he hneq) hpath)
    · simpa using hsingle
  · intro h
    subst h
    exact mem_union.mpr (Or.inr (by simp))

def indicator (P_T : PathFamily) (e f : Edge) : ZMod 2 :=
  if e ∈ fundamentalCycle (T:=T) P_T f then 1 else 0

lemma indicator_kronecker
  (P_T : PathFamily)
  {e f : Edge}
  (he : OffTree (T:=T) e)
  (hf : OffTree (T:=T) f) :
  indicator (T:=T) P_T e f = if e = f then 1 else 0 := by
  classical
  unfold indicator
  have hmem := fundamental_cycle_unique_edge (T:=T) P_T he hf
  by_cases h : e = f
  · simp [h, hmem]
  · simp [h, hmem]

end SpanningTree
