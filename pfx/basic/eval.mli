(* Question 9.3 *)
type value = 
  | Int of int
  | ExecSeq of Ast.command list

val string_of_value: value -> string

val eval_program: Ast.program -> value list -> unit
val step: Ast.command list * value list -> (Ast.command list * value list, string * (Ast.command list * value list))result