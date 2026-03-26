import Mathlib.LinearAlgebra.Finrank

open FiniteDimensional

theorem rank_nullity
    {K V W : Type*} [Field K]
    [AddCommGroup V] [Module K V] [FiniteDimensional K V]
    [AddCommGroup W] [Module K W]
    (f : V →ₗ[K] W) :
    finrank K (LinearMap.ker f) + finrank K (LinearMap.range f) =
    finrank K V := by
  simpa using LinearMap.finrank_range_add_finrank_ker f
