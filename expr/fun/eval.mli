(* Exception that may be raised on error at run time by the function eval *)
exception RuntimeError of string

type value =
  | Int of int
  | Closure of (string * value) list * string * Ast.expression

(* Function that evaluates an expression in a given environment *)
val eval : (string * value) list -> Ast.expression -> value
