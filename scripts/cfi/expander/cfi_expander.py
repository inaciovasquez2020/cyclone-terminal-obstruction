def edge_key(u,v):
    return (u,v) if u<=v else (v,u)

def cfi_expander_lift(G, b):
    H = {}
    for v in G:
        for s in (0,1):
            H[(v,s)] = set()
    for v in G:
        for u in G[v]:
            if v<u:
                a = b[v]^b[u]
                for s in (0,1):
                    H[(v,s)].add((u,s^a))
                    H[(u,s^a)].add((v,s))
    lab = {v:i for i,v in enumerate(sorted(H))}
    return {lab[v]:{lab[u] for u in H[v]} for v in H}
