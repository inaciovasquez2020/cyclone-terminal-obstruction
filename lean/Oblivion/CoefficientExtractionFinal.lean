import Mathlib
import Oblivion.TreePathCore

open Finset

universe u

variable {V : Type u} [DecidableEq V]

abbrev Edge := Sym2 V

namespace SpanningTree

variable (T : SpanningTree V)
variable (P_T : T.PathFamily)

lemma coefficient_extraction
  (λ : Edge V → ZMod 2) :
  ∀ e : Edge V, T.OffTree e →
    ∑ f in T.edgesᶜ, λ f * T.indicator P_T e f = λ e := by
  classical
  intro e he
  calc
    ∑ f in T.edgesᶜ, λ f * T.indicator P_T e f
        = ∑ f in T.edgesᶜ, λ f * (if e = f then 1 else 0) := by
            apply sum_congr rfl
            intro f hf
            have hf' : T.OffTree f := by simpa [SpanningTree.OffTree] using hf
            simp [T.indicator_kronecker P_T he hf']
    _ = λ e := by
          rw [sum_eq_single e]
          · simp
          · intro b hb hbe
            simp [hbe]
          · intro he'
            exfalso
            exact he (by simpa using he')

lemma coefficient_zero_of_sum_zero
  (λ : Edge V → ZMod 2)
  (h0 : ∑ f in T.edgesᶜ, λ f = 0) :
  ∀ e : Edge V, T.OffTree e → λ e = 0 := by
  intro e he
  have hextract := T.coefficient_extraction P_T λ e he
  have hrewrite :
      ∑ f in T.edgesᶜ, λ f * T.indicator P_T e f = 0 := by
    have hsupp :
        ∑ f in T.edgesᶜ, λ f * T.indicator P_T e f
        = ∑ f in T.edgesᶜ, λ f * (if e = f then 1 else 0) := by
          apply sum_congr rfl
          intro f hf
          have hf' : T.OffTree f := by simpa [SpanningTree.OffTree] using hf
          simp [T.indicator_kronecker P_T he hf']
    rw [hsupp]
    rw [hextract]
    simpa using congrArg id rfl
  simpa [hextract] using hrewrite

end SpanningTree
