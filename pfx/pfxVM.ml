(* Entry point of the program, should contain your main function: here it is
 named parse_eval, it is the function provided after question 6.1 *)

 (* Exercise 8.2 *)
 open BasicPfx
 open Utils

(* The arguments, initially empty *)
let args = ref []

(* The main function *)
let parse_eval file =
  print_string ("File "^file^" is being treated!\n");
  try
    let input_file = open_in file in
    let lexbuf = Lexing.from_channel input_file in
    Location.init lexbuf file;
    begin
      try
        let pfx_prog = Parser.program Lexer.token lexbuf in
          Eval.eval_program pfx_prog !args
      with 
        | Parser.Error -> print_string "Syntax error"
        | Location.Error (msg, loc) ->
            Location.print loc;
            print_endline msg
    end;
    close_in (input_file)
  with Sys_error _ -> print_endline ("Can't find file '" ^ file ^ "'")

(* Here we add the parsing of the command line and link to the main function *)
let _ =
  (* function to register arguments *)
  let register_arg i = args := !args@[Eval.Int i] in
  (* each option -a INTEGER is considered as an argument *)
  Arg.parse ["-a", Arg.Int register_arg,"integer argument"] parse_eval ""

