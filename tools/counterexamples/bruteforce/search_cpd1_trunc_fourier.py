import argparse
import itertools
import math
import numpy as np

def kernel_matrix(thetas: np.ndarray, M: int) -> np.ndarray:
    """
    Truncated Fourier surrogate for K_AKR = L + Π_1 on S^1:
      K_M(θ) = 1 + 2 * sum_{m=1..M} m^2 cos(m θ)
    For a finite set of points θ_i, form K_ij = K_M(θ_i-θ_j).
    """
    n = len(thetas)
    K = np.zeros((n, n), dtype=float)
    for i in range(n):
        for j in range(n):
            d = thetas[i] - thetas[j]
            s = 1.0
            for m in range(1, M + 1):
                s += 2.0 * (m * m) * math.cos(m * d)
            K[i, j] = s
    return K

def search_bruteforce(n: int, M: int, coeff_abs: int, grid: int, out_path: str):
    thetas = np.array([2.0 * math.pi * i / grid for i in range(n)], dtype=float)
    K = kernel_matrix(thetas, M)

    # Search small integer coefficient vectors c with sum(c)=0, looking for Q=c^T K c < 0.
    best = (float("inf"), None)
    found = None

    vals = list(range(-coeff_abs, coeff_abs + 1))
    for c in itertools.product(vals, repeat=n):
        if sum(c) != 0:
            continue
        if all(x == 0 for x in c):
            continue
        cv = np.array(c, dtype=float)
        Q = float(cv @ K @ cv)
        if Q < best[0]:
            best = (Q, c)
        if Q < -1e-9:
            found = (Q, c)
            break

    with open(out_path, "w", encoding="utf-8") as f:
        f.write(f"n={n} M={M} coeff_abs={coeff_abs} grid={grid}\n")
        f.write(f"best_Q={best[0]:.12e} best_c={best[1]}\n")
        if found:
            f.write(f"FOUND_NEGATIVE_Q={found[0]:.12e} c={found[1]}\n")
        else:
            f.write("NO_NEGATIVE_Q_FOUND\n")

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--n", type=int, default=6)
    ap.add_argument("--M", type=int, default=10)
    ap.add_argument("--coeff-abs", type=int, default=2)
    ap.add_argument("--grid", type=int, default=64)
    ap.add_argument("--out", type=str, default="tools/counterexamples/out/cpd1_bruteforce.txt")
    args = ap.parse_args()
    search_bruteforce(args.n, args.M, args.coeff_abs, args.grid, args.out)

if __name__ == "__main__":
    main()
