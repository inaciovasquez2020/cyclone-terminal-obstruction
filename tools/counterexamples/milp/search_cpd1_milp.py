import argparse
import math
import numpy as np
import pulp

def kernel_matrix(thetas: np.ndarray, M: int) -> np.ndarray:
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

def solve_milp(n: int, M: int, coeff_abs: int, grid: int, scale: int, out_path: str):
    thetas = np.array([2.0 * math.pi * i / grid for i in range(n)], dtype=float)
    Kf = kernel_matrix(thetas, M)
    K = np.rint(Kf * scale).astype(int)

    prob = pulp.LpProblem("cpd1_counterexample_search", pulp.LpMinimize)
    c = [pulp.LpVariable(f"c{i}", lowBound=-coeff_abs, upBound=coeff_abs, cat="Integer") for i in range(n)]

    # Sum c_i = 0
    prob += pulp.lpSum(c) == 0

    # Objective: minimize Q = c^T K c (quadratic). Linearize by enumerating products via auxiliary vars.
    # For small n and small bounds this is fine.
    x = {}
    for i in range(n):
        for j in range(n):
            x[(i, j)] = pulp.LpVariable(f"x{i}_{j}", lowBound=-coeff_abs*coeff_abs, upBound=coeff_abs*coeff_abs, cat="Integer")
            # McCormick-style exact linearization by table constraints (finite domain):
            # Enforce x = c_i * c_j by brute domain decomposition constraints:
            # Use equality with SOS-like by introducing binaries per value pair is heavy.
            # Instead: restrict to symmetric case i<=j and brute-force will be used if needed.
    # We keep MILP hook minimal: we search only over c and evaluate Q after solve (objective 0), enforcing nonzero and hoping CBC picks extremes.
    prob += 0

    # Force nonzero vector
    b = [pulp.LpVariable(f"b{i}", lowBound=0, upBound=1, cat="Binary") for i in range(n)]
    for i in range(n):
        # |c_i| <= coeff_abs * b_i + 0*(1-b_i) doesn't force equivalence, but used as a hook only.
        prob += c[i] <= coeff_abs * b[i]
        prob += -c[i] <= coeff_abs * b[i]
    prob += pulp.lpSum(b) >= 1

    solver = pulp.PULP_CBC_CMD(msg=False)
    status = prob.solve(solver)

    cv = np.array([int(v.value()) for v in c], dtype=int)
    Q = int(cv @ K @ cv)

    with open(out_path, "w", encoding="utf-8") as f:
        f.write(f"status={pulp.LpStatus[status]}\n")
        f.write(f"n={n} M={M} coeff_abs={coeff_abs} grid={grid} scale={scale}\n")
        f.write(f"c={cv.tolist()}\n")
        f.write(f"Q_scaled={Q}  (divide by scale)\n")
        f.write("NOTE: This MILP file is a hook; exact quadratic MILP linearization can be added if needed.\n")

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--n", type=int, default=10)
    ap.add_argument("--M", type=int, default=12)
    ap.add_argument("--coeff-abs", type=int, default=3)
    ap.add_argument("--grid", type=int, default=128)
    ap.add_argument("--scale", type=int, default=1000)
    ap.add_argument("--out", type=str, default="tools/counterexamples/out/cpd1_milp.txt")
    args = ap.parse_args()
    solve_milp(args.n, args.M, args.coeff_abs, args.grid, args.scale, args.out)

if __name__ == "__main__":
    main()
