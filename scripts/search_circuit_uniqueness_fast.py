from __future__ import annotations
import argparse
import itertools

def popcount(x: int) -> int:
    return x.bit_count()

def gf2_rank(rows: list[int], n: int) -> int:
    rows = rows[:]
    r = 0
    for c in range(n - 1, -1, -1):
        piv = None
        for i in range(r, len(rows)):
            if (rows[i] >> c) & 1:
                piv = i
                break
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        for i in range(len(rows)):
            if i != r and ((rows[i] >> c) & 1):
                rows[i] ^= rows[r]
        r += 1
        if r == len(rows):
            break
    return r

def is_kernel(rows: list[int], x: int) -> bool:
    for row in rows:
        if (row & x).bit_count() & 1:
            return False
    return True

def is_circuit(rows: list[int], x: int) -> bool:
    if x == 0 or not is_kernel(rows, x):
        return False
    y = x
    while y:
        b = y & -y
        if is_kernel(rows, x ^ b):
            return False
        y ^= b
    return True

def enumerate_matrices(n: int, m: int):
    total = 1 << (m * n)
    for z in range(total):
        rows = []
        y = z
        for _ in range(m):
            rows.append(y & ((1 << n) - 1))
            y >>= n
        yield rows

def search(nmax: int, kmax: int, mmax: int, rank_min: int, max_mats: int):
    checked = 0
    for n in range(1, nmax + 1):
        for m in range(1, min(mmax, n) + 1):
            for rows in enumerate_matrices(n, m):
                checked += 1
                if checked > max_mats:
                    print("STOP_EARLY", checked)
                    return 0
                if gf2_rank(rows, n) < rank_min:
                    continue
                circuits_by_k = {}
                for x in range(1, 1 << n):
                    if is_circuit(rows, x):
                        k = popcount(x) - 1
                        if k <= kmax:
                            circuits_by_k.setdefault(k, []).append(x)
                for k, circuits in circuits_by_k.items():
                    if len(circuits) <= 1:
                        continue
                    sizes = {popcount(c) for c in circuits}
                    if len(sizes) == 1 and list(sizes)[0] == k + 1:
                        # nontrivial family
                        print("CHECKED", checked, "n", n, "m", m, "k", k, "count", len(circuits))
    print("NO_COUNTEREXAMPLE_FOUND", checked)
    return 0

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--nmax", type=int, default=10)
    ap.add_argument("--kmax", type=int, default=9)
    ap.add_argument("--mmax", type=int, default=4)
    ap.add_argument("--rank-min", type=int, default=1)
    ap.add_argument("--max-mats", type=int, default=200000)
    args = ap.parse_args()
    raise SystemExit(search(args.nmax, args.kmax, args.mmax, args.rank_min, args.max_mats))
