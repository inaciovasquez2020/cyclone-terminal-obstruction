import URF.Cyclone.EF.Strategy
import Mathlib.Data.Finset.Card

namespace URF.Cyclone.EF

open scoped Classical

theorem partialIso_of_LocalDuplicatorWins
  (G : Graph) (v w : V G) :
  LocalDuplicatorWins k r G v w →
  PartialIso (G:=G) v w r := by
  intro h
  classical
  rcases h with ⟨iso, _⟩
  exact iso

end URF.Cyclone.EF
