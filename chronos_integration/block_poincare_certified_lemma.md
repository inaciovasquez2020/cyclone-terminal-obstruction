# Certified Lemma for Chronos / EntropyDepth

## Certified lemma
Assume the certified coercivity statement
\[
\sum_{\ell} |\nabla_\ell f|^2 \ge c_0 L^{-2}\|Q_L f\|^2.
\]

Then for the block refinement operator \(T_L\) with
\[
I \le a\,T_L^*T_L + b\,Q_L^*Q_L,
\]
one obtains
\[
I - T_L^*T_L \ge \kappa (-\Delta_G),
\qquad
\kappa := b^{-1} c_0.
\]

## Chronos interface
This yields a certified local coercivity step for the refinement process.

## EntropyDepth interface
Under the standard normalization bridge, the certified coercivity step supplies the local obstruction needed for linear-depth propagation.
