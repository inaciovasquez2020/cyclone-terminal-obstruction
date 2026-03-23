theorem HR_iso_H1 :
  HR G ≃ H1 B :=
{ toFun := Phi_explicit,
  invFun := fun β => fun e => β e,
  left_inv := by intros; ext; simp,
  right_inv := by intros; ext; simp }
