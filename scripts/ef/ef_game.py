from functools import lru_cache
from itertools import product

def adjacency(G, u, v):
    return v in G.get(u, set())

def partial_isomorphism(G1, G2, xs, ys):
    if len(set(xs)) != len(set(ys)):
        return False
    for i in range(len(xs)):
        for j in range(len(xs)):
            if adjacency(G1, xs[i], xs[j]) != adjacency(G2, ys[i], ys[j]):
                return False
            if (xs[i] == xs[j]) != (ys[i] == ys[j]):
                return False
    return True

def duplicator_wins_k_rounds(G1, G2, k=2, rounds=2):
    V1 = tuple(sorted(G1))
    V2 = tuple(sorted(G2))

    @lru_cache(None)
    def win(xs, ys, r):
        xs = list(xs)
        ys = list(ys)
        if not partial_isomorphism(G1, G2, xs, ys):
            return False
        if r == 0:
            return True
        for side in (1, 2):
            if side == 1:
                for a in V1:
                    ok = False
                    for b in V2:
                        nxs = (xs + [a])[-k:]
                        nys = (ys + [b])[-k:]
                        if win(tuple(nxs), tuple(nys), r - 1):
                            ok = True
                            break
                    if not ok:
                        return False
            else:
                for b in V2:
                    ok = False
                    for a in V1:
                        nxs = (xs + [a])[-k:]
                        nys = (ys + [b])[-k:]
                        if win(tuple(nxs), tuple(nys), r - 1):
                            ok = True
                            break
                    if not ok:
                        return False
        return True

    return win(tuple(), tuple(), rounds)
