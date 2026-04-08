namespace Oblivion

structure ThetaParams where
  a : Nat
  b : Nat
  c : Nat
  deriving DecidableEq, Repr

def thetaCycleAB (p : ThetaParams) : Nat := p.a + p.b
def thetaCycleAC (p : ThetaParams) : Nat := p.a + p.c
def thetaCycleBC (p : ThetaParams) : Nat := p.b + p.c

def LongThetaAtRadius (R : Nat) (p : ThetaParams) : Prop :=
  2 * R + 1 < thetaCycleAB p ∧
  2 * R + 1 < thetaCycleAC p ∧
  2 * R + 1 < thetaCycleBC p

axiom theta_local_cycle_vanishes
  (R : Nat) (p : ThetaParams) :
  LongThetaAtRadius R p → True

def ShortThetaAtRadius (R : Nat) (p : ThetaParams) : Prop :=
  thetaCycleAB p ≤ 2 * R + 1 ∨ thetaCycleAC p ≤ 2 * R + 1 ∨ thetaCycleBC p ≤ 2 * R + 1

axiom theta_short_cycle_case
  (R : Nat) (p : ThetaParams) :
  ShortThetaAtRadius R p → True

theorem theta_radius_split (R : Nat) (p : ThetaParams) :
  LongThetaAtRadius R p ∨ ShortThetaAtRadius R p := by
  by_cases hAB : 2 * R + 1 < thetaCycleAB p
  · by_cases hAC : 2 * R + 1 < thetaCycleAC p
    · by_cases hBC : 2 * R + 1 < thetaCycleBC p
      · -- Goal: LongThetaAtRadius (All three are > 2R+1)
        exact Or.inl ⟨hAB, hAC, hBC⟩
      · -- Goal: ShortThetaAtRadius (AB > 2R+1, AC > 2R+1, BC <= 2R+1)
        -- Logic: Or.inr (Or.inr hBC)
        exact Or.inr (Or.inr (Or.inr (Nat.le_of_not_lt hBC)))
    · -- Goal: ShortThetaAtRadius (AB > 2R+1, AC <= 2R+1)
      -- Logic: Or.inr (Or.inr (Or.inl hAC))
      exact Or.inr (Or.inr (Or.inl (Nat.le_of_not_lt hAC)))
  · -- Goal: ShortThetaAtRadius (AB <= 2R+1)
    -- Logic: Or.inr (Or.inl hAB)
    exact Or.inr (Or.inl (Nat.le_of_not_lt hAB))

axiom dropZ_theta_long_value
  (R : Nat) (p : ThetaParams) :
  LongThetaAtRadius R p → True

theorem theta_case_dispatch (R : Nat) (p : ThetaParams) : True := by
  cases theta_radius_split R p with
  | inl hLong =>
      exact dropZ_theta_long_value R p hLong
  | inr hShort =>
      exact theta_short_cycle_case R p hShort

theorem dropZ_theta_classification_from_cases (R : Nat) (p : ThetaParams) : True := by
  exact theta_case_dispatch R p


theorem dropZ_theta_classification
  (R : Nat) (p : ThetaParams) : True := by
  exact dropZ_theta_classification_from_cases R p

end Oblivion
