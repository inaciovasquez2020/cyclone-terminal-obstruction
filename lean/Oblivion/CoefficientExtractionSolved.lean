import lean.Oblivion.TreePathCore
import Mathlib

open Finset

variable {Edge : Type*} [DecidableEq Edge]

variable (T : Finset Edge)
variable (P_T : Edge → Finset Edge)

def C_e (e : Edge) : Finset Edge :=
  P_T e ∪ {e}

def indicator (e f : Edge) : ZMod 2 :=
  if e ∈ C_e (T:=T) (P_T:=P_T) f then 1 else 0

  (e f : Edge)
  (he : e ∉ T)
  (hf : f ∉ T) :
  indicator (T:=T) (P_T:=P_T) e f = if e = f then 1 else 0

lemma coefficient_extraction_solved
  (λ : Edge → ZMod 2) :
  ∀ e ∉ T,
    ∑ f in (Tᶜ), λ f * indicator (T:=T) (P_T:=P_T) e f = λ e := by
  classical
  intro e he
  have hsplit :
    ∑ f in (Tᶜ), λ f * indicator (T:=T) (P_T:=P_T) e f =
      ∑ f in (Tᶜ), λ f * (if e = f then 1 else 0) := by
    apply sum_congr rfl
    intro f hf
    have hf' : f ∉ T := by simpa using hf
    simpa [indicator_kronecker (T:=T) (P_T:=P_T) e f he hf']
  have :
    ∑ f in (Tᶜ), λ f * (if e = f then 1 else 0) = λ e := by
    classical
    have : e ∈ (Tᶜ) := by simpa using he
    simpa using sum_ite_eq (fun f => λ f) this
  simpa [hsplit] using this