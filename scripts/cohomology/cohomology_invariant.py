import sys
sys.path.append("scripts/algebra")
from cycle_overlap_rank import fundamental_cycles

def edge_key(u, v):
    return (u, v) if u <= v else (v, u)

def pairing_signature_from_edge_cochain(G, phi):
    E, cycles = fundamental_cycles(G)
    idx = {edge_key(*e): i for i, e in enumerate(E)}
    out = []
    for c in cycles:
        s = 0
        for e, j in idx.items():
            s ^= (c[j] & phi.get(e, 0))
        out.append(s)
    return tuple(out)

def h1_invariant(G, phi):
    return pairing_signature_from_edge_cochain(G, phi)
