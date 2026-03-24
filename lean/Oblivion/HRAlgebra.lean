import Mathlib
import Oblivion.HRStructure

instance : Zero HR := ⟨⟨fun _ => 0⟩⟩

instance : Add HR :=
⟨fun a b => ⟨fun e => a e + b e⟩⟩
