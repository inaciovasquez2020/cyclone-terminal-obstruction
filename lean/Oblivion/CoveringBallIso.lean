import Mathlib.Combinatorics.SimpleGraph.Basic

structure CovMap {α β} (G : SimpleGraph α) (L : SimpleGraph β) where
  f : β → α

theorem covering_stub : True := trivial
