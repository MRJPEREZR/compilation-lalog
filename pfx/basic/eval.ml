open Ast
open Printf

(* Question 9.3 *)
type value = 
  | Int of int
  | ExecSeq of Ast.command list
let string_of_value = function
  | Int i -> string_of_int i
  | ExecSeq cmds -> string_of_commands cmds

let string_of_stack stack = sprintf "[%s]" (String.concat ";" (List.map string_of_value stack))

let string_of_state (cmds, stack) =
  (match cmds with
   | [] -> "no command"
   | cmd::_ -> sprintf "executing %s" (string_of_command cmd))^
    (sprintf " with stack %s" (string_of_stack stack))

(* Question 4.2 and 9.3 *)
let step state =
  match state with
  | [], _ -> Error("Nothing to step", state)
  (* Valid configurations *)
  | Push n :: q , stack -> Ok (q, Int n :: stack)
  | Pop :: q, _ :: rest -> Ok (q, rest)
  | Swap :: q, Int x :: Int y :: rest -> Ok(q, Int y :: Int x :: rest)
  | Add :: q, Int x :: Int y :: rest -> Ok(q, Int (x + y) :: rest)
  | Sub :: q, Int x :: Int y :: rest -> Ok(q, Int (x - y) :: rest)
  | Mul :: q, Int x :: Int y :: rest -> Ok(q, Int (x * y) :: rest)
  | Div :: q, Int x :: Int y :: rest -> 
    if y = 0 then Error("Division by zero", state)
    else Ok(q, Int (x / y) :: rest)
  | Rem :: q, Int x :: Int y :: rest -> 
    if y = 0 then Error("Remain by zero", state)
    else Ok(q, Int (x mod y) :: rest)
  | Exec :: q, ExecSeq cmds :: rest -> Ok (cmds @ q, rest)
  | Get :: q, Int i :: rest ->
      if i < 0 || i >= List.length rest then
        Error("Invalid index for Get", state)
      else
        let elem = List.nth rest i in
        Ok (q, elem :: rest)
  | ExecSeq cmds :: q, stack -> Ok (q, ExecSeq cmds :: stack)
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
    let stack = args in 
    match execute (cmds, stack) with
    | Ok None -> printf "No result\n"
    | Ok (Some (Int result)) -> printf "= %i\n" result
    | Ok (Some (ExecSeq _)) -> printf "= <executable sequence>\n"
    | Error(msg,s) -> printf "Raised error %s in state %s\n" msg (string_of_state s)
  else printf "Raised error \nMismatch between expected and actual number of args\n"