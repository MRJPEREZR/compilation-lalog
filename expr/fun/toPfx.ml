open Ast
open BasicPfx.Ast

(* Question 10.3 *)
let rec generate env (expr : expression) : command list =
    match expr with
    | Const n -> [Push n]
    | Var x -> 
        (try 
           [Push (List.assoc x env); Get] 
         with Not_found -> failwith ("Unbound variable: " ^ x))
    | Binop (BinOp.Badd, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code1 @ code2 @ [Add]
    | Binop (BinOp.Bsub, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code2 @ code1 @ [Sub] (* Reverse order *)
    | Binop (BinOp.Bmul, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code1 @ code2 @ [Mul]
    | Binop (BinOp.Bdiv, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code2 @ code1 @ [Div]  (* Reverse order: denominator first *)
    | Binop (BinOp.Bmod, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code2 @ code1 @ [Rem]  (* Reverse order: denominator first *)
    | Uminus e ->
        let code = generate env e in  
        code @ [Push 0; Sub]  
    | App(e1, e2) ->
        let code2 = generate env e2 in  
        let code1 = generate env e1 in  
        code2 @ code1 @ [Exec] 
    | Fun(x, e) ->
        let new_env = (x, List.length env) :: env in
        [ExecSeq (generate new_env e)]
  