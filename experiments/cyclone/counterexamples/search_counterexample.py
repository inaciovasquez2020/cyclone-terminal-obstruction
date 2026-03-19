import math
import random
import json

def admissible(P, X):
    return (
        X["H0"] >= 0
        and P["n"] > 0
        and X["H0"] <= P["n"]
        and X["blockGap"] >= P["c0"]
        and X["transcriptCap"] <= P["Ccap"] * (math.log(P["n"]) ** P["k"])
        and X["boundaryOverlap"] <= P["Cloc"]
        and X["depth"] >= P["c1"] * P["n"]
        and X["blockGap"] * X["depth"] >= P["c2"] * P["n"]
        and X["varianceCost"] <= P["Vmax"]
    )

def generate_candidate(n):
    return {
        "H0": n,
        "transcriptCap": random.uniform(0, (math.log(n) ** 2)),
        "boundaryOverlap": random.uniform(0, 20),
        "varianceCost": random.uniform(0, n),
        "boundaryCost": random.uniform(0, 10),
        "blockGap": random.uniform(0.01, 1.0),
        "defect": random.uniform(0, 5),
        "depth": random.uniform(0.01, n),
    }

def coercivity(K, X):
    return (
        K["cap"] * X["transcriptCap"]
        + K["loc"] * X["boundaryOverlap"]
        + K["var"] * X["varianceCost"]
        + K["bdry"] * X["boundaryCost"]
        + K["bg"] * X["blockGap"]
        + K["err"] * X["defect"]
    )

def violates_cyclone(K, X):
    lhs = X["H0"] - coercivity(K, X)
    rhs = K["ref"] * X["depth"]
    return lhs > rhs

def search(trials=10000, n=100):
    P = {"n": n, "c0": 0.5, "Ccap": 1.0, "k": 2.0, "Cloc": 10.0, "c1": 0.4, "c2": 0.2, "Vmax": n ** 0.5}
    K = {"cap": 2.0, "loc": 2.0, "var": 2.0, "bdry": 2.0, "bg": 2.0, "err": 2.0, "ref": 5.0}
    admissible_trials = 0
    counterexamples = []
    for _ in range(trials):
        X = generate_candidate(n)
        if not admissible(P, X):
            continue
        admissible_trials += 1
        if violates_cyclone(K, X):
            counterexamples.append(X)
    return {
        "raw_trials": trials,
        "admissible_trials": admissible_trials,
        "found": len(counterexamples),
        "examples": counterexamples[:5],
    }

if __name__ == "__main__":
    out = search()
    print(out)
    with open("experiments/cyclone/counterexamples/results.json", "w") as f:
        json.dump(out, f, indent=2)
