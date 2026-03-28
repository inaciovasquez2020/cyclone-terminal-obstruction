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

# ---------- BFS tree ----------

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

# ---------- Path ----------

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

# ---------- Cycle ----------

def fundamental_cycle(G, root, e):
    (u, v) = e
    return set(tree_path(G, root, u, v) + [e])

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

# ---------- Test ----------

def run_test(n=20, trials=10):
    for _ in range(trials):
        G = Graph(n)

        # base tree
        for i in range(n - 1):
            G.add_edge(i, i + 1)

        # add random edges
        for i in range(n):
            for j in range(i + 2, n):
                if random.random() < 0.1:
                    G.add_edge(i, j)

        # define twist
        sigma = {}
        twist_edges = set()
        for e in G.edges:
            val = random.randint(0, 1)
            sigma[e] = val
            if val == 1:
                twist_edges.add(e)

        # choose cotree edge
        root = random.randint(0, n - 1)
        parent, parent_edge = bfs_tree(G, root)
        tree_edges = set(tuple(sorted(e)) for e in parent_edge.values())
        cotree_edges = [e for e in G.edges if e not in tree_edges]
        if not cotree_edges:
            continue

        e = random.choice(cotree_edges)
        cycle = fundamental_cycle(G, root, e)

        # trivial vs twisted
        p0 = parity(cycle, {})           # no twist
        p1 = parity(cycle, sigma)        # twisted

        if p0 == 0 and p1 == 1:
            print("PASS: parity separates lifts")
            return True

    print("FAIL: no parity separation detected")
    return False

if __name__ == "__main__":
    run_test()
