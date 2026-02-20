namespace URF

/-
Counterexample layer.

Each structure represents a *potential falsifier*.
If any of these are instantiated with a valid witness,
the corresponding theorem upstream is false.
-/

structure BOMCounterexample where
  G : GraphInst
  measured_orank : Nat
  violates_support_compression : Prop

structure EFGameCounterexample where
  G H : GraphInst
  duplicator_wins : Prop
  global_separation : Prop

structure CycloneCounterexample where
  P : RefinementProc
  I : GraphInst
  small_information : Prop
  large_entropy_depth : Prop

end URF
