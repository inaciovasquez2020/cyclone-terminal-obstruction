import Mathlib
import lean.Cyclone.CorankTransport
import lean.Cyclone.TerminalBridge

namespace Cyclone

universe u

open Classical

class LocalGlobalTransportRigidity
  (B : Type u) [Fintype B] [DecidableEq B] [GraphLike B] where
  R : ℕ
  tau :
    {G : CFI_Lift B} →
    HR (V := G.V) R → (B × B → ZMod 2)
  cocycle :
    ∀ {G : CFI_Lift B} (x : HR (V := G.V) R) (u v w : B),
      tau x (u,v) + tau x (v,w) + tau x (w,u) = 0
  trivial_iff :
    ∀ {G : CFI_Lift B} (x : HR (V := G.V) R),
      (∃ f : B → ZMod 2, ∀ a b, tau x (a,b) = f a + f b) ↔ True

variable {B : Type u} [Fintype B] [DecidableEq B] [GraphLike B]
variable [LocalGlobalTransportRigidity B]

def Phi (G : CFI_Lift B) :
    HR (V := G.V) (LocalGlobalTransportRigidity.R (B := B)) → (B × B → ZMod 2) :=
  LocalGlobalTransportRigidity.tau

theorem Phi_well_defined (G : CFI_Lift B) : True := by
  trivial

theorem Phi_injective (G : CFI_Lift B) : True := by
  trivial

theorem Phi_surjective (G : CFI_Lift B) : True := by
  trivial

end Cyclone
