import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic

namespace URF.Cyclone

constant Graph : Type
constant V : Graph → Type

constant Δ k r : Nat
def Rstar : Nat := r

constant deg : Graph → Nat

constant CycleIndex : Graph → Type
constant overlap : (G : Graph) → CycleIndex G → CycleIndex G → Prop

constant Witness : (G : Graph) → Nat → V G → CycleIndex G → CycleIndex G → Prop

constant corankR : Nat → Graph → Nat
def corank⋆ (G : Graph) : Nat := corankR Rstar G

constant FOkConfHom : Graph → Nat → Nat → Prop
notation "Hom[" k "," r "]" G => FOkConfHom G k r

axiom LASR_witness_selector :
  ∀ (G : Graph),
    deg G ≤ Δ →
    Hom[k,r] G →
    ∃ (W : Finset (V G)),
      W.card ≤ corank⋆ (Δ:=Δ) (k:=k) (r:=r) G ∧
      (∀ i j : CycleIndex G,
        overlap G i j →
        ∃ v : V G, v ∈ W ∧ Witness G (Rstar (k:=k) (r:=r)) v i j)

end URF.Cyclone
