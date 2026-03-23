def edge_key(u, v):
    return (u, v) if u <= v else (v, u)

def base_graph(n):
    G = {i: set() for i in range(n)}
    for i in range(n):
        for d in (1, 2):
            j = (i + d) % n
            G[i].add(j)
            G[j].add(i)
    return G

def cycle_voltage(G, flip=False):
    phi = {}
    for u in G:
        for v in G[u]:
            if u < v:
                e = edge_key(u, v)
                phi[e] = 0
    if flip:
        n = len(G)
        for i in range(n):
            e = edge_key(i, (i + 1) % n)
            if e in phi:
                phi[e] = 1
    return phi

def lift_from_voltage(G, phi):
    H = {}
    for v in G:
        for s in (0, 1):
            H[(v, s)] = set()

    lifted_edge_phi = {}
    for u in G:
        for v in G[u]:
            if u < v:
                e = edge_key(u, v)
                a = phi.get(e, 0)
                for s in (0, 1):
                    x = (u, s)
                    y = (v, s ^ a)
                    H[x].add(y)
                    H[y].add(x)

    lab = {v: i for i, v in enumerate(sorted(H))}
    K = {}
    for v in H:
        K[lab[v]] = {lab[u] for u in H[v]}

    for u in H:
        for v in H[u]:
            if lab[u] < lab[v]:
                bu, _ = u
                bv, _ = v
                e = edge_key(bu, bv)
                lifted_edge_phi[edge_key(lab[u], lab[v])] = phi.get(e, 0)

    return K, lifted_edge_phi

def cfi_data(n):
    B = base_graph(n)
    phi0 = cycle_voltage(B, flip=False)
    phi1 = cycle_voltage(B, flip=True)
    G1, phiG1 = lift_from_voltage(B, phi0)
    G2, phiG2 = lift_from_voltage(B, phi1)
    return G1, G2, phiG1, phiG2
