def base_graph(n):
    G = {i:set() for i in range(n)}
    for i in range(n):
        G[i].add((i+1)%n); G[(i+1)%n].add(i)
        G[i].add((i+2)%n); G[(i+2)%n].add(i)
        G[i].add((i+3)%n); G[(i+3)%n].add(i)
    return G

def cfi_gadget_lift(G, parity_flip=False):
    H = {}
    for v in G:
        for a in [0,1]:
            H[(v,a)] = set()

    for v in G:
        parity = (1 if parity_flip and v % 2 == 0 else 0)
        for u in G[v]:
            if v < u:
                for a in [0,1]:
                    b = a ^ parity
                    H[(v,a)].add((u,b))
                    H[(u,b)].add((v,a))

    lab = {v:i for i,v in enumerate(sorted(H))}
    return {lab[v]: {lab[u] for u in H[v]} for v in H}

def cfi_pair(n):
    B = base_graph(n)
    return cfi_gadget_lift(B, False), cfi_gadget_lift(B, True)
