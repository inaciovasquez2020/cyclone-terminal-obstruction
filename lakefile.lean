import Lake
open Lake DSL

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "master"

package «cyclone-terminal-obstruction» {}

lean_lib Cyclone

@[default_target]
lean_exe Main where
  root := `Main
