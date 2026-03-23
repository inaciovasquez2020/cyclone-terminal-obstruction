def theta_graph(k=3):
    # two terminals connected by k internally disjoint paths of length 2
    # vertices: s=0, t=1, intermediates 2..(k+1)
    G = {i:set() for i in range(k+2)}
    s, t = 0, 1
    for i in range(2, k+2):
        G[s].add(i); G[i].add(s)
        G[i].add(t); G[t].add(i)
    return G
