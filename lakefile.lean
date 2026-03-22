import Lake
open Lake DSL

require mathlib from git "https://github.com/leanprover-community/mathlib4"

package «cyclone-terminal-obstruction»

@[default_target]
lean_lib Cyclone where

@[default_target]
lean_exe cyclone where
 root := `Cyclone
