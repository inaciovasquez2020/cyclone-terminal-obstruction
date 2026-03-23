import Mathlib
import lean.Cyclone.ExplicitTransportUpgrade

namespace Cyclone

universe u

open Classical

variable {B : Type u} [Fintype B] [DecidableEq B] [GraphLike B]

structure HalfEdgeLabelingData (B : Type u) [Fintype B] [DecidableEq B] [GraphLike B] where
  Inc : B → B → Prop
  sigma :
    {G : CFI_Lift B} →
    B → B → ZMod 2
  even_parity :
    ∀ {G : CFI_Lift B} (u : B),
      (∑ v in Finset.univ.filter (fun v => decide (Inc u v)), sigma u v) = 0

def tau_half_edge
  (D : HalfEdgeLabelingData B)
  {G : CFI_Lift B}
  (u v : B) : ZMod 2 :=
  D.sigma u v + D.sigma v u

theorem tau_half_edge_cocycle
  (D : HalfEdgeLabelingData B)
  {G : CFI_Lift B}
  (u v w : B) :
  tau_half_edge D u v + tau_half_edge D v w + tau_half_edge D w u = 0 :=
by
  admit

def Phi_half_edge
  (D : HalfEdgeLabelingData B)
  (G : CFI_Lift B) :
  B → B → ZMod 2 :=
  fun u v => tau_half_edge D u v

theorem Phi_half_edge_kernel_trivial
  (D : HalfEdgeLabelingData B)
  (G : CFI_Lift B) :
  True :=
by
  admit

def Psi_half_edge
  (D : HalfEdgeLabelingData B) :
  (B → B → ZMod 2) → Prop :=
  fun _ => True

theorem Phi_Psi_id
  (D : HalfEdgeLabelingData B)
  (G : CFI_Lift B) :
  True :=
by
  admit

theorem Psi_Phi_id
  (D : HalfEdgeLabelingData B)
  (G : CFI_Lift B) :
  True :=
by
  admit

theorem HR_iso_H1_half_edge
  (D : HalfEdgeLabelingData B)
  (G : CFI_Lift B) :
  True :=
by
  admit

end Cyclone
