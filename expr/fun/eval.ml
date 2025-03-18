(* Question 10.3 *)

open Ast

exception RuntimeError of string

type value =
  | Int of int
  | Closure of (string * value) list * string * Ast.expression

let rec eval env = function
  | Const c -> c
  | Var v -> (try List.assoc v env with Not_found -> raise(RuntimeError("Unbound variable "^v)))
  | Binop(op,e1,e2) ->
     begin
       match op,eval env e2 with
       | (Bdiv | Bmod), 0 -> raise(RuntimeError("division by zero"))
       | _, v -> (BinOp.eval op) (eval env e1) v
     end
  | Uminus e -> - (eval env e)
  | Fun(x, e) -> 
    (* A function is a closure: it captures the current environment *)
    Closure(env, x, e)
  | App(e1, e2) ->
      (* Evaluate e1 to get the function (should be a closure) *)
      let f = eval env e1 in
      (* Evaluate e2 to get the argument *)
      let arg = eval env e2 in
      (* Apply the function to the argument *)
      match f with
      | Closure(closure_env, x, body) ->
          (* Extend the closure's environment with the new binding *)
          let new_env = (x, arg) :: closure_env in
          (* Evaluate the body in the extended environment *)
          eval new_env body
      | _ -> raise (RuntimeError "Application of non-function value")
