{
  (*Question 6.1*)
  
  (*open Parser*)

  open Utils.Location

  type token = EOF | INT of int | PUSH | POP | SWAP | ADD | SUB | MUL | DIV | REM

  let print_token = function 
    | EOF    -> print_string "EOF"
    | INT i  -> print_int i
    | PUSH   -> print_string "PUSH"
    | POP    -> print_string "POP"
    | SWAP   -> print_string "SWAP"
    | ADD    -> print_string "ADD"
    | SUB    -> print_string "SUB"
    | MUL    -> print_string "MUL"
    | DIV    -> print_string "DIV"
    | REM    -> print_string "REM"
  
  let mk_int nb lexbuf =
    try INT (int_of_string nb)
    with Failure _ -> 
      let loc = curr lexbuf in
        raise (Error(Printf.sprintf "Illegal integer '%s'" nb, loc))
} 

let newline = (['\n' '\r'] | "\r\n")
let blank = [' ' '\014' '\t' '\012']
let not_newline_char = [^ '\n' '\r']
let digit = ['0'-'9']

rule token = parse
  (* newlines *)
  | newline { token lexbuf } (* add incr_line lexbuf if you want to read multiple lines*)
  (* blanks *)
  | blank + { token lexbuf }
  (* end of file *)
  | eof      { EOF }
  (* comments *)
  | "--" not_newline_char*  { token lexbuf }
  (* integers *)
  | digit+ as nb           { mk_int nb lexbuf}
  (* commands  *)
  | "push"                 { PUSH }
  | "pop"                  { POP }
  | "swap"                 { SWAP }
  | "add"                  { ADD }
  | "sub"                  { SUB }
  | "mul"                  { MUL }
  | "div"                  { DIV }
  | "rem"                  { REM }
  (* illegal characters *)
  | _ as c                 {
    let loc = curr lexbuf in
      raise (Error (Printf.sprintf "Illegal character '%c'" c, loc))
      }