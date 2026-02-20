from __future__ import annotations
import json, random, datetime
from dataclasses import dataclass
from typing import List, Tuple

def gf2_rank(mat: List[List[int]]) -> int:
    if not mat:
        return 0
    A = [row[:] for row in mat]
    m, n = len(A), len(A[0])
    r = 0
    c = 0
    while r < m and c < n:
        piv = None
        for i in range(r, m):
            if A[i][c] & 1:
                piv = i
                break
        if piv is None:
            c += 1
            continue
        A[r], A[piv] = A[piv], A[r]
        for i in range(m):
            if i != r and (A[i][c] & 1):
                rowi = A[i]
                rowr = A[r]
                for j in range(c, n):
                    rowi[j] ^= rowr[j]
        r += 1
        c += 1
    return r

def build_adj(n: int, edges: List[Tuple[int,int]]) -> List[List[int]]:
    adj = [[] for _ in range(n)]
    for a,b in edges:
        if a == b:
            continue
        if b not in adj[a]:
            adj[a].append(b)
        if a not in adj[b]:
            adj[b].append(a)
    return adj

def bfs_ball(adj: List[List[int]], center: int, R: int) -> set[int]:
    seen = {center}
    frontier = {center}
    for _ in range(R):
        nxt = set()
        for u in frontier:
            for v in adj[u]:
                if v not in seen:
                    seen.add(v)
                    nxt.add(v)
        frontier = nxt
        if not frontier:
            break
    return seen

def spanning_tree_parents(adj: List[List[int]], root: int=0):
    n = len(adj)
    parent = [-1]*n
    order = [root]
    parent[root] = root
    q = [root]
    for u in q:
        for v in adj[u]:
            if parent[v] == -1:
                parent[v] = u
                q.append(v)
                order.append(v)
    return parent, order

def edge_index(n: int, edges: List[Tuple[int,int]]):
    m = {}
    for i,(a,b) in enumerate(edges):
        if a>b: a,b=b,a
        m[(a,b)] = i
    return m

def cycle_basis_gf2(n: int, edges: List[Tuple[int,int]]) -> List[List[int]]:
    adj = build_adj(n, edges)
    parent, order = spanning_tree_parents(adj, 0)
    idx = edge_index(n, edges)
    tree_edges = set()
    for v in range(n):
        if v == 0 or parent[v] == v:
            continue
        a,b = v,parent[v]
        if a>b: a,b=b,a
        tree_edges.add((a,b))
    basis = []
    for (a0,b0) in edges:
        a,b = a0,b0
        if a>b: a,b=b,a
        if (a,b) in tree_edges:
            continue
        path_edges = []
        x = a0
        y = b0
        seenx = set()
        while x != parent[x]:
            seenx.add(x)
            px = parent[x]
            path_edges.append((x,px))
            x = px
        seenx.add(x)
        path2 = []
        while y not in seenx:
            py = parent[y]
            path2.append((y,py))
            y = py
        lca = y
        vec = [0]*len(edges)
        def add_edge(u,v):
            aa,bb=u,v
            if aa>bb: aa,bb=bb,aa
            if (aa,bb) not in idx:
                return
            vec[idx[(aa,bb)]] ^= 1
        for u,v in path_edges:
            add_edge(u,v)
        for u,v in path2:
            add_edge(u,v)
        add_edge(a0,b0)
        if any(vec):
            basis.append(vec)
    return basis

def restrict_vec_to_ball(n: int, edges: List[Tuple[int,int]], vec: List[int], ball: set[int]) -> List[int]:
    out = [0]*len(edges)
    for i,(a,b) in enumerate(edges):
        if vec[i] and (a in ball or b in ball):
            out[i] = 1
    return out

def corank_R(n: int, edges: List[Tuple[int,int]], basis: List[List[int]], R: int) -> int:
    adj = build_adj(n, edges)
    best = 0
    for v in range(n):
        ball = bfs_ball(adj, v, R)
        mats = [restrict_vec_to_ball(n, edges, c, ball) for c in basis]
        mats = [row for row in mats if any(row)]
        best = max(best, gf2_rank(mats))
    return best

