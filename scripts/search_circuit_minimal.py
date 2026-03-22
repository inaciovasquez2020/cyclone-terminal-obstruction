from __future__ import annotations
import argparse

def is_kernel(rows: list[int], x: int) -> bool:
    for row in rows:
        if ((row & x).bit_count() & 1) != 0:
            return False
    return True

def is_minimal_support(rows: list[int], x: int) -> bool:
    if x == 0 or not is_kernel(rows, x):
        return False
    y = x
    while y:
        b = y & -y
        if is_kernel(rows, x ^ b):
            return False
        y ^= b
    return True

def same_operator_class(s1: int, s2: int, n: int) -> bool:
    for x in range(1 << n):
        if (((s1 & x).bit_count() ^ (s2 & x).bit_count()) & 1) != 0:
            return False
    return True

def enumerate_matrices(n: int, m: int, max_mats: int):
    total = min(1 << (m * n), max_mats)
    for z in range(total):
        rows = []
        y = z
        for _ in range(m):
            rows.append(y & ((1 << n) - 1))
            y >>= n
        yield rows, z + 1, total

def search(nmax: int, kmax: int, mmax: int, max_mats: int):
    for n in range(1, nmax + 1):
        for m in range(1, min(mmax, n) + 1):
            for rows, idx, total in enumerate_matrices(n, m, max_mats):
                mins = {}
                for s in range(1, 1 << n):
                    if is_minimal_support(rows, s):
                        k = s.bit_count() - 1
                        if k <= kmax:
                            mins.setdefault(k, []).append(s)
                for k, vals in mins.items():
                    classes: list[list[int]] = []
                    for v in vals:
                        placed = False
                        for cls in classes:
                            if same_operator_class(v, cls[0], n):
                                cls.append(v)
                                placed = True
                                break
                        if not placed:
                            classes.append([v])
                    if len(classes) > 1:
                        print(
                            "NON-UNIQUE-MINIMAL",
                            f"n={n}",
                            f"m={m}",
                            f"k={k}",
                            f"mat={idx}/{total}",
                            f"minimal={len(vals)}",
                            f"classes={len(classes)}"
                        )
    print("DONE")

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--nmax", type=int, default=8)
    ap.add_argument("--kmax", type=int, default=7)
    ap.add_argument("--mmax", type=int, default=3)
    ap.add_argument("--max-mats", type=int, default=50000)
    args = ap.parse_args()
    search(args.nmax, args.kmax, args.mmax, args.max_mats)
