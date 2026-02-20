import argparse
import math
import numpy as np
from pysat.formula import CNF
from pysat.pb import PBEnc
from pysat.solvers import Solver

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

def search_sat(n: int, M: int, grid: int, scale: int, target: int, out_path: str):
    """
    SAT hook: search c_i in {-1,0,1}, sum c_i = 0, and Q_scaled <= target (negative target).
    We encode c_i using two booleans (pos_i, neg_i) with at-most-one.
    Q is approximated by integer matrix K = round(scale * Kf).
    Then Q = sum_{i,j} K_ij c_i c_j. With ternary c, Q is pseudo-boolean quadratic.
    This hook uses a conservative linear over-approx for quick falsification attempts:
      we only enforce sum c_i = 0 and "not all zero"; then we evaluate Q on found models.
    If a negative-Q model exists, random SAT solutions can hit it; otherwise won't.
    """
    thetas = np.array([2.0 * math.pi * i / grid for i in range(n)], dtype=float)
    Kf = kernel_matrix(thetas, M)
    K = np.rint(Kf * scale).astype(int)

    cnf = CNF()
    vpos = [i * 2 + 1 for i in range(n)]
    vneg = [i * 2 + 2 for i in range(n)]

    # at most one of pos/neg
    for i in range(n):
        cnf.append([-vpos[i], -vneg[i]])

    # sum c_i = 0 where c_i = pos - neg
    lits = []
    weights = []
    for i in range(n):
        lits += [vpos[i], vneg[i]]
        weights += [1, -1]
    cnf.extend(PBEnc.equals(lits=lits, weights=weights, bound=0, top_id=cnf.nv).clauses)

    # not all zero: at least one pos or neg true
    cnf.append([vpos[i] for i in range(n)] + [vneg[i] for i in range(n)])

    best = None
    with Solver(name="cadical", bootstrap_with=cnf) as s:
        if not s.solve():
            with open(out_path, "w", encoding="utf-8") as f:
                f.write("UNSAT under basic constraints (unexpected)\n")
            return

        # sample a handful of models by adding blocking clauses
        for _ in range(200):
            m = s.get_model()
            c = []
            for i in range(n):
                pi = (vpos[i] in m)
                ni = (vneg[i] in m)
                c.append(1 if pi else (-1 if ni else 0))
            cv = np.array(c, dtype=int)
            Q = int(cv @ K @ cv)
            if best is None or Q < best[0]:
                best = (Q, c)
            if Q <= target:
                with open(out_path, "w", encoding="utf-8") as f:
                    f.write(f"FOUND: Q_scaled={Q} <= target={target}\n")
                    f.write(f"n={n} M={M} grid={grid} scale={scale}\n")
                    f.write(f"c={c}\n")
                return
            # block this exact assignment on (pos,neg) vars
            block = []
            for v in range(1, cnf.nv + 1):
                if v in m:
                    block.append(-v)
                else:
                    block.append(v)
            s.add_clause(block)

    with open(out_path, "w", encoding="utf-8") as f:
        f.write("NO MODEL HIT NEGATIVE Q under sampling\n")
        f.write(f"best_Q_scaled={best[0] if best else None}\n")
        f.write(f"best_c={best[1] if best else None}\n")

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--n", type=int, default=12)
    ap.add_argument("--M", type=int, default=10)
    ap.add_argument("--grid", type=int, default=128)
    ap.add_argument("--scale", type=int, default=1000)
    ap.add_argument("--target", type=int, default=-1)
    ap.add_argument("--out", type=str, default="tools/counterexamples/out/cpd1_sat.txt")
    args = ap.parse_args()
    search_sat(args.n, args.M, args.grid, args.scale, args.target, args.out)

if __name__ == "__main__":
    main()
