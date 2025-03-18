open Ast
open BasicPfx.Ast

(* Question 10.3 *)
let rec generate env (expr: expression) : command list =
  match expr with
  | Const n -> [Push n]
  | Var x -> [Push (List.assoc x env); Get]
  | Binop (op, e1, e2) ->
      let code1 = generate env e1 in  
      let code2 = generate env e2 in 
      let op_code = match op with
        | BinOp.Badd -> Add
        | BinOp.Bsub -> Sub
        | BinOp.Bmul -> Mul
        | BinOp.Bdiv -> Div
        | BinOp.Bmod -> Rem
      in
      code1 @ code2 @ [op_code] 
  | Uminus e ->
      let code = generate env e in  
      code @ [Push 0; Sub]  
  | App(e1, e2) ->
      let code2 = generate env e2 in  
      let code1 = generate env e1 in  
      code2 @ code1 @ [Exec] 
  | Fun(x, e) ->
      let new_env = (x, 0) :: env in
      [ExecSeq (generate new_env e)]