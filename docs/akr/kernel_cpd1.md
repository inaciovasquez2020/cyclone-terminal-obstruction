Domain
X = S^1 with Haar measure dθ/(2π), H = L^2(S^1), H0 = {f : ∫ f = 0}.
Operator surrogate
L = -d^2/dθ^2 with periodic boundary conditions, spectrum {0,1,1,4,4,...}, so λ1(L)=1.
AKR kernel operator (CPD1 by construction)
Define K_AKR := L + Π_1 where Π_1 is projection onto constants.
As a distribution kernel: K_AKR(θ,φ) = -δ''(θ-φ) + 1.
CPD1 certificate
For any points θ_i and coefficients c_i with Σ c_i = 0, define μ = Σ c_i δ_{θ_i}.
Let u solve Lu = μ with ∫ u = 0. Then
Σ_{i,j} c_i c_j K_AKR(θ_i,θ_j) = ⟨μ,u⟩ = ⟨Lu,u⟩ = ∫ |u'|^2 dθ/(2π) >= 0.
