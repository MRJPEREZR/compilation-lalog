(* Question 10.3 *)
exception RuntimeError of string

type value =
  | Int of int
  | Closure of (string * value) list * string * Ast.expression

let rec eval env = function
  | Ast.Const c -> Int c
  | Ast.Var v ->
      (try List.assoc v env
       with Not_found -> raise (RuntimeError ("Unbound variable " ^ v)))
  | Ast.Binop(op, e1, e2) ->
      begin
        match eval env e2 with
        | Int 0 when op = BinOp.Bdiv || op = BinOp.Bmod ->
            raise (RuntimeError "division by zero")
        | Int v2 ->
            begin
              match eval env e1 with
              | Int v1 -> Int (BinOp.eval op v1 v2)
              | _ -> raise (RuntimeError "Invalid operand for binary operation")
            end
        | _ -> raise (RuntimeError "Invalid operand for binary operation")
      end
  | Ast.Uminus e ->
      begin
        match eval env e with
        | Int v -> Int (-v)
        | _ -> raise (RuntimeError "Invalid operand for unary minus")
      end
  | Ast.Fun(x, e) ->
      (* A function is a closure: it captures the current environment *)
      Closure(env, x, e)
  | Ast.App(e1, e2) ->
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
      