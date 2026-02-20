B0 structural bound (overlap-rank control)

Definitions
- Fix an edge order E={e1,...,em}.
- For a simple cycle C, define 1_C ∈ F2^m by (1_C)i = 1[ei ∈ C].
- For a family of cycles C={C1,...,Cs}, define M_C ∈ F2^{s×m} with rows 1_Cj.
- Define orank(C) := rank_F2(M_C).

Structural BOM parameterization
Assume there exists a function
  B0 = B0(k, Δ, h)
such that for any (Δ,h)-cycle-expander G and any cycle family C in G with orank(C) ≤ B0,
every FO^k type realized in G has a witness inside some rooted ball of radius
  R = R(k, Δ, h).

Replacement of crude counting bound
Do not use B0 := T(k,r,Δ)+1 with T ≤ 2^(N(Δ,r) choose 2).
Instead, B0 is defined as the minimal constant in the overlap-rank BOM principle:
  B0(k,Δ,h) := inf { B : BOM(k,Δ,h,B) holds }.

Certification intent
BOM certificates should record:
- (k,Δ,h) and declared B0(k,Δ,h)
- measured orank(C) via F2-rank witness
- radius R used for local witnessing
