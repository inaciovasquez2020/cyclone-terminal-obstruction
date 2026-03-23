def ladder_graph(n):
    G = {}
    for i in range(n):
        G[i] = set()
        G[i+n] = set()
    for i in range(n):
        G[i].add((i+1)%n)
        G[(i+1)%n].add(i)
        G[i+n].add((i+1)%n + n)
        G[(i+1)%n + n].add(i+n)
        G[i].add(i+n)
        G[i+n].add(i)
    return G
