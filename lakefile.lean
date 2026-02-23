import Lake
open Lake DSL

package cyclone where

require std from git
  "https://github.com/leanprover/std4.git" @ "v4.27.0"

@[default_target]
lean_lib Cyclone

lean_exe cyclone where
  root := `Cyclone.Slim.Main
