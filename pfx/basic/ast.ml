type value = 
  | Int of int
  | Closure of command list

and command =
  | Push of int (* Question 4.1, 9.3 and 13.3 *)
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
  | Append
  | Pushval of value

type program = int * command list

let rec string_of_value = function
  | Int i -> string_of_int i
  | Closure cmds -> string_of_commands cmds

and string_of_command = function
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
  | Append -> "Append"
  | Pushval v -> "PushVal" ^ string_of_value v

and string_of_commands cmds = String.concat " " (List.map string_of_command cmds)

let string_of_program (args, cmds) = Printf.sprintf "%i args: %s\n" args (string_of_commands cmds)