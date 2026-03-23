import Mathlib
import lean.Cyclone.CorankTransport
import lean.Cyclone.LocalGlobalTransportRigidity

namespace Cyclone

universe u

open Classical

variable {B : Type u} [Fintype B] [DecidableEq B] [GraphLike B]

structure ExplicitTransportData (B : Type u) [Fintype B] [DecidableEq B] [GraphLike B] where
  R : ℕ
  tau :
    {G : CFI_Lift B} →
    B → B → HR (V := G.V) R → ZMod 2
  tau_zero_diag :
    ∀ {G : CFI_Lift B} (x : HR (V := G.V) R) (u : B),
      tau u u x = 0
  cocycle :
    ∀ {G : CFI_Lift B} (x : HR (V := G.V) R) (u v w : B),
      tau u v x + tau v w x + tau w u x = 0

variable (D : ExplicitTransportData B)

def Phi_explicit (G : CFI_Lift B) :
    HR (V := G.V) D.R → (B × B → ZMod 2) :=
  fun x => fun p => D.tau p.1 p.2 x

theorem Phi_explicit_injective_placeholder
  (G : CFI_Lift B) :
  True :=
by
  trivial

theorem Phi_explicit_surjective_placeholder
  (G : CFI_Lift B) :
  True :=
by
  trivial

theorem HR_iso_H1_explicit_placeholder
  (G : CFI_Lift B) :
  True :=
by
  trivial

end Cyclone
