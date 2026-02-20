import URF.Cyclone.EF.LocalBall
import URF.Cyclone.EF.LocalGame

namespace URF.Cyclone.EF

structure LocalStrategy (G : Graph) (v w : V G) (r : Nat) :=
  respond : ∀ x ∈ BallSet G v r, ∃ y ∈ BallSet G w r, True

theorem strategy_of_localWins
  (G : Graph) (v w : V G) :
  LocalDuplicatorWins k r G v w →
  ∃ S : LocalStrategy G v w r, True := by
  intro h
  classical
  rcases h with ⟨iso, _⟩
  refine ⟨⟨?respond⟩, trivial⟩
  intro x hx
  refine ⟨(iso.f ⟨x, ?_⟩).1, ?_, trivial⟩
  · simpa [iso.A_ok] using hx
  · simpa [iso.B_ok]
end URF.Cyclone.EF
