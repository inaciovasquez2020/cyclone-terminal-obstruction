from __future__ import annotations
import argparse

def is_kernel(rows, x):
    for row in rows:
        if ((row & x).bit_count() & 1) != 0:
            return False
    return True

def is_circuit(rows, x):
    if x == 0 or not is_kernel(rows, x):
        return False
    y = x
    while y:
        b = y & -y
        if is_kernel(rows, x ^ b):
            return False
        y ^= b
    return True

def op_value(supp_mask, x):
    return ((supp_mask & x).bit_count() & 1)

def equivalent(s1, s2, n):
    for x in range(1 << n):
        if op_value(s1, x) != op_value(s2, x):
            return False
    return True

def search(nmax=8, mmax=3, kmax=7, max_mats=50000):
    for n in range(1, nmax+1):
        for m in range(1, min(mmax, n)+1):
            for z in range(min(1 << (m*n), max_mats)):
                rows = []
                y = z
                for _ in range(m):
                    rows.append(y & ((1 << n) - 1))
                    y >>= n
                circuits = {}
                for x in range(1, 1 << n):
                    if is_circuit(rows, x):
                        k = x.bit_count() - 1
                        if k <= kmax:
                            circuits.setdefault(k, []).append(x)
                for k, vals in circuits.items():
                    if len(vals) <= 1:
                        continue
                    classes = []
                    for v in vals:
                        placed = False
                        for cls in classes:
                            if equivalent(v, cls[0], n):
                                cls.append(v)
                                placed = True
                                break
                        if not placed:
                            classes.append([v])
                    if len(classes) > 1:
                        print("NON-UNIQUE-EQUIV", f"n={n}", f"k={k}", f"classes={len(classes)}")
    print("DONE")

if __name__ == "__main__":
    search()
