open Ast
open Printf

let string_of_stack stack = sprintf "[%s]" (String.concat ";" (List.map string_of_int stack))

let string_of_state (cmds,stack) =
  (match cmds with
   | [] -> "no command"
   | cmd::_ -> sprintf "executing %s" (string_of_command cmd))^
    (sprintf " with stack %s" (string_of_stack stack))

(* Question 4.2 *)
let step state =
  match state with
  | [], _ -> Error("Nothing to step", state)
  (* Valid configurations *)
  | Push n :: q , stack -> Ok (q, n :: stack)
  | Pop :: q, _ :: rest -> Ok (q, rest)
  | Swap :: q, x :: y :: rest -> Ok(q, y :: x :: rest)
  | Add :: q, x :: y :: rest -> Ok(q, (x + y) :: rest)
  | Sub :: q, x :: y :: rest -> Ok(q, (x - y) :: rest)
  | Mul :: q, x :: y :: rest -> Ok(q, (x * y) :: rest)
  | Div :: q, x :: y :: rest -> 
    if y = 0 then Error("Division by zero", state)
    else Ok(q, (x / y) :: rest)
  | Rem :: q, x :: y :: rest -> 
    if y = 0 then Error("Remain by zero", state)
    else Ok(q, (x mod y) :: rest)
  | _, _ -> Error("Invalid Operation", state)

let eval_program (numargs, cmds) args =
  let rec execute = function
    | [], []    -> Ok None
    | [], v::_  -> Ok (Some v)
    | state ->
       begin
         match step state with
         | Ok s    -> execute s
         | Error e -> Error e
       end
  in
  if numargs = List.length args then
    match execute (cmds,args) with
    | Ok None -> printf "No result\n"
    | Ok(Some result) -> printf "= %i\n" result
    | Error(msg,s) -> printf "Raised error %s in state %s\n" msg (string_of_state s)
  else printf "Raised error \nMismatch between expected and actual number of args\n"