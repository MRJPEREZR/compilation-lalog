type command =
  | Push of int (* Question 4.1 and 9.3 *)
  | Pop 
  | Swap
  | Add
  | Sub
  | Mul
  | Div
  | Rem
  | Exec
  | ExecSeq of command list
  | Get

type program = int * command list

(* add here all useful functions and types  related to the AST: for instance  string_of_ functions *)

let rec string_of_command = function
  | Push n -> "Push" ^ string_of_int n
  | Pop -> "Pop"
  | Swap -> "Swap"
  | Add -> "Add"
  | Sub -> "Sub"
  | Mul -> "Mul"
  | Div -> "Div"
  | Rem -> "Rem"
  | Exec -> "Exec"
  | ExecSeq cmds -> "ExecSeq" ^ String.concat " " (List.map string_of_command cmds)
  | Get -> "Get"

let string_of_commands cmds = String.concat " " (List.map string_of_command cmds)

let string_of_program (args, cmds) = Printf.sprintf "%i args: %s\n" args (string_of_commands cmds)


