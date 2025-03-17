(* The type of the commands for the stack machine *)
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
(* The type for programs *)
type program = int * command list

(* Converting a command to a string for printing *)
val string_of_command : command -> string

val string_of_commands: command list -> string

(* Converting a program to a string for printing *)
val string_of_program : program -> string

