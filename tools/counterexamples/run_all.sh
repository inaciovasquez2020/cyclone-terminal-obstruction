#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

python3 -m venv .venv-cex || true
source .venv-cex/bin/activate
pip install --upgrade pip
pip install -r tools/counterexamples/requirements.txt

mkdir -p tools/counterexamples/out

python tools/counterexamples/bruteforce/search_cpd1_trunc_fourier.py \
  --n 6 --M 10 --coeff-abs 2 --grid 64 \
  --out tools/counterexamples/out/cpd1_bruteforce.txt

python tools/counterexamples/sat/search_cpd1_sat.py \
  --n 12 --M 10 --grid 128 --scale 1000 --target -1 \
  --out tools/counterexamples/out/cpd1_sat.txt

python tools/counterexamples/milp/search_cpd1_milp.py \
  --n 10 --M 12 --coeff-abs 3 --grid 128 --scale 1000 \
  --out tools/counterexamples/out/cpd1_milp.txt

echo "DONE. See tools/counterexamples/out/"
