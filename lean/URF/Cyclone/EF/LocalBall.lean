import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic

namespace URF.Cyclone.EF

universe u

constant Graph : Type u
constant V : Graph → Type u
constant Adj : ∀ {G : Graph}, V G → V G → Prop

constant dist : ∀ {G : Graph}, V G → V G → Nat

def BallSet (G : Graph) (v : V G) (R : Nat) : Finset (V G) :=
  Finset.univ.filter (fun w => dist v w ≤ R)

structure Ball (G : Graph) (v : V G) (R : Nat) where
  carrier : Finset (V G)
  mem_iff : ∀ w, w ∈ carrier ↔ w ∈ BallSet G v R

def IsIsoOn (G : Graph) (A B : Finset (V G)) (f : {x // x ∈ A} → {y // y ∈ B}) : Prop :=
  (∀ x1 x2, Adj x1.1 x2.1 ↔ Adj (f x1).1 (f x2).1)

structure PartialIso (G : Graph) (v w : V G) (R : Nat) where
  A : Finset (V G)
  B : Finset (V G)
  A_ok : ∀ x, x ∈ A ↔ x ∈ BallSet G v R
  B_ok : ∀ y, y ∈ B ↔ y ∈ BallSet G w R
  f : {x // x ∈ A} → {y // y ∈ B}
  bij : Function.Bijective f
  iso : IsIsoOn (G:=G) A B f

end URF.Cyclone.EF
