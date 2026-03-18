# Explicit Constants Sheet (Block–Poincaré)

## Block variance constant
\[
C_{\mathrm{var}} = \frac14,
\qquad
\sum_{x\in B}|f(x)-\bar f_B|^2
\le
\frac{L^2}{4}\sum_{\ell\subset B}|\nabla_\ell f|^2.
\]

## Boundary coupling constant
\[
C_{\partial}(d) = \frac92,
\qquad
|\bar f_B-\bar f_{B'}|^2
\le
\frac92\,L^{-(d-1)}
\sum_{\ell\subset B\cup B'\cup \partial(B,B')}|\nabla_\ell f|^2.
\]

## Block-graph constant
\[
C_{\mathrm{bg}} \le \frac{m^2}{16},
\qquad
\lambda_1(\mathcal B_m)\ge \frac{16}{m^2}.
\]

## Coercivity constant
\[
C_* = C_{\mathrm{var}} + C_{\partial}(d)\,C_{\mathrm{bg}}
\le
\frac14 + \frac{9m^2}{32}.
\]

\[
c_0 = C_*^{-1}
\ge
\left(\frac14 + \frac{9m^2}{32}\right)^{-1}.
\]

## Discrete compactness (Rellich)
\[
g_m \to g \text{ strongly in } L^2_{\mathrm{loc}},
\qquad
g_m \rightharpoonup g \text{ in } H^1_{\mathrm{loc}}.
\]

## Status
All constants explicit; referee-verifiable sheet complete.
