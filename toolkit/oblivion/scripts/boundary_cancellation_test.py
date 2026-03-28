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
        self.edges.append((u, v))
        self.adj[u].append(v)
        self.adj[v].append(u)

# ---------- BFS tree ----------

def bfs_tree(G, root):
    parent = {root: None}
    parent_edge = {}
    depth = {root: 0}
    queue = [root]

    while queue:
        u = queue.pop(0)
        for v in G.adj[u]:
            if v not in parent:
                parent[v] = u
                parent_edge[v] = (u, v)
                depth[v] = depth[u] + 1
                queue.append(v)

    return parent, parent_edge, depth

# ---------- Path extraction ----------

def path_edges(parent_edge, u):
    path = []
    while u in parent_edge:
        e = parent_edge[u]
        path.append(tuple(sorted(e)))
        u = e[0]
    return path

def tree_path_edges(G, root, u, v):
    parent, parent_edge, _ = bfs_tree(G, root)
    pu = path_edges(parent_edge, u)
    pv = path_edges(parent_edge, v)
    return pu + pv

# ---------- Boundary ----------

def boundary_of_chain(G, chain):
    b = [0] * G.n
    for (u, v) in chain:
        b[u] ^= 1
        b[v] ^= 1
    return b

def delta(n, v):
    d = [0] * n
    d[v] = 1
    return d

def add_vec(a, b):
    return [(x ^ y) for x, y in zip(a, b)]

# ---------- Test ----------

def run_test(n=20, trials=10):
    for _ in range(trials):
        G = Graph(n)

        # sparse random graph (tree-like)
        for i in range(n):
            for j in range(i+1, n):
                if random.random() < 0.1:
                    G.add_edge(i, j)

        root = random.randint(0, n-1)
        u = random.randint(0, n-1)
        v = random.randint(0, n-1)

        path = tree_path_edges(G, root, u, v)
        b = boundary_of_chain(G, path)

        expected = add_vec(delta(n, u), delta(n, v))

        if b == expected:
            print("PASS: boundary cancellation holds")
            return True

    print("FAIL: cancellation not observed")
    return False

if __name__ == "__main__":
    run_test()
