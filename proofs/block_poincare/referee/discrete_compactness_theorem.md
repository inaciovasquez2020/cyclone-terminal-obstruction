# Discrete Compactness Theorem

## Theorem
Let \(f_L\) be functions on \(L\)-block partitions with
\[
\|f_L\|_{L^2}=1,
\qquad
\sum_{\ell} |\nabla_\ell f_L|^2 \le C L^{-2}.
\]
Let \(g_L\) denote the unit-block rescaling. Assume:

1. Uniform local interpolation bound:
\[
\|g_L\|_{H^1(K)} \le C_K
\quad \text{for every compact } K.
\]

2. Discrete Rellich property:
bounded sequences in the rescaled discrete \(H^1\) norm are precompact in local \(L^2\).

Then there exists a subsequence with
\[
g_L \to g \quad \text{strongly in } L^2_{\mathrm{loc}},
\qquad
g_L \rightharpoonup g \quad \text{weakly in } H^1_{\mathrm{loc}}.
\]

If additionally
\[
\|\nabla g_L\|_{L^2(K)} \to 0
\quad \forall K,
\]
then
\[
\nabla g = 0
\]
and \(g\) is constant on each connected component.

## Certification target
Peer-verifiable closure requires a proof of the discrete Rellich property for the chosen rescaling map.
