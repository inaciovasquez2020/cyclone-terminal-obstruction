import networkx as nx
import random

def random_lift(base, flip_prob=0.5):
    G = nx.Graph()
    for v in base.nodes():
        G.add_node((v,0))
        G.add_node((v,1))
    for u,v in base.edges():
        if random.random() < flip_prob:
            G.add_edge((u,0),(v,1))
            G.add_edge((u,1),(v,0))
        else:
            G.add_edge((u,0),(v,0))
            G.add_edge((u,1),(v,1))
    return G

def local_signature(G, R):
    sig = {}
    for v in G.nodes():
        ball = nx.ego_graph(G, v, radius=R)
        sig[v] = tuple(sorted([d for _,d in ball.degree()]))
    return sig

def invariant_beta1(G):
    return G.number_of_edges() - G.number_of_nodes() + nx.number_connected_components(G)

def test_cycle_parity_lift():
    base = nx.cycle_graph(9)
    G1 = random_lift(base, flip_prob=0.0)
    G2 = random_lift(base, flip_prob=1.0)

    sig1 = local_signature(G1, R=2)
    sig2 = local_signature(G2, R=2)

    assert sorted(sig1.values()) == sorted(sig2.values())

    b1 = invariant_beta1(G1) % 2
    b2 = invariant_beta1(G2) % 2

    assert b1 != b2

if __name__ == "__main__":
    test_cycle_parity_lift()
    print("PASS")
