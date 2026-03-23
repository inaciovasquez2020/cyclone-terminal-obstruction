from collections import deque
from gf2_linear_algebra import gf2_rank

def edge_key(u, v):
    return (u, v) if u <= v else (v, u)

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

def connected_components(G):
    seen = set()
    comps = []
    for v in G:
        if v in seen:
            continue
        comp = []
        q = [v]
        seen.add(v)
        for x in q:
            comp.append(x)
            for y in G[x]:
                if y not in seen:
                    seen.add(y)
                    q.append(y)
        comps.append(comp)
    return comps

def spanning_forest(G):
    parent = {}
    tree_edges = set()
    for comp in connected_components(G):
        root = comp[0]
        parent[root] = None
        q = [root]
        for x in q:
            for y in G[x]:
                if y not in parent:
                    parent[y] = x
                    tree_edges.add(edge_key(x, y))
                    q.append(y)
    return parent, tree_edges

def tree_path(parent, u, v):
    au = set()
    x = u
    while x is not None:
        au.add(x)
        x = parent[x]
    x = v
    pv = []
    while x not in au:
        pv.append(x)
        x = parent[x]
    lca = x
    pu = []
    x = u
    while x != lca:
        pu.append(x)
        x = parent[x]
    pu.append(lca)
    path = pu + list(reversed(pv))
    return path

def fundamental_cycles(G):
    E = graph_edges(G)
    edge_index = {e:i for i,e in enumerate(E)}
    parent, tree_edges = spanning_forest(G)
    cotree = [e for e in E if e not in tree_edges]
    cycles = []
    for u, v in cotree:
        path = tree_path(parent, u, v)
        vec = [0] * len(E)
        vec[edge_index[edge_key(u, v)]] = 1
        for a, b in zip(path, path[1:]):
            vec[edge_index[edge_key(a, b)]] ^= 1
        cycles.append(vec)
    return E, cycles

def restrict_edges_to_radius_union(G, R):
    E = graph_edges(G)
    marked = set()
    for c in G:
        dist = {c: 0}
        q = [c]
        for x in q:
            if dist[x] == R:
                continue
            for y in G[x]:
                if y not in dist:
                    dist[y] = dist[x] + 1
                    q.append(y)
        verts = set(dist)
        for u in verts:
            for v in G[u]:
                if v in verts:
                    marked.add(edge_key(u, v))
    return {e for e in E if e in marked}

def cycle_overlap_matrix(G, R):
    E, cycles = fundamental_cycles(G)
    use = restrict_edges_to_radius_union(G, R)
    idx = {e:i for i,e in enumerate(E)}
    M = []
    for a in cycles:
        row = []
        for b in cycles:
            s = 0
            for e in use:
                j = idx[e]
                s ^= (a[j] & b[j])
            row.append(s)
        M.append(row)
    return M

def cycle_overlap_rank(G, R):
    return gf2_rank(cycle_overlap_matrix(G, R))
