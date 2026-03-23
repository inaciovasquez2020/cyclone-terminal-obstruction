from wlk_refinement import type_multiset

def verify_wl(G1, G2, max_r=3):
    for r in range(1, max_r+1):
        if type_multiset(G1, r=r, rounds=5) != type_multiset(G2, r=r, rounds=5):
            return False
    return True
