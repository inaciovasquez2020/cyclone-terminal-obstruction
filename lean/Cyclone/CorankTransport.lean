import Mathlib

namespace Cyclone

universe u

open Classical

class GraphLike (V : Type u) where
  Adj : V → V → Prop
  symm : Symmetric Adj

variable {V : Type u} [Fintype V] [DecidableEq V] [GraphLike V]

abbrev F2 := ZMod 2

structure LocalCycle (R : ℕ) where
  center : V
  carrier : Finset V
  coeff : V → F2

structure TransportDatum (R : ℕ) where
  src : LocalCycle (V := V) R
  dst : LocalCycle (V := V) R

inductive TransportRel (R : ℕ) : LocalCycle (V := V) R → LocalCycle (V := V) R → Prop
| base : ∀ t : TransportDatum (V := V) R, TransportRel R t.src t.dst
| refl : ∀ x, TransportRel R x x
| symm : ∀ {x y}, TransportRel R x y → TransportRel R y x
| trans : ∀ {x y z}, TransportRel R x y → TransportRel R y z → TransportRel R x z

instance (R : ℕ) : Setoid (LocalCycle (V := V) R) where
  r := TransportRel (V := V) R
  iseqv :=
    ⟨TransportRel.refl (V := V) R,
     @TransportRel.symm V _ _ R,
     @TransportRel.trans V _ _ R⟩

def HR (R : ℕ) :=
  Quot (inferInstance : Setoid (LocalCycle (V := V) R))

def corankR (R : ℕ) : ℕ :=
  Fintype.card (HR (V := V) R)

end Cyclone

namespace Cyclone

variable {B : Type u} [Fintype B] [DecidableEq B] [GraphLike B]

structure CFI_Lift (B : Type u) where
  V : Type u
  proj : V → B

def lift_cocycle (G : CFI_Lift B) (α : B → F2) : LocalCycle (V := G.V) 0 :=
{ center := Classical.choice inferInstance
, carrier := Finset.univ
, coeff := fun _ => 0 }

theorem HR_iso_H1
  (G : CFI_Lift B) :
  Nonempty (HR (V := G.V) 0 ≃ (B → F2)) :=
by
  admit
theorem corank_nontrivial
  (G₀ G₁ : CFI_Lift B)
  (α : B → F2)
  (hα : α ≠ 0) :
  corankR (V := G₀.V) 0 ≠ corankR (V := G₁.V) 0 :=
by
  admit
end Cyclone
