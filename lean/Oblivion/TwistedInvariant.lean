import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Basic
import Mathlib.Data.Fintype.Basic

open BigOperators

structure Graph where
  V : Type
  E : Type
  src : E → V
  dst : E → V

def C1 (G : Graph) := G.E → ZMod 2
def C0 (G : Graph) := G.V → ZMod 2

def d (G : Graph) : C1 G → C0 G :=
  fun f v => ∑ e, if G.dst e = v then f e else 0
                - ∑ e, if G.src e = v then f e else 0

def Z1 (G : Graph) := {c : C1 G // d G c = 0}
def B1 (G : Graph) := {c : C1 G // ∃ φ : C0 G, c = fun e => φ (G.dst e) - φ (G.src e)}

def H1 (G : Graph) := Quotient (fun c₁ c₂ : Z1 G => (c₁.val - c₂.val) ∈ (B1 G))

def C1_dual (G : Graph) := C1 G → ZMod 2

def Z1_dual (G : Graph) :=
  {α : C1_dual G // ∀ b ∈ B1 G, α b.val = 0}

def H1_dual (G : Graph) :=
  Quotient (fun α₁ α₂ : Z1_dual G => ∀ z ∈ Z1 G, α₁.val z.val = α₂.val z.val)

def pairing (G : Graph) :
  H1_dual G → H1 G → ZMod 2 :=
  Quot.lift₂
    (fun α c => α.val c.val)
    (by
      intro a₁ a₂ c₁ c₂ ha hc
      simp)

def Itw (G : Graph) (α : H1_dual G) : H1 G → ZMod 2 :=
  fun c => pairing G α c

