theorem Phi_surjective
  (β : H1 B) :
  ∃ c : HR G, Phi_explicit c = β := by
  exact ⟨fun e => β e, rfl⟩
