import Mathlib.Data.Bool.Basic

namespace Oblivion

universe u

structure Graph where
  V : Type u
  E : Type u
  src : E → V
  dst : E → V

structure SignedGraph extends Graph where
  sign : E → Bool

inductive Sheet
  | zero
  | one
deriving DecidableEq, Repr

def flip : Sheet → Sheet
  | .zero => .one
  | .one => .zero

def stepSheet (b : Bool) (s : Sheet) : Sheet :=
  if b then flip s else s

def TwoLiftVertex (G : SignedGraph) := G.V × Sheet

def TwoLiftEdge (G : SignedGraph) := G.E × Sheet

def twoLiftSrc (G : SignedGraph) : TwoLiftEdge G → TwoLiftVertex G
  | (e, s) => (G.toGraph.src e, s)

def twoLiftDst (G : SignedGraph) : TwoLiftEdge G → TwoLiftVertex G
  | (e, s) => (G.toGraph.dst e, stepSheet (G.sign e) s)

def twoLift (G : SignedGraph) : Graph where
  V := TwoLiftVertex G
  E := TwoLiftEdge G
  src := twoLiftSrc G
  dst := twoLiftDst G

@[simp] theorem twoLift_src_fst (G : SignedGraph) (e : G.E) (s : Sheet) :
    (twoLift G).src (e, s) = (G.toGraph.src e, s) := rfl

@[simp] theorem twoLift_dst_fst (G : SignedGraph) (e : G.E) (s : Sheet) :
    (twoLift G).dst (e, s) = (G.toGraph.dst e, stepSheet (G.sign e) s) := rfl

end Oblivion