def overlap_matrix_R(n: int, edges: List[Tuple[int,int]], basis: List[List[int]], R: int) -> List[List[int]]:
    adj = build_adj(n, edges)
    balls = [bfs_ball(adj, v, R) for v in range(n)]
    def overlaps(i,j) -> int:
        ci = basis[i]
        cj = basis[j]
        for v in range(n):
            ball = balls[v]
            for e,(a,b) in enumerate(edges):
                if ci[e] and cj[e] and (a in ball or b in ball):
                    return 1
        return 0
    m = len(basis)
    M = [[0]*m for _ in range(m)]
    for i in range(m):
        for j in range(m):
            M[i][j] = overlaps(i,j)
    return M

def random_delta_bounded_graph(n: int, Delta: int, seed: int) -> List[Tuple[int,int]]:
    rng = random.Random(seed)
    edges = set()
    deg = [0]*n
    trials = 0
    while trials < 200000:
        trials += 1
        a = rng.randrange(n)
        b = rng.randrange(n)
        if a == b:
            continue
        if deg[a] >= Delta or deg[b] >= Delta:
            continue
        x,y = (a,b) if a<b else (b,a)
        if (x,y) in edges:
            continue
        edges.add((x,y))
        deg[a] += 1
        deg[b] += 1
        if sum(deg) >= n*min(Delta, n-1):
            break
    return list(edges)

def wl1_colors(n: int, edges: List[Tuple[int,int]], rounds: int) -> List[int]:
    adj = build_adj(n, edges)
    colors = [0]*n
    for _ in range(rounds):
        sigs = []
        for v in range(n):
            neigh = sorted(colors[u] for u in adj[v])
            sigs.append((colors[v], tuple(neigh)))
        mp = {}
        nxt = []
        for s in sigs:
            if s not in mp:
                mp[s] = len(mp)
            nxt.append(mp[s])
        colors = nxt
    return colors

def certify(seed: int, n: int, Delta: int, k: int, r: int):
    edges = random_delta_bounded_graph(n, Delta, seed)
    basis = cycle_basis_gf2(n, edges)
    Rstar = r
    M = overlap_matrix_R(n, edges, basis, Rstar)
    ovr = gf2_rank(M)
    cor = corank_R(n, edges, basis, Rstar)
    proxy = wl1_colors(n, edges, rounds=max(1, r))
    homogeneous_proxy = (len(set(proxy)) == 1)
    cert = {
        "meta": {
            "id": f"CYCLONE_CAND_{n}_{Delta}_{k}_{r}_{seed}",
            "created_utc": datetime.datetime.utcnow().isoformat() + "Z",
            "tool_version": "tools/cyclone/overlap_rank.py:v1"
        },
        "params": {
            "Delta": Delta,
            "k": k,
            "r": r,
            "Rstar": Rstar,
            "equivalence_proxy": "WL1_homogeneity_on_r_rounds"
        },
        "graph": {
            "n": n,
            "edges": [[a,b] for a,b in edges]
        },
        "computed": {
            "cycle_rank": len(basis),
            "ovrank_Rstar": ovr,
            "corank_Rstar": cor,
            "overlap_matrix_shape": [len(M), len(M[0]) if M else 0]
        },
        "claims": [
            "Computed overlap matrix rank ovrank_Rstar over F2",
            "Computed corank_Rstar as max local restricted-cycle rank over F2",
            "WL1 proxy homogeneity flag recorded"
        ]
    }
    cert["computed"]["wl1_homogeneous_proxy"] = bool(homogeneous_proxy)
    return cert

def main():
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--seed", type=int, required=True)
    ap.add_argument("--n", type=int, required=True)
    ap.add_argument("--Delta", type=int, required=True)
    ap.add_argument("--k", type=int, required=True)
    ap.add_argument("--r", type=int, required=True)
    ap.add_argument("--out", type=str, required=True)
    args = ap.parse_args()
    cert = certify(args.seed, args.n, args.Delta, args.k, args.r)
    with open(args.out, "w") as f:
        json.dump(cert, f, indent=2, sort_keys=True)

if __name__ == "__main__":
    main()
