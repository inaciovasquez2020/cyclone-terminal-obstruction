def gf2_rank(rows):
    rows = [list(map(lambda x: x & 1, row)) for row in rows if any(row)]
    if not rows:
        return 0
    m = len(rows)
    n = len(rows[0])
    rank = 0
    col = 0
    while col < n and rank < m:
        pivot = None
        for i in range(rank, m):
            if rows[i][col]:
                pivot = i
                break
        if pivot is None:
            col += 1
            continue
        rows[rank], rows[pivot] = rows[pivot], rows[rank]
        for i in range(m):
            if i != rank and rows[i][col]:
                rows[i] = [(a ^ b) for a, b in zip(rows[i], rows[rank])]
        rank += 1
        col += 1
    return rank

def gf2_rref(rows):
    rows = [list(map(lambda x: x & 1, row)) for row in rows]
    if not rows:
        return []
    m = len(rows)
    n = len(rows[0])
    rank = 0
    col = 0
    while col < n and rank < m:
        pivot = None
        for i in range(rank, m):
            if rows[i][col]:
                pivot = i
                break
        if pivot is None:
            col += 1
            continue
        rows[rank], rows[pivot] = rows[pivot], rows[rank]
        for i in range(m):
            if i != rank and rows[i][col]:
                rows[i] = [(a ^ b) for a, b in zip(rows[i], rows[rank])]
        rank += 1
        col += 1
    return rows
