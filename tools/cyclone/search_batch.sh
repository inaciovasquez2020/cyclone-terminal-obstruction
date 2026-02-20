set -euo pipefail

OUTDIR="${1:-certs/cyclone/search}"
N="${2:-26}"
DELTA="${3:-3}"
K="${4:-4}"
R="${5:-2}"
START="${6:-1000}"
COUNT="${7:-500}"

mkdir -p "$OUTDIR"

i=0
seed="$START"
while [ "$i" -lt "$COUNT" ]; do
  out="$OUTDIR/CYCLONE_SEARCH_${seed}.json"
  python3 tools/cyclone/overlap_rank.py --seed "$seed" --n "$N" --Delta "$DELTA" --k "$K" --r "$R" --out "$out" >/dev/null 2>&1 || true
  i=$((i+1))
  seed=$((seed+1))
done
