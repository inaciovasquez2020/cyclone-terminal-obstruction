from cycle_overlap_rank import fundamental_cycles

def edge_key(u,v):
    return (u,v) if u<=v else (v,u)

def voltage_cochain(G, flip_edges):
    E, _ = fundamental_cycles(G)
    idx = {edge_key(*e):i for i,e in enumerate(E)}
    cochain = [0]*len(E)
    for e in flip_edges:
        if e in idx:
            cochain[idx[e]] = 1
    return cochain, idx

def cycle_pairing(G, cochain):
    E, cycles = fundamental_cycles(G)
    pairings = []
    for c in cycles:
        val = 0
        for i in range(len(c)):
            val ^= (c[i] & cochain[i])
        pairings.append(val)
    return pairings

def cohomology_signature(G, flip_edges):
    cochain, _ = voltage_cochain(G, flip_edges)
    return tuple(cycle_pairing(G, cochain))
