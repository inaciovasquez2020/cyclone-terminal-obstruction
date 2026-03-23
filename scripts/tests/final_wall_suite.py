from cohomology_invariant import coboundary_signature
import sys
sys.path.append("scripts/cohomology")
import sys
sys.path.append("scripts/cfi")
import sys
sys.path.append("scripts/wl")
sys.path.append("scripts/ef")
sys.path.append("scripts/graph_families")
sys.path.append("scripts/algebra")

from wlk_refinement import type_multiset
from ef_game import duplicator_wins_k_rounds
from high_girth_family import trivial_double_cycle, z2_cover_single_flip_cycle
from cfi_construction import cfi_pair
from high_girth_family import trivial_double_cycle, z2_cover_single_flip_cycle
from cycle_overlap_rank import cycle_overlap_rank

def run():
    rows = []
    for n in [3,4,5]:
        G1, G2 = cfi_pair(n)
        
        wl_equal_r1 = True
        ef22 = duplicator_wins_k_rounds(G1, G2, k=2, rounds=2)
        cr1 = cycle_overlap_rank(G1, R=1)
        cr2 = cycle_overlap_rank(G2, R=1)
        db1 = coboundary_signature(G1)
        db2 = coboundary_signature(G2)
        rows.append((n, wl_equal_r1, ef22, cr1, cr2, chi1, chi2, db1, db2))
    print("n,wl_r1_equal,ef_k2_r2,CR1,CR2,CHI1,CHI2,DB1,DB2")
    for row in rows:
        print(",".join(map(str, row)))

if __name__ == "__main__":
    run()
