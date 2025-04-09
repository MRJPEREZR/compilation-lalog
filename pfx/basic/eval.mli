(* Question 9.3 *)
open Ast 

val eval_program: Ast.program -> value list -> unit
val step: Ast.command list * value list -> (Ast.command list * value list, string * (Ast.command list * value list))result