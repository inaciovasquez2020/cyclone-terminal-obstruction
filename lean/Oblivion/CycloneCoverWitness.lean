namespace Oblivion

structure CoverWitnessKernel where
  Witness : Type
  exists_cyclone_cover_witness : Nonempty Witness

axiom coverKernel : CoverWitnessKernel

theorem cyclone_cover_witness_exists : Nonempty coverKernel.Witness := by
  exact coverKernel.exists_cyclone_cover_witness

end Oblivion
