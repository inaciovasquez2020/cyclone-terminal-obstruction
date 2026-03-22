from __future__ import annotations

def op_value(s, x):
    return ((s & x).bit_count() & 1)

def canonical(s, n):
    table = tuple(op_value(s, x) for x in range(1 << n))
    return table

def equivalent(s1, s2, n):
    return canonical(s1, n) == canonical(s2, n)
