#!/usr/bin/env bash
set -euo pipefail

echo "[1] build"
lake build

echo "[2] focused import check"
cat > /tmp/TestOblivionChain.lean <<'EOL'
import Oblivion.TreePathCore
import Oblivion.CoefficientExtractionFinal

#check SpanningTree.path_in_tree
#check SpanningTree.fundamental_cycle_unique_edge
#check SpanningTree.indicator_kronecker
#check SpanningTree.coefficient_extraction
EOL
lake env lean /tmp/TestOblivionChain.lean

echo "[3] grep unresolved placeholders in Oblivion chain"
if grep -R -n "admit\|sorry" lean/Oblivion; then
  echo "FAIL: admit/sorry remains in lean/Oblivion"
  exit 1
fi

echo "[4] grep axioms in Oblivion chain"
if grep -R -n "axiom " lean/Oblivion; then
  echo "NOTE: axioms remain in lean/Oblivion"
  exit 2
fi

echo "PASS"
