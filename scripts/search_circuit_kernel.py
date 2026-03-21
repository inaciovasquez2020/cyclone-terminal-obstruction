from __future__ import annotations
import argparse

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
        if ((row & x).bit_count() & 1) != 0:
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

def xor_rows(rows: list[int], mask: int) -> int:
    out = 0
    i = 0
    x = mask
    while x:
        if x & 1:
            out ^= rows[i]
        x >>= 1
        i += 1
    return out

def equivalent_kernel(rows: list[int], s1: int, s2: int) -> bool:
    return xor_rows(rows, s1 ^ s2) == 0

def enumerate_matrices(n: int, m: int, max_mats: int):
    total = min(1 << (m * n), max_mats)
    for z in range(total):
        rows = []
        y = z
        for _ in range(m):
            rows.append(y & ((1 << n) - 1))
            y >>= n
        yield rows, z + 1, total

def search(nmax: int, kmax: int, mmax: int, rank_min: int, max_mats: int):
    collapsed_any = False
    for n in range(1, nmax + 1):
        for m in range(1, min(mmax, n) + 1):
            for rows, idx, total in enumerate_matrices(n, m, max_mats):
                if gf2_rank(rows, n) < rank_min:
                    continue
                circuits = {}
                for x in range(1, 1 << n):
                    if is_circuit(rows, x):
                        k = x.bit_count() - 1
                        if k <= kmax:
                            circuits.setdefault(k, []).append(x)
                for k, vals in circuits.items():
                    if len(vals) <= 1:
                        continue
                    classes: list[list[int]] = []
                    for v in vals:
                        placed = False
                        for cls in classes:
                            if equivalent_kernel(rows, v, cls[0]):
                                cls.append(v)
                                placed = True
                                break
                        if not placed:
                            classes.append([v])
                    if len(classes) < len(vals):
                        collapsed_any = True
                    if len(classes) > 1:
                        print(
                            "NON-UNIQUE-KERNEL",
                            f"n={n}",
                            f"m={m}",
                            f"k={k}",
                            f"mat={idx}/{total}",
                            f"circuits={len(vals)}",
                            f"classes={len(classes)}"
                        )
    if collapsed_any:
        print("KERNEL_COLLAPSE_OBSERVED")
    else:
        print("NO_KERNEL_COLLAPSE_OBSERVED")
    print("DONE")

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--nmax", type=int, default=8)
    ap.add_argument("--kmax", type=int, default=7)
    ap.add_argument("--mmax", type=int, default=3)
    ap.add_argument("--rank-min", type=int, default=1)
    ap.add_argument("--max-mats", type=int, default=50000)
    args = ap.parse_args()
    search(args.nmax, args.kmax, args.mmax, args.rank_min, args.max_mats)
