(* The type of the commands for the stack machine *)
type value = 
  | Int of int
  | Closure of command list

and  command =
  | Push of int (* Question 4.1, 9.3 and 13.3*)
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
(* The type for programs *)
type program = int * command list

(* Converting a command to a string for printing *)
val string_of_command : command -> string

val string_of_commands: command list -> string

(* Converting a program to a string for printing *)
val string_of_program : program -> string

(* Converting a value to string *)
val string_of_value: value -> string

