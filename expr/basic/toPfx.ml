open Ast
open BasicPfx.Ast

(* Question 5.2 *)
let rec generate (expr : expression) : command list =
  match expr with
  | Const n -> [Push n]
  | Binop (BinOp.Badd, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code1 @ code2 @ [Add]
  | Binop (BinOp.Bsub, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code2 @ code1 @ [Sub] (* Reverse order *)
  | Binop (BinOp.Bmul, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code1 @ code2 @ [Mul]
  | Binop (BinOp.Bdiv, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code2 @ code1 @ [Div]  (* Reverse order: denominator first *)
  | Binop (BinOp.Bmod, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code2 @ code1 @ [Rem]  (* Reverse order: denominator first *)
  | Uminus e ->
      let code = generate e in  
      code @ [Push 0; Sub]  
  | Var _ -> failwith "Not yet supported"