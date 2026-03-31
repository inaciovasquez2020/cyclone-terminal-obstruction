import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Fintype.Basic
namespace Cyclone
abbrev F2 := ZMod 2
structure FGraph where
V : Type
E : Type
src : E → V
dst : E → V
[finV : Fintype V]
[finE : Fintype E]
end Cyclone
