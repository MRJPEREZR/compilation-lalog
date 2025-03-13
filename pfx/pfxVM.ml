(* (* Entry point of the program, should contain your main function: here it is
 named parse_eval, it is the function provided after question 6.1 *)
open BasicPfx

(* The arguments, initially empty *)
let args = ref []

(* The main function *)
let parse_eval file =
  print_string ("File "^file^" is being treated!\n");
  try
    let input_file = open_in file in
    let lexbuf = Lexing.from_channel input_file in
    begin
      try
        let pfx_prog = Parser.program Lexer.token lexbuf in
         Eval.eval_program pfx_prog !args
      with Parser.Error -> print_string "Syntax error"
    end;
    close_in (input_file)
  with Sys_error _ -> print_endline ("Can't find file '" ^ file ^ "'")

(* Here we add the parsing of the command line and link to the main function *)
let _ =
  (* function to register arguments *)
  let register_arg i = args := !args@[i] in
  (* each option -a INTEGER is considered as an argument *)
  Arg.parse ["-a",Arg.Int register_arg,"integer argument"] parse_eval "" *)

open BasicPfx.Lexer
open Utils.Location

let rec examine_all lexbuf =
  let result = token lexbuf in
  print_token result;
  print_string " ";
  match result with
  | EOF -> ()
  | _   -> examine_all lexbuf

let compile file =
  print_string ("File "^file^" is being treated!\n");
  try
    let input_file = open_in file in
    let lexbuf = Lexing.from_channel input_file in
    init lexbuf file;
    try
      examine_all lexbuf;
      print_newline ();
      close_in (input_file)
    with
    | Error (msg, loc) ->
      print loc;
      print_endline msg;
      close_in (input_file)
  with Sys_error _ ->
    print_endline ("Can't find file '" ^ file ^ "'")

let _ = Arg.parse [] compile ""
