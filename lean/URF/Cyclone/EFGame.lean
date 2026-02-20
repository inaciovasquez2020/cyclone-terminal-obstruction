namespace URF.Cyclone

constant Graph : Type
constant V : Graph → Type
constant adj : {G : Graph} → V G → V G → Prop

def Ball {G : Graph} (r : Nat) (x : V G) : Set (V G) := fun y => True

structure Pos (k : Nat) (G H : Graph) where
  p : Fin k → Option (V G × V H)

constant LegalPos : (k r : Nat) → (G H : Graph) → Pos k G H → Prop

constant Step :
  (k r : Nat) → (G H : Graph) → Pos k G H → Prop

constant DuplicatorWins : (k r : Nat) → (G H : Graph) → Prop

notation G " ≡conf[" k "," r "] " H => DuplicatorWins k r G H

end URF.Cyclone
