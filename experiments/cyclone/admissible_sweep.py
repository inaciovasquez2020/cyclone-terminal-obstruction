import math
import random
import json

def sample_instance(n, c0, Ccap, k, Cloc, c_depth):
    H0 = n
    transcriptCap = random.uniform(0, Ccap * (math.log(n)**k))
    boundaryOverlap = random.uniform(0, Cloc)
    varianceCost = random.uniform(0, 5)
    boundaryCost = random.uniform(0, 5)
    blockGap = random.uniform(c0, c0 + 1.0)
    defect = random.uniform(0, 3)
    depth = random.uniform(c_depth * n, n)

    return {
        "H0": H0,
        "transcriptCap": transcriptCap,
        "boundaryOverlap": boundaryOverlap,
        "varianceCost": varianceCost,
        "boundaryCost": boundaryCost,
        "blockGap": blockGap,
        "defect": defect,
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
    K = {"cap":1.0,"loc":1.0,"var":1.0,"bdry":1.0,"bg":1.0,"err":1.0,"ref":1.0}
    results = []
    for _ in range(trials):
        X = sample_instance(n, P["c0"], P["Ccap"], P["k"], P["Cloc"], c_depth=0.2)
        if not admissible(P, X):
            continue
        ok = check_cyclone(K, X)
        results.append(ok)
    return {
        "trials": len(results),
        "success_rate": sum(results)/len(results) if results else 0.0
    }

if __name__ == "__main__":
    out = run_trials()
    print(out)
    with open("experiments/cyclone/results.json","w") as f:
        json.dump(out, f, indent=2)
