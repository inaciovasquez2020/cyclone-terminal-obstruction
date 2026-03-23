def base_cycle(n):
    G = {i:set() for i in range(n)}
    for i in range(n):
        j = (i+1)%n
        G[i].add(j); G[j].add(i)
    return G

def cfi_lift(G, flip=False):
    H = {}
    for v in G:
        for p in [0,1]:
            H[(v,p)] = set()
    for u in G:
        for v in G[u]:
            if u < v:
                if flip and (u+v)%2==0:
                    for p in [0,1]:
                        H[(u,p)].add((v,p^1))
                        H[(v,p^1)].add((u,p))
                else:
                    for p in [0,1]:
                        H[(u,p)].add((v,p))
                        H[(v,p)].add((u,p))
    lab = {v:i for i,v in enumerate(sorted(H))}
    K = {}
    for v in H:
        K[lab[v]] = {lab[u] for u in H[v]}
    return K

def cfi_pair(n):
    B = base_cycle(n)
    return cfi_lift(B, False), cfi_lift(B, True)
