open Ast
open BasicPfx.Ast

(* Question 5.2 *)
let rec generate (expr : expression) : command list =
  match expr with
  | Const n -> [Push n]
  | Binop (op, e1, e2) ->
    let code1 = generate e1 in  
    let code2 = generate e2 in  
    let op_code = match op with  
      | BinOp.Badd -> Add
      | BinOp.Bsub -> Sub
      | BinOp.Bmul -> Mul
      | BinOp.Bdiv -> Div
      | BinOp.Bmod -> Rem
    in
    code1 @ code2 @ [op_code]  
  | Uminus e ->
    let code = generate e in  
    code @ [Push 0; Sub]  
  | Var _ -> failwith "Not yet supported" 
