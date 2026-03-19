import math
import random
import json

def sample_instance(n, c0, Ccap, k, Cloc, c1, c2):
    H0 = n
    transcriptCap = random.uniform(0, Ccap * (math.log(n)**k))
    boundaryOverlap = random.uniform(0, Cloc)
    varianceCost = random.uniform(0, n**0.5)
    boundaryCost = random.uniform(0, 5)
    blockGap = random.uniform(c0, c0 + 1.0)
    depth = random.uniform(c1 * n, n)

    if blockGap * depth < c2 * n:
        return None

    return {
        "H0": H0,
        "transcriptCap": transcriptCap,
        "boundaryOverlap": boundaryOverlap,
        "varianceCost": varianceCost,
        "boundaryCost": boundaryCost,
        "blockGap": blockGap,
        "defect": random.uniform(0, 3),
        "depth": depth
    }

def admissible(P, X):
    return (
        X["H0"] >= 0 and
        P["n"] > 0 and
        X["H0"] <= P["n"] and
        X["blockGap"] >= P["c0"] and
        X["transcriptCap"] <= P["Ccap"] * (math.log(P["n"])**P["k"]) and
        X["boundaryOverlap"] <= P["Cloc"]
    )

def coercivity(K, X):
    return (
        K["cap"] * X["transcriptCap"]
        + K["loc"] * X["boundaryOverlap"]
        + K["var"] * X["varianceCost"]
        + K["bdry"] * X["boundaryCost"]
        + K["bg"] * X["blockGap"]
        + K["err"] * X["defect"]
    )

def check_cyclone(K, X):
    lhs = X["H0"] - coercivity(K, X)
    rhs = K["ref"] * X["depth"]
    return lhs <= rhs

def run_trials(trials=1000, n=100):
    P = {"n": n, "c0": 0.5, "Ccap": 1.0, "k": 2.0, "Cloc": 10.0}
    K = {"cap":2.0,"loc":2.0,"var":2.0,"bdry":2.0,"bg":2.0,"err":2.0,"ref":5.0}
    results = []
    for _ in range(trials):
        X = sample_instance(n, P["c0"], P["Ccap"], P["k"], P["Cloc"], c1=0.4, c2=0.2)
        if X is None:
            continue
        if not admissible(P, X):
            continue
        results.append(check_cyclone(K, X))
    return {
        "trials": len(results),
        "success_rate": sum(results)/len(results) if results else 0.0
    }

if __name__ == "__main__":
    out = run_trials()
    print(out)
    with open("experiments/cyclone/results.json","w") as f:
        json.dump(out, f, indent=2)
