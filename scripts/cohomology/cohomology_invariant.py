from cycle_overlap_rank import fundamental_cycles

def edge_key(u, v):
    return (u, v) if u <= v else (v, u)

def zero_cochain_from_vertex_parity(G):
    return {v: (v % 2) for v in G}

def coboundary_dpsi(G, psi):
    E, _ = fundamental_cycles(G)
    dpsi = {}
    for u, v in E:
        dpsi[edge_key(u, v)] = psi[u] ^ psi[v]
    return dpsi

def cycle_pairing_from_1cochain(G, one_cochain):
    E, cycles = fundamental_cycles(G)
    idx = {edge_key(*e): i for i, e in enumerate(E)}
    out = []
    for c in cycles:
        s = 0
        for e, j in idx.items():
            s ^= (c[j] & one_cochain.get(e, 0))
        out.append(s)
    return tuple(out)

def coboundary_signature(G):
    psi = zero_cochain_from_vertex_parity(G)
    dpsi = coboundary_dpsi(G, psi)
    return cycle_pairing_from_1cochain(G, dpsi)
