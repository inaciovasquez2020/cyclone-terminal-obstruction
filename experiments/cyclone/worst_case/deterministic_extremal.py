import math
import json

def worst_case_instance(n, c0, Ccap, k, Cloc, c1, c2):
    H0 = n
    transcriptCap = Ccap * (math.log(n)**k)
    boundaryOverlap = Cloc
    varianceCost = n**0.5
    boundaryCost = 5.0
    blockGap = c0
    depth = max(c1 * n, (c2 * n) / blockGap)

    return {
        "H0": H0,
        "transcriptCap": transcriptCap,
        "boundaryOverlap": boundaryOverlap,
        "varianceCost": varianceCost,
        "boundaryCost": boundaryCost,
        "blockGap": blockGap,
        "defect": 0.0,
        "depth": depth
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

if __name__ == "__main__":
    n = 100
    P = {"c0": 0.5, "Ccap": 1.0, "k": 2.0, "Cloc": 10.0}
    K = {"cap":2.0,"loc":2.0,"var":2.0,"bdry":2.0,"bg":2.0,"err":2.0,"ref":5.0}

    X = worst_case_instance(n, P["c0"], P["Ccap"], P["k"], P["Cloc"], c1=0.4, c2=0.2)
    result = check_cyclone(K, X)

    out = {
        "instance": X,
        "cyclone_holds": result
    }

    print(out)
    with open("experiments/cyclone/worst_case/result.json","w") as f:
        json.dump(out, f, indent=2)
