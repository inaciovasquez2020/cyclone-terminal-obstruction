import sys
sys.path.append("scripts/algebra")
from cycle_overlap_rank import fundamental_cycles

def edge_key(u, v):
    return (u, v) if u <= v else (v, u)

def gf2_solve(A, b):
    A = [row[:] for row in A]
    b = b[:]
    m = len(A)
    n = len(A[0]) if m else 0
    r = 0
    pivots = []
    for c in range(n):
        piv = None
        for i in range(r, m):
            if A[i][c] & 1:
                piv = i
                break
        if piv is None:
            continue
        A[r], A[piv] = A[piv], A[r]
        b[r], b[piv] = b[piv], b[r]
        for i in range(m):
            if i != r and (A[i][c] & 1):
                A[i] = [(x ^ y) for x, y in zip(A[i], A[r])]
                b[i] ^= b[r]
        pivots.append(c)
        r += 1
        if r == m:
            break
    for i in range(r, m):
        if b[i] & 1:
            return None
    x = [0] * n
    for i, c in enumerate(pivots):
        x[c] = b[i] & 1
    return x

def graph_edges(G):
    E = []
    seen = set()
    for u in G:
        for v in G[u]:
            e = edge_key(u, v)
            if e not in seen:
                seen.add(e)
                E.append(e)
    return E

def incidence_matrix_vertices_edges(G):
    V = sorted(G)
    E = graph_edges(G)
    vidx = {v: i for i, v in enumerate(V)}
    A = [[0 for _ in range(len(E))] for _ in range(len(V))]
    for j, (u, v) in enumerate(E):
        A[vidx[u]][j] ^= 1
        A[vidx[v]][j] ^= 1
    return V, E, A

def coboundary_matrix_vertices_edges(G):
    V = sorted(G)
    E = graph_edges(G)
    vidx = {v: i for i, v in enumerate(V)}
    B = [[0 for _ in range(len(V))] for _ in range(len(E))]
    for i, (u, v) in enumerate(E):
        B[i][vidx[u]] ^= 1
        B[i][vidx[v]] ^= 1
    return V, E, B

def solve_vertex_parity_cocycle(G, b_map):
    V, E, A = incidence_matrix_vertices_edges(G)
    b = [b_map.get(v, 0) & 1 for v in V]
    x = gf2_solve(A, b)
    if x is None:
        return None
    phi = {}
    for j, e in enumerate(E):
        phi[e] = x[j] & 1
    return phi

def is_exact_1cochain(G, phi):
    V, E, B = coboundary_matrix_vertices_edges(G)
    rhs = [phi.get(e, 0) & 1 for e in E]
    sol = gf2_solve(B, rhs)
    return sol is not None

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

def nonexact_h1_signature(G, b_map):
    phi = solve_vertex_parity_cocycle(G, b_map)
    if phi is None:
        return None, None, None
    exact = is_exact_1cochain(G, phi)
    sig = pairing_signature_from_edge_cochain(G, phi)
    return phi, exact, sig
