(* improved simproc using the rotate rule to reduce to pseudo-normal form
 * for phase-free graphs
 *
 * NOTE: you currently must build the latest (integration) version of
 * of Quantomatic from source to use this simproc. See instructions
 * on quantomatic.github.io. *)
open RG_SimpUtil

val rotate = load_rule "theorems/rotate_targeted";
val green_ids = load_rule "theorems/green_id_on_red";
val green_elim = load_rule "theorems/green_elim";
val green_scalar = load_rule "axioms/green_scalar";
val simps = load_ruleset [
  "axioms/red_copy", "axioms/red_sp", "axioms/green_sp", "axioms/hopf",
  "axioms/red_scalar", "axioms/green_scalar", "axioms/green_id",
  "axioms/red_id", "axioms/red_loop", "axioms/green_loop"];

val targetf = min_arity_vertex_where is_interior_green
fun target_arity g = case targetf g of SOME v => arity g v | NONE => 0
fun target_with_arity a = vertex_where (fn g => fn v =>
  is_interior_green g v andalso arity g v = a)

val simproc = (
  REDUCE_ALL simps ++
  REDUCE_METRIC_TO 0 num_boundary_red green_ids ++
  LOOP (
    LOOP_WHILE (fn g => target_arity g >= 2)
      (REWRITE_TARGETED { PATTERN = const_vertex "v10", 
                          TARGET  = targetf } rotate) ++
    LOOP (
      REWRITE_TARGETED { PATTERN = const_vertex "v10", 
                         TARGET  = target_with_arity 1 } green_elim ++
      REDUCE green_scalar)
  ) ++
  REDUCE_ALL simps
);

register_simproc ("rotate_targeted", simproc);






