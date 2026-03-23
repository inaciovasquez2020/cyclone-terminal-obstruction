import random
def random_3regular(n, seed=0):
    random.seed(seed)
    stubs = []
    for v in range(n):
        stubs += [v, v, v]
    while True:
        random.shuffle(stubs)
        G = {i:set() for i in range(n)}
        ok = True
        for i in range(0, len(stubs), 2):
            u, v = stubs[i], stubs[i+1]
            if u == v or v in G[u]:
                ok = False
                break
            G[u].add(v); G[v].add(u)
        if ok:
            return G
