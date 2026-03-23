theorem path_independence
  (c : HR G) :
  (∀ C, ∑ e in C, c e = 0) →
  well_defined (fun v => path_sum c v) := by
  admit
