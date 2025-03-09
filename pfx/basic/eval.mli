val eval_program: Ast.program -> int list -> unit
val step: Ast.command list * int list -> (Ast.command list * int list, string * (Ast.command list * int list))result