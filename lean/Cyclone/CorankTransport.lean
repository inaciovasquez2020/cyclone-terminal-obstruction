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
