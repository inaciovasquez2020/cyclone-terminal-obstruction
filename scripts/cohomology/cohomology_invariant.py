from cycle_overlap_rank import fundamental_cycles

def edge_key(u,v):
    return (u,v) if u<=v else (v,u)

def induced_cochain(G, lift_map):
    E, _ = fundamental_cycles(G)
    idx = {edge_key(*e):i for i,e in enumerate(E)}
    cochain = [0]*len(E)
    for (u,v), val in lift_map.items():
        e = edge_key(u,v)
        if e in idx:
            cochain[idx[e]] = val
    return cochain

def cycle_pairing(G, cochain):
    _, cycles = fundamental_cycles(G)
    out = []
    for c in cycles:
        s = 0
        for i in range(len(c)):
            s ^= (c[i] & cochain[i])
        out.append(s)
    return tuple(out)

def cohomology_signature(G, lift_map):
    return cycle_pairing(G, induced_cochain(G, lift_map))
