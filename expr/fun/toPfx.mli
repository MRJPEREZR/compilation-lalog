(* Function that generate a Pfx program from an Expr program *)
val generate : (string * int) list -> Ast.expression -> BasicPfx.Ast.command list
