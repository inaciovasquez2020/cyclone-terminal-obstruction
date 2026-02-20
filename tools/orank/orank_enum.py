import itertools
import numpy as np

def cycle_vectors(edges, cycles):
    m = len(edges)
    vecs = []
    for C in cycles:
        v = np.zeros(m, dtype=int)
        for e in C:
            v[e] ^= 1
        vecs.append(v)
    return np.array(vecs)

def orank(mat):
    return np.linalg.matrix_rank(mat % 2)

def main():
    # toy example: K_5 edges
    edges = list(range(10))
    cycles = [
        [0,1,2,3],
        [3,4,5,6],
        [1,6,7,8]
    ]
    M = cycle_vectors(edges, cycles)
    print("orank =", orank(M))

if __name__ == "__main__":
    main()
