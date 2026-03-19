import math
import random
import json

def sample_instance(n):
    return {
        "H0": random.uniform(0.1, n),
        "transcriptCap": random.uniform(0, (math.log(n)**2)),
        "boundaryOverlap": random.uniform(0, 10),
        "varianceCost": random.uniform(0, 5),
        "boundaryCost": random.uniform(0, 5),
        "blockGap": random.uniform(0.1, 2),
        "defect": random.uniform(0, 3),
        "depth": random.uniform(0.1, n)
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

def check_cyclone(K, X):
    lhs = X["H0"] - coercivity(K, X)
    rhs = K["ref"] * X["depth"]
    return lhs <= rhs

def run_trials(trials=1000, n=100):
    K = {"cap":1.0,"loc":1.0,"var":1.0,"bdry":1.0,"bg":1.0,"err":1.0,"ref":1.0}
    results = []
    for _ in range(trials):
        X = sample_instance(n)
        ok = check_cyclone(K, X)
        results.append(ok)
    return {
        "trials": trials,
        "success_rate": sum(results)/trials
    }

if __name__ == "__main__":
    out = run_trials()
    print(out)
    with open("experiments/cyclone/results.json","w") as f:
        json.dump(out, f, indent=2)
