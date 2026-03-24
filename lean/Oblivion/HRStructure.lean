import Mathlib

variable {Edge : Type*}

structure HR where
  repr : Edge → ZMod 2

instance : CoeFun HR (fun _ => Edge → ZMod 2) := ⟨HR.repr⟩
