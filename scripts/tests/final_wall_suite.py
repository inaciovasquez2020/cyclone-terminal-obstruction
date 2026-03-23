import sys
sys.path.append("scripts/wl")
sys.path.append("scripts/ef")
sys.path.append("scripts/algebra")
sys.path.append("scripts/cfi")
sys.path.append("scripts/cohomology")

from wlk_refinement import type_multiset
from ef_game import duplicator_wins_k_rounds
from cycle_overlap_rank import cycle_overlap_rank
from cohomology_invariant import nonexact_h1_signature, solve_vertex_parity_cocycle
from cfi_construction import cfi_data

def run():
    rows = []
    for n in [8, 10, 12]:
        B, G0, G1, b0, b1, phi0, phi1, phiG0, phiG1 = cfi_data(n, solve_vertex_parity_cocycle)
        wl_equal_r1 = (type_multiset(G0, r=1, rounds=5) == type_multiset(G1, r=1, rounds=5))
        ef22 = duplicator_wins_k_rounds(G0, G1, k=2, rounds=2)
        cr0 = cycle_overlap_rank(G0, R=1)
        cr1 = cycle_overlap_rank(G1, R=1)
        _, exact0, sig0 = nonexact_h1_signature(B, b0)
        _, exact1, sig1 = nonexact_h1_signature(B, b1)
        rows.append((n, wl_equal_r1, ef22, cr0, cr1, exact0, exact1, sig0, sig1))

    print("n,wl_r1_equal,ef_k2_r2,CR0,CR1,EXACT0,EXACT1,H1SIG0,H1SIG1")
    for row in rows:
        print(",".join(map(str, row)))

if __name__ == "__main__":
    run()
