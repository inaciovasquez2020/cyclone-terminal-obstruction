import Cyclone.PsiPhiInverse
import Cyclone.PhiPsiInverse

theorem explicit_inverse_exists :
  ∃ Psi, Psi ∘ Phi_explicit = id ∧ Phi_explicit ∘ Psi = id := by
  refine ⟨Psi, ?_, ?_⟩
  · exact Psi_Phi_id
  · exact Phi_Psi_id
