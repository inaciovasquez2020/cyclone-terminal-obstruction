import lean.Oblivion.TreePathCore
import Mathlib

open Finset

variable {Edge : Type*} [DecidableEq Edge]

variable (T : Finset Edge)
variable (P_T : Edge → Finset Edge)

def C_e (f : Edge) : Finset Edge :=
  P_T f ∪ {f}

  ∀ f : Edge, P_T f ⊆ T

lemma edge_not_in_other_path
  (e f : Edge)
  (he : e ∉ T)
  (hneq : e ≠ f) :
  e ∉ P_T f := by
  intro hep
  exact he ((path_in_tree (T:=T) (P_T:=P_T) f) hep)

lemma indicator_kronecker_solved
  (e f : Edge)
  (he : e ∉ T)
  (hf : f ∉ T) :
  (e ∈ C_e (T:=T) (P_T:=P_T) f) ↔ e = f := by
  constructor
  · intro h
    rcases mem_union.mp h with hpath | hsingle
    · exact False.elim ((edge_not_in_other_path (T:=T) (P_T:=P_T) e f he (by aesop)) hpath)
    · simpa using hsingle
  · intro h
    subst h
    exact mem_union.mpr (Or.inr (by simp))