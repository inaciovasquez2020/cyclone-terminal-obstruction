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

def alternating_even_parity_rhs(G, flip=False):
    V = sorted(G)
    b = {v: 0 for v in V}
    if flip:
        for i, v in enumerate(V[:-1]):
            b[v] = i & 1
        s = 0
        for v in V[:-1]:
            s ^= b[v]
        b[V[-1]] = s
    return b

def lift_from_edge_cochain(G, phi):
    H = {}
    lifted_phi = {}
    for v in G:
        for s in (0, 1):
            H[(v, s)] = set()
    for u in G:
        for v in G[u]:
            if u < v:
                a = phi.get(edge_key(u, v), 0) & 1
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
                bu, su = u
                bv, sv = v
                lifted_phi[edge_key(lab[u], lab[v])] = su ^ sv
    return K, lifted_phi

def cfi_data(n, solve_vertex_parity_cocycle):
    B = base_graph(n)
    b0 = alternating_even_parity_rhs(B, flip=False)
    b1 = alternating_even_parity_rhs(B, flip=True)
    phi0 = solve_vertex_parity_cocycle(B, b0)
    phi1 = solve_vertex_parity_cocycle(B, b1)
    G0, phiG0 = lift_from_edge_cochain(B, phi0)
    G1, phiG1 = lift_from_edge_cochain(B, phi1)
    return B, G0, G1, b0, b1, phi0, phi1, phiG0, phiG1
