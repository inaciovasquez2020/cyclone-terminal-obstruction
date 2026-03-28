import random
from collections import defaultdict

class Graph:
    def __init__(self, n):
        self.n = n
        self.edges = set()

    def add_edge(self, u, v):
        if u == v: return
        self.edges.add((min(u,v), max(u,v)))

    def neighbors(self, u):
        for a,b in self.edges:
            if a == u: yield b
            elif b == u: yield a

def two_lift(G, sigma):
    H = Graph(2 * G.n)
    for (u,v) in G.edges:
        for b in [0,1]:
            w = b ^ sigma[(u,v)]
            H.add_edge(2*u + b, 2*v + w)
    return H

def cycle_basis(G):
    parent = [-1]*G.n
    visited = [False]*G.n
    basis = []

    def dfs(u):
        visited[u] = True
        for v in G.neighbors(u):
            if not visited[v]:
                parent[v] = u
                dfs(v)
            elif parent[u] != v:
                cycle = []
                x, y = u, v
                seen = set()
                while x != -1:
                    seen.add(x)
                    x = parent[x]
                while y not in seen:
                    y = parent[y]
                lca = y
                x = u
                while x != lca:
                    cycle.append((min(x,parent[x]), max(x,parent[x])))
                    x = parent[x]
                y = v
                path = []
                while y != lca:
                    path.append((min(y,parent[y]), max(y,parent[y])))
                    y = parent[y]
                cycle.extend(reversed(path))
                basis.append(set(cycle))

    for i in range(G.n):
        if not visited[i]:
            dfs(i)

    return basis

def parity_functional(cycle, twist_edges):
    return sum(1 for e in cycle if e in twist_edges) % 2

def run_test(n=20, trials=5):
    for _ in range(trials):
        G = Graph(n)
        for i in range(n):
            for j in range(i+1, n):
                if random.random() < 0.1:
                    G.add_edge(i,j)

        sigma = {}
        twist_edges = set()
        for e in G.edges:
            val = random.randint(0,1)
            sigma[e] = val
            if val == 1:
                twist_edges.add(e)

        G0 = two_lift(G, defaultdict(int))
        G1 = two_lift(G, sigma)

        basis0 = cycle_basis(G0)
        basis1 = cycle_basis(G1)

        parity0 = [parity_functional(c, twist_edges) for c in basis0]
        parity1 = [parity_functional(c, twist_edges) for c in basis1]

        if any(parity1) and not any(parity0):
            print("PASS")
            return True

    print("FAIL")
    return False

if __name__ == "__main__":
    run_test()
