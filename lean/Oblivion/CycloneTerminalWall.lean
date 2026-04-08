namespace Oblivion

structure TerminalWallKernel where
  Cycle : Type
  basis_count : Cycle → Nat
  parity : Cycle → Nat
  EF_high_girth_strategy : Prop
  parity_from_cycle_basis :
    ∀ σ : Cycle, parity σ = basis_count σ

constant terminalWall : TerminalWallKernel

theorem parity_from_cycle_basis_final (σ : terminalWall.Cycle) :
    terminalWall.parity σ = terminalWall.basis_count σ := by
  exact terminalWall.parity_from_cycle_basis σ

end Oblivion
