import sys
sys.path.append("scripts/wl")
sys.path.append("scripts/ef")
sys.path.append("scripts/algebra")
sys.path.append("scripts/cfi")
sys.path.append("scripts/cohomology")

from wlk_refinement import type_multiset
from ef_game import duplicator_wins_k_rounds
from cycle_overlap_rank import cycle_overlap_rank
from cfi_construction import cfi_data
from cohomology_invariant import h1_invariant

def run():
    rows = []
    for n in [8, 10, 12]:
        G1, G2, phi1, phi2 = cfi_data(n)
        wl_equal_r1 = (type_multiset(G1, r=1, rounds=5) == type_multiset(G2, r=1, rounds=5))
        ef22 = duplicator_wins_k_rounds(G1, G2, k=2, rounds=2)
        cr1 = cycle_overlap_rank(G1, R=1)
        cr2 = cycle_overlap_rank(G2, R=1)
        h1_1 = h1_invariant(G1, phi1)
        h1_2 = h1_invariant(G2, phi2)
        rows.append((n, wl_equal_r1, ef22, cr1, cr2, h1_1, h1_2))

    print("n,wl_r1_equal,ef_k2_r2,CR1,CR2,H1SIG1,H1SIG2")
    for row in rows:
        print(",".join(map(str, row)))

if __name__ == "__main__":
    run()
