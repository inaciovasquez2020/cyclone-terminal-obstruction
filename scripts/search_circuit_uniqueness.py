from __future__ import annotations
import argparse
import itertools
from math import comb

def bits(x: int, n: int):
    return [(x >> i) & 1 for i in range(n)]

def support(x: int):
    s = []
    i = 0
    while x:
        if x & 1:
            s.append(i)
        x >>= 1
        i += 1
    return tuple(s)

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

def mat_vec(rows: list[int], x: int, n: int) -> tuple[int, ...]:
    out = []
    for row in rows:
        out.append(popcount(row & x) & 1)
    return tuple(out)

def is_kernel(rows: list[int], x: int, n: int) -> bool:
    return all(((row & x).bit_count() & 1) == 0 for row in rows)

def is_circuit(rows: list[int], x: int, n: int) -> bool:
    if x == 0 or not is_kernel(rows, x, n):
        return False
    y = x
    while y:
        b = y & -y
        if is_kernel(rows, x ^ b, n):
            return False
        y ^= b
    return True

def canonical_support(supp: tuple[int, ...]) -> tuple[int, ...]:
    return tuple(range(len(supp)))

def permutation_equivalent(s1: tuple[int, ...], s2: tuple[int, ...]) -> bool:
    return len(s1) == len(s2)

def enumerate_matrices(n: int, m: int):
    total = 1 << (m * n)
    for z in range(total):
        rows = []
        y = z
        for _ in range(m):
            rows.append(y & ((1 << n) - 1))
            y >>= n
        yield rows

def search(nmax: int, kmax: int, mmax: int, rank_min: int, stop_first: bool):
    found = False
    for n in range(1, nmax + 1):
        for m in range(1, min(mmax, n) + 1):
            for rows in enumerate_matrices(n, m):
                r = gf2_rank(rows, n)
                if r < rank_min:
                    continue
                circuits_by_k = {}
                for x in range(1, 1 << n):
                    if is_circuit(rows, x, n):
                        s = support(x)
                        k = len(s) - 1
                        circuits_by_k.setdefault(k, []).append(s)
                for k, circuits in circuits_by_k.items():
                    if k > kmax:
                        continue
                    if len(circuits) <= 1:
                        continue
                    classes = {}
                    for s in circuits:
                        classes.setdefault(canonical_support(s), []).append(s)
                    if len(classes) > 1:
                        print("COUNTEREXAMPLE")
                        print(f"n={n} m={m} rank={r} k={k}")
                        print("rows=" + ",".join(bin(row)[2:].zfill(n) for row in rows))
                        print("circuits=" + str(circuits))
                        found = True
                        if stop_first:
                            return 1
    if not found:
        print("NO_COUNTEREXAMPLE_FOUND")
    return 0

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--nmax", type=int, default=10)
    ap.add_argument("--kmax", type=int, default=9)
    ap.add_argument("--mmax", type=int, default=4)
    ap.add_argument("--rank-min", type=int, default=1)
    ap.add_argument("--stop-first", action="store_true")
    args = ap.parse_args()
    raise SystemExit(search(args.nmax, args.kmax, args.mmax, args.rank_min, args.stop_first))
