# Explicit Coercivity Constant

## Theorem
Assume the following quantified ingredients hold uniformly in \(L\):

1. Block variance bound:
\[
\sum_{x\in B} |f(x)-\bar f_B|^2 \le C_{\mathrm{var}} L^2 \sum_{\ell\subset B} |\nabla_\ell f|^2.
\]

2. Boundary coupling:
\[
\sum_B |B|\,|\bar f_B-\bar f|^2 \le C_{\partial} L \sum_{\ell\ \mathrm{cross}} |\nabla_\ell f|^2.
\]

3. Block-graph Poincaré:
\[
\sum_B |B|\,|\bar f_B|^2 \le C_{\mathrm{bg}} L^2 \sum_{(B,B')\in E(\mathcal B_L)} |m_B-m_{B'}|^2.
\]

Then
\[
\|Q_L f\|^2 \le C_* L^2 \sum_{\ell} |\nabla_\ell f|^2,
\qquad
C_* := C_{\mathrm{var}} + C_{\partial} C_{\mathrm{bg}}.
\]

Equivalently,
\[
\sum_{\ell} |\nabla_\ell f|^2 \ge c_0 L^{-2}\|Q_L f\|^2,
\qquad
c_0 := C_*^{-1}.
\]

## Certification target
Peer-verifiable closure requires explicit numerical values for
\[
C_{\mathrm{var}},\quad C_{\partial},\quad C_{\mathrm{bg}},\quad c_0.
\]
