open Ast
open BasicPfx.Ast

(* module StringSet = Set.Make(String)

let freevars (e : expression) : string list =
  let rec aux bound expr =
    match expr with
    | Const _ -> StringSet.empty
    | Var x -> if List.mem x bound then StringSet.empty else StringSet.singleton x
    | Binop (_, e1, e2) -> StringSet.union (aux bound e1) (aux bound e2)
    | Uminus e -> aux bound e
    | Fun (x, body) -> aux (x :: bound) body
    | App (e1, e2) -> StringSet.union (aux bound e1) (aux bound e2)
  in
  StringSet.elements (aux [] e) *)

let rec generate env (expr : expression) : command list =
    match expr with
    | Const n -> [Push n]
    | Var x -> 
        (try [Push (List.assoc x env); Get] 
            with Not_found -> failwith ("Unbound variable: " ^ x))
    | Binop (op, e1, e2) ->
        let code1 = generate env e1 in
        let code2 = generate env e2 in
        let op_cmd = match op with
            | BinOp.Badd -> [Add]
            | BinOp.Bsub -> [Swap; Sub]
            | BinOp.Bmul -> [Mul]
            | BinOp.Bdiv -> [Swap; Div]
            | BinOp.Bmod -> [Swap; Rem]
        in
        code1 @ code2 @ op_cmd
    | Uminus e -> generate env e @ [Push 0; Sub]
    | App(e1, e2) ->
        let code1 = generate env e1 in  (* generates the function *)
        let code2 = generate env e2 in  (* generates the argument *)
        (* Push argument, then function, then Exec *)
        code2 @ code1 @ [Exec]
    | Fun (x, e) ->
        let body_code = generate ((x, 0) :: env) e in
        (* Create closure with just the body code *)
        [Pushval (Closure body_code)]  (* Store commands as a Closure value *)