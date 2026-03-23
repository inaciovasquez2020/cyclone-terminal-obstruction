import sys
sys.path.append("scripts/wl")
sys.path.append("scripts/ef")
sys.path.append("scripts/graph_families")
sys.path.append("scripts/algebra")

from wlk_refinement import type_multiset
from ef_game import duplicator_wins_k_rounds
from high_girth_family import trivial_double_cycle, z2_cover_single_flip_cycle
from cycle_overlap_rank import cycle_overlap_rank

def run():
    rows = []
    for n in [12, 16, 20]:
        G1 = trivial_double_cycle(n)
        G2 = z2_cover_single_flip_cycle(n)
        wl_equal_r1 = (type_multiset(G1, r=1, rounds=3) == type_multiset(G2, r=1, rounds=3))
        ef22 = duplicator_wins_k_rounds(G1, G2, k=2, rounds=2)
        cr1 = cycle_overlap_rank(G1, R=1)
        cr2 = cycle_overlap_rank(G2, R=1)
        rows.append((n, wl_equal_r1, ef22, cr1, cr2))
    print("n,wl_r1_equal,ef_k2_r2,CR1,CR2")
    for row in rows:
        print(",".join(map(str, row)))

if __name__ == "__main__":
    run()
