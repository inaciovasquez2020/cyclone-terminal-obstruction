def cycle_graph(n):
    G = {i:set() for i in range(n)}
    for i in range(n):
        j = (i + 1) % n
        G[i].add(j)
        G[j].add(i)
    return G

def disjoint_union(G, H):
    n = len(G)
    K = {v:set(nei) for v, nei in G.items()}
    for v in H:
        K[v + n] = {u + n for u in H[v]}
    return K

def z2_cover_single_flip_cycle(n):
    G = { (i,s): set() for i in range(n) for s in (0,1) }
    for i in range(n):
        j = (i + 1) % n
        flip = 1 if i == 0 else 0
        for s in (0,1):
            t = s ^ flip
            G[(i,s)].add((j,t))
            G[(j,t)].add((i,s))
    H = {}
    lab = {v:i for i,v in enumerate(sorted(G))}
    for v in G:
        H[lab[v]] = {lab[u] for u in G[v]}
    return H

def trivial_double_cycle(n):
    return disjoint_union(cycle_graph(n), cycle_graph(n))
