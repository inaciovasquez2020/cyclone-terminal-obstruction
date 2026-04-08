import Lake
open Lake DSL

package «cyclone-terminal-obstruction» where
  -- optional metadata

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib CycloneTerminalObstruction

lean_lib Cyclone where
  roots := #[`Cyclone]

