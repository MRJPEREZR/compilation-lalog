%{
  (* Ocaml code here*)
  (* Exercise 8.1 *)
  open Ast

%}

(**************
 * The tokens *
 **************)

(* enter tokens here, they should begin with %token *)
%token EOF PUSH POP SWAP ADD SUB MUL DIV REM
%token <int> INT


(******************************
 * Entry points of the parser *
 ******************************)

(* enter your %start clause here *)
%start <Ast.program> program

%%

(*************
 * The rules *
 *************)

(* list all rules composing your grammar; obviously your entry point has to be present *)

program: i=INT commands EOF { (i, $2) }

commands:
  | command          {[$1]}
  | command commands {$1 :: $2}

command:
  | PUSH INT {Push $2}
  | POP      {Pop}
  | SWAP     {Swap}
  | ADD      {Add}
  | SUB      {Sub}
  | MUL      {Mul}
  | DIV      {Div}
  | REM      {Rem}

%%
