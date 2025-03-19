(* Exercise 11.2 *)
%{
  open Ast
  open BinOp
%}

%token EOF PLUS MINUS TIMES DIV MOD LPAR RPAR
%token <int> INT
%token <string> IDENT
%token FUN RA
%token LET IN EQUAL 

%start < Ast.expression > expression

%right LET  (* Added precedence for let *)
%left FUN
%left PLUS MINUS
%left TIMES DIV MOD
%right UMINUS

%%

expression:
  | e=expr EOF            { e }

expr:
  (* Fixed let expression rule *)
  | LET id=IDENT EQUAL e1=expr IN e2=expr %prec LET { App(Fun(id, e2), e1) }
  | MINUS e=expr %prec UMINUS  { Uminus e }
  | e1=expr o=bop e2=expr      { Binop(o,e1,e2) }
  | e=simple_expr              { e }
  (* Function support *)
  | FUN id=IDENT RA e=expr %prec FUN   { Fun(id,e) }
  | e1=simple_expr e2=simple_expr      { App(e1,e2) }

simple_expr:
  | LPAR e=expr RPAR           { e }
  | id=IDENT                   { Var id }
  | i=INT                      { Const i }

%inline bop:
  | MINUS     { Bsub }
  | PLUS      { Badd }
  | TIMES     { Bmul }
  | DIV       { Bdiv }
  | MOD       { Bmod }
