open RG_SimpUtil


val simps = load_ruleset [
  "axioms/red_copy", "axioms/green_copy", "axioms/red_sp", "axioms/green_sp", "axioms/hopf",
  "axioms/red_scalar", "axioms/green_scalar", "axioms/green_id",
  "axioms/red_id", "axioms/red_loop", "axioms/green_loop", "axioms/red_elim" , "axioms/green_elim",
  "axioms/red_pi", "axioms/green_pi"
];


register_simproc ("basic_simp", REDUCE_ALL simps);








