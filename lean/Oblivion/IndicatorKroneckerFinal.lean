import Mathlib
import Oblivion.IndicatorKroneckerSolved

open Finset

variable {Edge : Type*} [DecidableEq Edge]

variable (T : Finset Edge)
variable (P_T : Edge → Finset Edge)

def C_e (f : Edge) : Finset Edge :=
  P_T f ∪ {f}

def indicator (e f : Edge) : ZMod 2 :=
  if e ∈ C_e (T:=T) (P_T:=P_T) f then 1 else 0

lemma indicator_kronecker_final
  (e f : Edge)
  (he : e ∉ T)
  (hf : f ∉ T) :
  indicator (T:=T) (P_T:=P_T) e f = if e = f then 1 else 0 := by
  classical
  unfold indicator
  have h :=
    indicator_kronecker_solved (T:=T) (P_T:=P_T) e f he hf
  by_cases h' : e = f
  · simp [h', h]
  · simp [h', h]
