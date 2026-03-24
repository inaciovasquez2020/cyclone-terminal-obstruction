#!/usr/bin/env bash
set -e

echo "[1] Lean build"
lake build

echo "[2] Check for admits/sorry"
if grep -R "admit\|sorry" lean/; then
  echo "FAIL: unresolved admits/sorry found"
  exit 1
fi

echo "[3] Check key theorems exist"
grep -R "cycle_linear_independence_solved" lean/Oblivion || exit 1
grep -R "fundamental_cycle_unique_edge" lean/Oblivion || exit 1
grep -R "Phi_kernel_trivial_final" lean/Oblivion || exit 1
grep -R "HR_iso_H1_final" lean/Oblivion || exit 1

echo "[4] Basic import test"
cat > lean/TestImport.lean <<'EOL'
import Oblivion
#check cycle_linear_independence_solved
EOL

lake env lean lean/TestImport.lean

echo "[5] Clean compile check"
lake clean
lake build

echo "PASS: all structural checks satisfied"
