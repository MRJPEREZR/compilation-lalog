open Ast
open Printf

(* Question 9.3 *)
let string_of_stack stack = sprintf "[%s]" (String.concat ";" (List.map string_of_value stack))

let string_of_state (cmds, stack) =
  (match cmds with
   | [] -> "no command"
   | cmd::_ -> sprintf "executing %s" (string_of_command cmd))^
    (sprintf " with stack %s" (string_of_stack stack))

(* Question 4.2, 9.3 and 13.3 *)
(* let step state =
  match state with
  | [], _ -> Error("Nothing to step", state)

  (* Standard commands *)
  | Push n :: q , stack -> Ok (q, Int n :: stack)
  | Pushval v :: q, stack -> Ok (q, v :: stack)  (* NEW *)
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

  (* Closure logic *)
  | Exec :: q, Closure cmds :: rest -> Ok (cmds @ q, rest)
  | ExecSeq cmds :: q, stack -> Ok (q, Closure cmds :: stack)
  | Append :: q, v :: Closure cmds :: rest -> Ok (q, Closure (cmds @ [Pushval v]) :: rest)  (* NEW *)

  (* Stack operations *)
  | Get :: q, Int i :: rest ->
      if i < 0 || i >= List.length rest then
        Error("Invalid index for Get", state)
      else
        let elem = List.nth rest i in
        Ok (q, elem :: rest)

  | _, _ -> Error("Invalid Operation", state) *)
let step state =
  match state with
  | [], _ -> Error("Nothing to step", state)
  | Push n :: q, stack -> Ok (q, Int n :: stack)
  | Pushval v :: q, stack -> Ok (q, v :: stack)
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
  (* Modified closure execution *)
  | Exec :: q, arg :: Closure cmds :: rest ->
    (* Execute the closure's commands with argument on stack *)
    Ok (cmds @ q, arg :: rest)
  | ExecSeq cmds :: q, stack -> Ok (q, Closure cmds :: stack)
  | Append :: q, v :: Closure cmds :: rest -> Ok (q, Closure (cmds @ [Pushval v]) :: rest)
  | Get :: q, Int i :: rest ->
      if i < 0 || i >= List.length rest then
        Error("Invalid index for Get", state)
      else
        let elem = List.nth rest i in
        Ok (q, elem :: rest)
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
    | Ok (Some (Closure _)) -> printf "= <executable sequence>\n"
    | Error(msg,s) -> printf "Raised error %s in state %s\n" msg (string_of_state s)
  else printf "Raised error \nMismatch between expected and actual number of args\n"
