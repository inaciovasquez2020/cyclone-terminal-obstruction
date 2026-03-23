def base_3regular(n):
    G = {i:set() for i in range(n)}
    for i in range(n):
        G[i].add((i+1)%n); G[(i+1)%n].add(i)
        G[i].add((i+2)%n); G[(i+2)%n].add(i)
        G[i].add((i+3)%n); G[(i+3)%n].add(i)
    return G

def cfi_lift(G, flip=False):
    H = {}
    for v in G:
        for p in [0,1]:
            H[(v,p)] = set()
    for u in G:
        for v in G[u]:
            if u < v:
                parity = (u + v) % 2
                for p in [0,1]:
                    q = p ^ (parity if flip else 0)
                    H[(u,p)].add((v,q))
                    H[(v,q)].add((u,p))
    lab = {v:i for i,v in enumerate(sorted(H))}
    return {lab[v]: {lab[u] for u in H[v]} for v in H}

def cfi_pair(n):
    B = base_3regular(n)
    return cfi_lift(B, False), cfi_lift(B, True)
