import Cyclone.Ball
import Cyclone.TwoLift
import Cyclone.CohomologyF2
import Mathlib.Data.ZMod.Basic

namespace Cyclone

universe u

variable {V : Type u} [DecidableEq V]

abbrev FiberBit := ZMod 2

def cocycleAccum (σ : Edge → ZMod 2) (p : List Edge) : ZMod 2 :=
  (p.foldl (fun acc e => acc + σ e) 0)

def pathLiftBit
  (σ : Edge → ZMod 2)
  (rootBit : FiberBit)
  (p : List Edge) : FiberBit :=
  rootBit + cocycleAccum σ p

def parityConsistent
  (σ : Edge → ZMod 2)
  (rootBit : FiberBit)
  (p : List Edge) : Prop :=
  pathLiftBit σ rootBit p = rootBit + cocycleAccum σ p

theorem parity_consistency
  (σ : Edge → ZMod 2)
  (rootBit : FiberBit)
  (p : List Edge) :
  parityConsistent σ rootBit p := by
  rfl

def TreeLiftFn := List Edge → FiberBit

def treeLift
  (σ : Edge → ZMod 2)
  (rootBit : FiberBit) : TreeLiftFn :=
  fun p => pathLiftBit σ rootBit p

theorem treeLift_root
  (σ : Edge → ZMod 2)
  (rootBit : FiberBit) :
  treeLift σ rootBit [] = rootBit := by
  simp [treeLift, pathLiftBit, cocycleAccum]

theorem treeLift_step
  (σ : Edge → ZMod 2)
  (rootBit : FiberBit)
  (p : List Edge)
  (e : Edge) :
  treeLift σ rootBit (p ++ [e]) = treeLift σ rootBit p + σ e := by
  simp [treeLift, pathLiftBit, cocycleAccum, List.foldl_append, add_assoc, add_left_comm, add_comm]

theorem treeLift_unique
  (σ : Edge → ZMod 2)
  (rootBit : FiberBit)
  (f g : TreeLiftFn)
  (hf0 : f [] = rootBit)
  (hg0 : g [] = rootBit)
  (hstepf : ∀ p e, f (p ++ [e]) = f p + σ e)
  (hstepg : ∀ p e, g (p ++ [e]) = g p + σ e) :
  f = g := by
  funext p
  induction p with
  | nil =>
      exact hf0.trans hg0.symm
  | cons e ps ih =>
      have hpf : f (([] : List Edge) ++ (e :: ps)) = g (([] : List Edge) ++ (e :: ps)) := by
        clear ih
        induction ps generalizing e with
        | nil =>
            simp at hf0 hg0
            simpa using congrArg (fun x => x + σ e) (hf0.trans hg0.symm)
        | cons e' ps ih' =>
            have hs1 := hstepf ([e] ++ ps) e'
            have hs2 := hstepg ([e] ++ ps) e'
            have base : f ([e] ++ ps) = g ([e] ++ ps) := ih'
            simpa [List.append_assoc, add_assoc, add_left_comm, add_comm] using congrArg (fun x => x + σ e') base
      simpa using hpf

theorem treeLift_injective
  (σ : Edge → ZMod 2) :
  Function.Injective (treeLift σ) := by
  intro a b h
  have h0 := congrArg (fun f => f []) h
  simpa [treeLift, pathLiftBit, cocycleAccum] using h0

end Cyclone
