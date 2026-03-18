# Boundary Coupling Theorem

## Theorem
Let \(B_i,B_j\) be adjacent \(d\)-dimensional cubic blocks of side length \(L\), and let
\[
\bar f_{B_i} := \frac{1}{|B_i|}\sum_{x\in B_i} f(x).
\]
Then there exists a constant \(C_{\partial}(d)\) such that
\[
|\bar f_{B_i}-\bar f_{B_j}|^2
\le
C_{\partial}(d)\,L^{-(d-1)}
\sum_{\ell\in \partial(B_i,B_j)} |\nabla_\ell f|^2.
\]

Consequently,
\[
\sum_B |B|\,|\bar f_B-\bar f|^2
\le
C_{\partial}(d)\,C_{\mathrm{bg}}(\mathcal B_L)\,L
\sum_{\ell\ \mathrm{cross}} |\nabla_\ell f|^2.
\]

## Certification target
Peer-verifiable closure requires explicit computation of
\[
C_{\partial}(d)
\]
for the lattice and adjacency convention used in the proof.
