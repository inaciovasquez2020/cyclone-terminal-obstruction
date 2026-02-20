namespace URF.Cyclone

constant Δ k r : Nat
def Rstar : Nat := r

constant Graph : Type
constant deg : Graph → Nat

constant FOkConfEq : Graph → Graph → Nat → Nat → Prop
notation G " ≡conf[" k "," r "] " H => FOkConfEq G H k r

constant corankR : Nat → Graph → Nat
def corank⋆ (G : Graph) : Nat := corankR Rstar G

constant ovrankR : Nat → Graph → Nat
def ovrank⋆ (G : Graph) : Nat := ovrankR Rstar G

axiom ovrank_le_corank_sq :
  ∀ (G : Graph),
    ovrank⋆ (Δ:=Δ) (k:=k) (r:=r) G ≤
    (corank⋆ (Δ:=Δ) (k:=k) (r:=r) G) ^ 2

end URF.Cyclone
