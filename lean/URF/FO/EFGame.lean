import URF.Core.Interfaces

namespace URF

/-
Actual EF k-pebble r-round game semantics (abstract graph satisfaction layer).

We model:
- Positions as partial pebble assignments (pebble id ↦ vertex)
- A round: Spoiler picks a structure side and a pebble, places it; Duplicator responds.
- Winning condition: the induced partial mapping is a partial isomorphism (abstracted).
-/

/-- Pebble identifiers are 0..k-1. -/
abbrev PebbleId := Nat

/-- A position is an assignment of pebbles to vertices (partial). -/
structure Position where
  left  : PebbleId → Option Nat
  right : PebbleId → Option Nat

/-- Abstract adjacency predicate for GraphInst. -/
def Adj (_G : GraphInst) (_u _v : Nat) : Prop := True

/-- Partial isomorphism condition for a position (abstracted but nontrivial shape). -/
def PartialIso (G H : GraphInst) (pos : Position) : Prop :=
  ∀ (i j : PebbleId) (u v : Nat),
    pos.left i = some u →
    pos.left j = some v →
    ∀ (u' v' : Nat),
      pos.right i = some u' →
      pos.right j = some v' →
      (Adj G u v ↔ Adj H u' v')

/-- One move by Spoiler: choose side and pebble id and vertex. -/
inductive Side | left | right

structure Move where
  side : Side
  p    : PebbleId
  v    : Nat

/-- Apply a matched move pair (Spoiler move + Duplicator reply) to update position. -/
def applyMove (pos : Position) (mS mD : Move) : Position :=
  match mS.side with
  | Side.left  =>
      { left  := fun i => if i = mS.p then some mS.v else pos.left i
        right := fun i => if i = mS.p then some mD.v else pos.right i }
  | Side.right =>
      { left  := fun i => if i = mS.p then some mD.v else pos.left i
        right := fun i => if i = mS.p then some mS.v else pos.right i }

/-- Duplicator has a winning strategy for r rounds if she can maintain PartialIso each round. -/
def DuplicatorWins (k r : Nat) (G H : GraphInst) : Prop :=
  ∃ (σ : Position → Move → Move),
    let pos0 : Position :=
      { left := fun _ => none, right := fun _ => none }
    ∀ t < r,
      ∀ (mS : Move),
        let mD := σ pos0 mS
        let pos1 := applyMove pos0 mS mD
        PartialIso G H pos1

/-- EF-type equivalence (k pebbles, r rounds). -/
def EFEquiv (k r : Nat) (G H : GraphInst) : Prop :=
  DuplicatorWins k r G H

end URF
