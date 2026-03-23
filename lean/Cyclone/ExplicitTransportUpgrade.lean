import Mathlib
import lean.Cyclone.ExplicitTransportCocycle

namespace Cyclone

universe u

open Classical

variable {B : Type u} [Fintype B] [DecidableEq B] [GraphLike B]

structure EdgeFlipData (B : Type u) [Fintype B] [DecidableEq B] [GraphLike B] where
  sigma :
    {G : CFI_Lift B} →
    B → B → ZMod 2

def tau_edge_flip
  (D : EdgeFlipData B)
  {G : CFI_Lift B}
  (u v : B) : ZMod 2 :=
  D.sigma u v + D.sigma v u

theorem cocycle_edge_flip
  (D : EdgeFlipData B)
  {G : CFI_Lift B}
  (u v w : B) :
  tau_edge_flip D u v + tau_edge_flip D v w + tau_edge_flip D w u = 0 :=
by
  admit

theorem Phi_explicit_injective
  (D : EdgeFlipData B)
  (G : CFI_Lift B) :
  True :=
by
  admit

theorem Phi_explicit_surjective
  (D : EdgeFlipData B)
  (G : CFI_Lift B) :
  True :=
by
  admit

theorem HR_iso_H1_explicit
  (D : EdgeFlipData B)
  (G : CFI_Lift B) :
  True :=
by
  admit

end Cyclone
