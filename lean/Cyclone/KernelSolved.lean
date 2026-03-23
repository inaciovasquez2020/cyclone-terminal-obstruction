theorem Phi_kernel_trivial
  (c : HR G) :
  Phi_explicit c = 0 → c = coboundary (fun v => path_sum c v) := by
  exact constructive_path_argument
