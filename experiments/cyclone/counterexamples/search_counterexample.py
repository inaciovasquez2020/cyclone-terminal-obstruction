import math
import random
import json

def generate_candidate(n):
    return {
        "H0": n,
        "transcriptCap": random.uniform(0, (math.log(n)**2)),
        "boundaryOverlap": random.uniform(0, 20),
        "varianceCost": random.uniform(0, n),
        "boundaryCost": random.uniform(0, 10),
        "blockGap": random.uniform(0.01, 1.0),
        "defect": random.uniform(0, 5),
        "depth": random.uniform(0.01, n)
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
    K = {"cap":2.0,"loc":2.0,"var":2.0,"bdry":2.0,"bg":2.0,"err":2.0,"ref":5.0}
    counterexamples = []

    for _ in range(trials):
        X = generate_candidate(n)
        if violates_cyclone(K, X):
            counterexamples.append(X)

    return {
        "trials": trials,
        "found": len(counterexamples),
        "examples": counterexamples[:5]
    }

if __name__ == "__main__":
    out = search()
    print(out)
    with open("experiments/cyclone/counterexamples/results.json","w") as f:
        json.dump(out, f, indent=2)
