import os
import json
import math

def verify(cert):
    n = cert["n"]
    assert n > 0
    assert cert["c0"] > 0
    assert cert["constants"]["kappa_ref"] > 0
    return True

if __name__ == "__main__":
    with open(os.path.join(os.path.dirname(__file__), "example_certificate.json")) as f:
        cert = json.load(f)
    print({"valid": verify(cert)})
