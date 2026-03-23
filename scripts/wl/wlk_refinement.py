from collections import defaultdict, Counter

def neighbors(G, v):
    return G.get(v, set())

def wl1_colors(G, rounds=3):
    color = {v: 0 for v in G}
    history = [dict(color)]
    for _ in range(rounds):
        sigs = {}
        for v in G:
            sigs[v] = (color[v], tuple(sorted(color[u] for u in neighbors(G, v))))
        palette = {s:i for i,s in enumerate(sorted(set(sigs.values())))}
        color = {v: palette[sigs[v]] for v in G}
        history.append(dict(color))
    return color, history

def rooted_ball(G, root, r):
    dist = {root: 0}
    q = [root]
    for x in q:
        if dist[x] == r:
            continue
        for y in neighbors(G, x):
            if y not in dist:
                dist[y] = dist[x] + 1
                q.append(y)
    H = {v:set() for v in dist}
    for v in dist:
        for u in neighbors(G, v):
            if u in dist:
                H[v].add(u)
    return H, dist

def rooted_wl_signature(G, root, r=2, rounds=3):
    H, dist = rooted_ball(G, root, r)
    color = {v: (dist[v], int(v == root)) for v in H}
    for _ in range(rounds):
        sigs = {}
        for v in H:
            sigs[v] = (color[v], tuple(sorted(color[u] for u in H[v])))
        palette = {s:i for i,s in enumerate(sorted(set(sigs.values())))}
        color = {v: palette[sigs[v]] for v in H}
    data = sorted((dist[v], color[v], sorted(color[u] for u in H[v])) for v in H)
    return tuple(data)

def type_multiset(G, r=2, rounds=3):
    return Counter(rooted_wl_signature(G, v, r=r, rounds=rounds) for v in G)
