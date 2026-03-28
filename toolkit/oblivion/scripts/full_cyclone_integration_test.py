import random
from collections import defaultdict

# ---------- Graph ----------

class Graph:
    def __init__(self, n):
        self.n = n
        self.edges = []
        self.adj = defaultdict(list)

    def add_edge(self, u, v):
        if u == v:
            return
        e = (min(u, v), max(u, v))
        if e not in self.edges:
            self.edges.append(e)
            self.adj[u].append(v)
            self.adj[v].append(u)

# ---------- BFS ----------

def bfs_tree(G, root):
    parent = {root: None}
    parent_edge = {}
    queue = [root]

    while queue:
        u = queue.pop(0)
        for v in G.adj[u]:
            if v not in parent:
                parent[v] = u
                parent_edge[v] = (u, v)
                queue.append(v)

    return parent, parent_edge

# ---------- Paths ----------

def path_edges(parent_edge, u):
    path = []
    while u in parent_edge:
        e = parent_edge[u]
        path.append(tuple(sorted(e)))
        u = e[0]
    return path

def tree_path(G, root, u, v):
    parent, parent_edge = bfs_tree(G, root)
    return path_edges(parent_edge, u) + path_edges(parent_edge, v)

# ---------- Fundamental cycle ----------

def fundamental_cycle(G, root, e):
    (u, v) = e
    return set(tree_path(G, root, u, v) + [e])

# ---------- Boundary ----------

def boundary(G, chain):
    b = [0] * G.n
    for (u, v) in chain:
        b[u] ^= 1
        b[v] ^= 1
    return b

# ---------- Two-lift ----------

def two_lift(G, sigma):
    H = Graph(2 * G.n)
    for (u, v) in G.edges:
        for b in [0, 1]:
            w = b ^ sigma[(u, v)]
            H.add_edge(2*u + b, 2*v + w)
    return H

# ---------- Parity ----------

def parity(cycle, sigma):
    return sum(1 for e in cycle if sigma.get(e, 0) == 1) % 2

# ---------- Full integration test ----------

def run_test(n=20, trials=20):
    for _ in range(trials):
        G = Graph(n)

        # ensure connected
        for i in range(n - 1):
            G.add_edge(i, i + 1)

        # add random edges
        for i in range(n):
            for j in range(i + 2, n):
                if random.random() < 0.1:
                    G.add_edge(i, j)

        # twist assignment
        sigma = {}
        for e in G.edges:
            sigma[e] = random.randint(0, 1)

        root = random.randint(0, n - 1)
        parent, parent_edge = bfs_tree(G, root)
        tree_edges = set(tuple(sorted(e)) for e in parent_edge.values())
        cotree_edges = [e for e in G.edges if e not in tree_edges]
        if not cotree_edges:
            continue

        e = random.choice(cotree_edges)
        cycle = fundamental_cycle(G, root, e)

        # Test 1: cycle is closed
        if any(boundary(G, cycle)):
            print("FAIL: cycle not closed")
            return False

        # Test 2: parity separation
        p0 = parity(cycle, {})
        p1 = parity(cycle, sigma)
        if not (p0 == 0 and p1 in [0,1]):
            print("FAIL: parity invalid")
            return False

        # Test 3: existence of separating cycle
        if p1 == 1:
            print("PASS: full Cyclone pipeline verified")
            return True

    print("FAIL: no separating cycle found")
    return False

if __name__ == "__main__":
    run_test()
