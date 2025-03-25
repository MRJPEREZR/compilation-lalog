AUTHORS
-------
- SOURABIE Kamon
- PEREZ RAMIREZ Julian

## Table of Contents
- [Description of the project](#description-of-the-project)
- [Sources](#sources)
- [How to…](#how-to)
- [Structure of the project](#structure-of-the-project)
- [Progress](#progress)
- [Know bugs and issues](#know-bugs-and-issues)
- [Helpful resources](#helpful-resources)
- [Difficulties](#difficulties)
- [COMPILATION PROJECT QUESTIONS AND ANSWERS](#compilation-project-questions-and-answers)

Description of the project
--------------------------

This μ-project is a very simple compiler. 
It produces a working Expr compiler and a working Pfx virtual machine.

Sources
-------

**Git** **Repository**  
[**https://github.com/MRJPEREZR/compilation-lalog**](https://github.com/MRJPEREZR/compilation-lalog) 

How to…
-------

…retrieve the sources?

  `git clone git@github.com:MRJPEREZR/compilation-lalog.git`

…compile?

**pfxVM**:
  ```
  cd pfx/
  dune build
  ```
**pfx basic evaluator**:
  ```
  cd pfx/basic
  dune build
  ```

**expr compiler**
```
cd expr/
dune build
```

**expr basic pfx generator**
```
cd expr/basic
dune build
```

**expr fun pfx generator**
```
cd expr/fun
dune build
```


…execute and test?

**pfx basic evaluator tests:**
  ```
  cd pfx/basic/tests
  dune build
  dune runtest
  ```
Via CLI:
```
cd pfx/
dune exec ./pfxVM.exe -- basic/tests/ok_prog.pfx
dune exec ./pfxVM.exe -- -a 3 -a 7 -a 2 basic/tests/ok_prog1.pfx
dune exec ./pfxVM.exe -- basic/tests/ok_prog2.pfx 
dune exec ./pfxVM.exe -- basic/tests/ok_prog3.pfx
dune exec ./pfxVM.exe -- basic/tests/error_syntax_prog.pfx
dune exec ./pfxVM.exe -- basic/tests/error_syntax_prog1.pfx
```
- ok_prog.pfx should return: =5
- ok_prog1.pfx should return: =5
- ok_prog2.pfx should return: =10
- ok_prog3.pfx should return: =-67
- error_syntax_prog.pfx should raise an error: Illegal character 'h'
- error_syntax_prog1.pfx should raise an error: Raised error Invalid 
- Operation in state executing Add with stack [1]

**expr basic generator tests:**
```
cd expr/basic/tests
dune build
dune runtest
```
Via CLI:
Uncomment the first part of the compiler.ml file (per dafault it is the content for testing Fun and App support, not the basic one).
```
cd expr/
dune exec ./compiler.exe -- basic/tests/an_example.expr
```

**expr fun generator tests:**
```
cd expr/fun/tests
dune build
dune runtest
```
Via CLI:
```
cd expr/
dune exec ./compiler.exe -- fun/tests/an_example.expr
dune exec ./compiler.exe -- fun/tests/an_example1.expr
dune exec ./compiler.exe -- fun/tests/an_example2.expr
dune exec ./compiler.exe -- fun/tests/an_example3.expr
```
- an_example.expr should return -67
- an_example1.expr should return 3
- an_example2.expr should return 0 (It is a well-know bug to resolve in  question 13)
- an_example3.expr should return 7


Structure of the project
------------------------

The project is organized as follow:
- expr/ folder: An Expr compiler written in OCaml, using ocamllex and menhir.
- pfx/ folder: A Pfx virtual machine written in OCaml, using ocamllex and menhir.
- README.md file: Text plain file explaining our work (answers).
- utils/ folder: An ocaml module helping the parser to find error location.

Either in expr/ and pfx/ folders, there are subfolders that provided different versions and tests depending on the requirements asked along the document.

```
.
├── dune-project
├── expr
│   ├── basic
│   │   ├── ast.ml
│   │   ├── ast.mli
│   │   ├── dune
│   │   ├── eval.ml
│   │   ├── eval.mli
│   │   ├── lexer.mll
│   │   ├── parser.mly
│   │   ├── tests
│   │   │   ├── an_example.expr
│   │   │   ├── dune
│   │   │   └── test_generate.ml
│   │   ├── toPfx.ml
│   │   └── toPfx.mli
│   ├── common
│   │   ├── binOp.ml
│   │   ├── binOp.mli
│   │   └── dune
│   ├── compiler.ml
│   ├── dune
│   ├── fun
│   │   ├── ast.ml
│   │   ├── ast.mli
│   │   ├── dune
│   │   ├── eval.ml
│   │   ├── eval.mli
│   │   ├── lexer.mll
│   │   ├── parser.mly
│   │   ├── tests
│   │   │   ├── an_example1.expr
│   │   │   ├── an_example2.expr
│   │   │   ├── an_example3.expr
│   │   │   ├── an_example.expr
│   │   │   ├── dune
│   │   │   └── test_generate.ml
│   │   ├── toPfx.ml
│   │   └── toPfx.mli
│   ├── main.ml
│   └── README.md
├── pfx
│   ├── basic
│   │   ├── ast.ml
│   │   ├── ast.mli
│   │   ├── dune
│   │   ├── eval.ml
│   │   ├── eval.mli
│   │   ├── lexer.mll
│   │   ├── parser.mly
│   │   └── tests
│   │       ├── dune
│   │       ├── error_syntax_prog1.pfx
│   │       ├── error_syntax_prog.pfx
│   │       ├── ok_prog1.pfx
│   │       ├── ok_prog2.pfx
│   │       ├── ok_prog3.pfx
│   │       ├── ok_prog.pfx
│   │       └── test_eval.ml
│   ├── dune
│   └── pfxVM.ml
├── README.md
└── utils
    ├── dune
    ├── location.ml
    ├── location.mli
    └── README.md
```

Progress
--------

- We stopped at question 12 (proof of derivation of (((λx.λy.(x−y)) 12) 8))


Know bugs and issues
--------------------
- Evaluating this expression (fun x -> (fun y -> x - y) 12 ) 8 should return 4 instead of 0.
This issue is expected to be fix resolving question 13.


Helpful resources
-----------------

- [Opam 101: The First Steps](https://ocamlpro.com/blog/2024_01_23_opam_101_the_first_steps/)
- [Explore the OCaml Documentation](https://ocaml.org/docs)
- [Chapter 17 Lexer and parser generators (ocamllex, ocamlyacc)](https://ocaml.org/manual/5.3/lexyacc.html)
- [Real World OCaml
Functional programming for the masses](https://dev.realworldocaml.org/)


Difficulties
------------
- Thinking functionally: The transition from the object-oriented paradigm to the functional paradigm can be quite difficult at first. However, by reading the documentation and gaining experience over time, it becomes more familiar.
- Compiling the program and understanding Dune—its structure for creating modules (Dune files), defining interfaces (.mli files), and generating executables from .ml files.


COMPILATION PROJECT QUESTIONS AND ANSWERS
------------------------------------------
**Questions**

**Exercise 1 (expl)**  
**What is a stack? What are the operations that you usually execute on a stack?**

In computer science, a stack is an abstract data type that serves as a collection of elements with two main operations:

* Push, which adds an element to the collection, and  
* Pop, which removes the most recently added element.

The order in which an element added to or removed from a stack is described as **last in, first out**, referred to by the acronym **LIFO**. As with a stack of physical objects, this structure makes it easy to take an item off the top of the stack, but accessing data deeper in the stack may require removing multiple other items first.

Source [https://en.wikipedia.org/wiki/Stack\_(abstract\_data\_type)](https://en.wikipedia.org/wiki/Stack_\(abstract_data_type\)) 

**Exercise 2 (expl)**  
**Detail in the same way the execution of *0 push 12 push 7 swap sub***  
***![][image1]***  
**Exercise 3**  
**Question 3.1 (expl):**  
**Explain using plain words the semantics of programs.**  
![][image2]

1) Giving n different arguments to the i expected arguments, then the program will throw an error. In other words, if the program receives a number of arguments (less or more) than expected, it returns an error.  
     
2)  Giving a sequence of instructions Q with stack v1:: … ::vn that after applying a set of rules throws an error, then, in the program execution, we get the same error result passing the n values as arguments.  
     
3) Giving a sequence of instructions Q with stack v1:: … ::vn that after applying a set of rules results in an empty instruction sequence adding the value v to the stack, then, in the program execution, we get the result v passing the same n values as arguments to the sequence of instructions Q. 

**Question 3.2 (math):**  
**A case is still missing, spot it out and give the corresponding rule.**

**![][image3]**  
The missing case is when giving a sequence of instructions Q with stack v1:: ... :: vn that after applying a set of rules results in an empty instruction sequence adding more than one value to the stack, then, in the program execution, we get an error passing the same n values as arguments to the sequence of instructions Q because that program is expected to end with only one value to add to the stack (no more than one).

**Question 3.3 (math):**  
**Give the rules describing the small step semantics for instruction sequences. Beware to cover all cases of runtime errors.**

The list of basic instructions is:

- Push n  
- Pop  
- Swap  
- Add  
- Sub  
- Mul  
- Div  
- Rem

The small step semantic associated with these instructions are:  
![][image4]  
The possible errors that could be found are:

- **For push:** not giving the argument.  
- **For pop:** trying to remove an item from an empty stack.  
- **For swap, add, sub, mul, div and rem:** trying to execute a basic instruction that takes 2 arguments from a stack that is empty or just has 1 element.  
- **For div and rem:** trying to divide by 0\. 

![][image5]

**Exercise 4**  
**Question 4.1 (code):**  
**Propose the OCaml code for a type command describing the Pfx instructions. It should be in the file [pfx/basic/ast.ml](pfx/basic/ast.ml).**

```
type command =  
 | Push of int  
 | Pop  
 | Swap  
 | Add  
 | Sub  
 | Mul  
 | Div  
 | Rem
```
**Question 4.2 (code):**  
**Write an OCaml function step that implements the small step reduction you defined above on Pfx instructions. It should be in the file [pfx/basic/eval.ml](pfx/basic/eval.ml)**
```  
let step state =  
 match state with  
 | [], _ -> Error("Nothing to step", state)  
 (* Valid configurations *)  
 | Push n :: q , stack -> Ok (q, n :: stack)  
 | Pop :: q, _ :: rest -> Ok (q, rest)  
 | Swap :: q, x :: y :: rest -> Ok(q, y :: x :: rest)  
 | Add :: q, x :: y :: rest -> Ok(q, (x + y) :: rest)  
 | Sub :: q, x :: y :: rest -> Ok(q, (x - y) :: rest)  
 | Mul :: q, x :: y :: rest -> Ok(q, (x * y) :: rest)  
 | Div :: q, x :: y :: rest ->  
   if y = 0 then Error("Division by zero", state)  
   else Ok(q, (y / x) :: rest)  
 | Rem :: q, x :: y :: rest ->  
   if y = 0 then Error("Remain by zero", state)  
   else Ok(q, (y mod x) :: rest)  
 | _, _ -> Error("Invalid Operation", state)
```
To test it ([pfx/basic/tests/test_eval.ml](pfx/basic/tests/test_eval.ml)):  
```
open OUnit2
open BasicPfx.Ast
open BasicPfx.Eval 


let step_tests =
 [
   ( "Push command" >:: fun _ ->
     let state = ([ Push 42 ], []) in
     assert_equal (Ok([], [ 42 ])) (step state) );
   ( "Pop command" >:: fun _ ->
     let state = ([ Pop ], [ 1; 2 ]) in
     assert_equal (Ok([], [ 2 ])) (step state) );
   ( "Swap command" >:: fun _ ->
       let state = ([ Swap ], [ 1; 2 ]) in
       assert_equal (Ok([], [ 2; 1 ])) (step state) );
   ( "Add command" >:: fun _ ->
     let state = ([ Add ], [ 1; 2 ]) in
     assert_equal (Ok([], [ 3 ])) (step state) );
   ( "Invalid command" >:: fun _ ->
     let state = ([ Add ], [ 1 ]) in
     assert_equal (Error("Invalid Operation", state)) (step state) );
   ( "Sub command" >:: fun _ ->
     let state = ([ Sub ], [ 1; 2 ]) in
     assert_equal (Ok([], [ -1 ])) (step state) );
   ( "Invalid command" >:: fun _ ->
     let state = ([ Sub ], [ 1 ]) in
     assert_equal (Error("Invalid Operation", state)) (step state) );
   ( "Mul command" >:: fun _ ->
     let state = ([ Mul ], [ 1; 2 ]) in
     assert_equal (Ok([], [ 2 ])) (step state) );
   ( "Invalid command" >:: fun _ ->
     let state = ([ Mul ], [ 1 ]) in
     assert_equal (Error("Invalid Operation", state)) (step state) );
   ( "Div command" >:: fun _ ->
     let state = ([ Div ], [ 6; 2 ]) in
     assert_equal (Ok([], [ 3 ])) (step state) );
   ( "Invalid command" >:: fun _ ->
     let state = ([ Div ], [ 1 ]) in
     assert_equal (Error("Invalid Operation", state)) (step state) );
     ( "Invalid command" >:: fun _ ->
       let state = ([ Div ], [ 1; 0 ]) in
       assert_equal (Error("Division by zero", state)) (step state) );
   ( "Rem command" >:: fun _ ->
     let state = ([ Rem ], [ 6; 2 ]) in
     assert_equal (Ok([], [ 0 ])) (step state) );
   ( "Invalid command" >:: fun _ ->
     let state = ([ Rem ], [ 1 ]) in
     assert_equal (Error("Invalid Operation", state)) (step state) );
   ( "Invalid command" >:: fun _ ->
     let state = ([ Rem ], [ 1; 0 ]) in
     assert_equal (Error("Remain by zero", state)) (step state) );
 ]
let suite =
 "Eval Tests"
 >::: [
        "Step Tests" >::: step_tests;
      ]


(* Run the tests *)
let () = run_test_tt_main suite
```
**Exercise 5**  
**Question 5.1 (math):**  
**Propose a compilation schema of Expr in Pfx. Give its formal description. Notice that with the current definition of Pfx, we cannot implement variables. We defer their implementation to a later exercise.**

Defining *M* as a mapping from variables to memory locations (not implemented yet),  *e* as the expressions in EXPR language, and *Q* as the sequence of Pfx instructions, it is possible define the following compilation rules:   
**![][image6]**

**Question 5.2 (code):**  
**Define a function to generate implementing the semantics you defined in the previous question. It should be in the file [expr/basic/toPfx.ml](expr/basic/toPfx.ml).**
```
open Ast
open BasicPfx.Ast

(* Question 5.2 *)
let rec generate (expr : expression) : command list =
  match expr with
  | Const n -> [Push n]
  | Binop (BinOp.Badd, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code1 @ code2 @ [Add]
  | Binop (BinOp.Bsub, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code2 @ code1 @ [Sub] (* Reverse order *)
  | Binop (BinOp.Bmul, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code1 @ code2 @ [Mul]
  | Binop (BinOp.Bdiv, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code2 @ code1 @ [Div]  (* Reverse order: denominator first *)
  | Binop (BinOp.Bmod, e1, e2) ->
      let code1 = generate e1 in  
      let code2 = generate e2 in  
      code2 @ code1 @ [Rem]  (* Reverse order: denominator first *)
  | Uminus e ->
      let code = generate e in  
      code @ [Push 0; Sub]  
  | Var _ -> failwith "Not yet supported"
```
To test it ([expr/basic/tests/test_generate.ml](expr/basic/tests/test_generate.ml)): 

```  
open OUnit2
open BasicExpr.ToPfx
open BasicPfx.Ast
open BasicExpr.Ast


let expr = Binop (BinOp.Badd, Const 2, Binop (BinOp.Bmul, Const 3, Const 4))
let pfx_code = generate expr


let step_tests =
 [
   "Generated code for expression" >:: (fun _ ->
     let expected = [Push 2; Push 3; Push 4; Mul; Add] in
     assert_equal expected pfx_code
   );
 ]
let suite =
 "Eval Tests"
 >::: [
        "Step Tests" >::: step_tests;
      ]


let () = run_test_tt_main suite
```
It is also possible test it from the terminal:  
**![][image7]**  
**Question 6.1 (code):**  
**Write a lexer for the Pfx stack machine language. Complete the provided lexer.mll of pfx/basic. To test it without the parser, have a look at Moodle at the file simple\_expr\_lexer\_standalone.mll**

Following the instruction to avoid using and declaring the parser, this is how the lexer.mll ([pfx/basic/lexer.mll](pfx/basic/lexer.mll)) could be completed it:
```
{
 (*Question 6.1*)
  (*open Parser*)


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
  let mk_int nb =
   try INT (int_of_string nb)
   with Failure _ -> failwith (Printf.sprintf "Illegal integer '%s': " nb)
}


let newline = (['\n' '\r'] | "\r\n")
let blank = [' ' '\014' '\t' '\012']
let not_newline_char = [^ '\n' '\r']
let digit = ['0'-'9']


rule token = parse
 (* newlines *)
 | newline { token lexbuf }
 (* blanks *)
 | blank + { token lexbuf }
 (* end of file *)
 | eof      { EOF }
 (* comments *)
 | "--" not_newline_char*  { token lexbuf }
 (* integers *)
 | digit+ as nb           { mk_int nb }
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
 | _ as c                  { failwith (Printf.sprintf "Illegal character '%c': " c) }


{
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
   examine_all lexbuf;
   print_newline ();
   close_in (input_file)
 with Sys_error _ ->
   print_endline ("Can't find file '" ^ file ^ "'")


 let _ = Arg.parse [] compile ""
}
```
It can be tested using *utop* after compile lexer.mll by running ocamllex lexer.mll to get the lexer.ml file:  
![][image8]  
**Question 6.2 (code):**  
**Reuse this code to be able to parse a file containing a Pfx program and print all the tokens encountered in the process.**

We are going to comment the current content in the file pfxVM.ml ([pfx/pfxVM.ml](pfx/pfxVM.ml)) to add this lines:
```
open BasicPfx.Lexer
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
 examine_all lexbuf;
 print_newline ();
 close_in (input_file)
with Sys_error _ ->
 print_endline ("Can't find file '" ^ file ^ "'")


let _ = Arg.parse [] compile ""
```
Being in pfx/, we can use it to test our lexer module passing the following expression:  
*0 push 2 push 7 push 3 add div \-- 5 (*It is declared in the ok\_prog.pfx file*)*  
![][image9]

**Exercise 7 (Locating errors, code)**  
Modify your code from the previous exercise to be able to return the location of errors.  
Modifications in lexer.mll([pfx/basic/lexer.mll](/pfx/basic/lexer.mll)):  
```
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
 | newline { token lexbuf }
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
```

Modifications in pfxVM.ml([pfx/pfxVM.ml](pfx/pfxVM.ml)) to test it:
```  
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
```
The content of the file error\_syntax\_prog.pfx is:  
*0 push 4 push**h** 2  \-- error*  
![][image10]

**Exercise 8 (A first Pfx parser)**  
**Question 8.1 (code):**  
**Write a parser for the Pfx stack machine language.**

The parser code is ([pfx/basic/parser.mly](pfx/basic/parser.mly)):  
```
%{
 open Ast
%}
%token EOF PUSH POP SWAP ADD SUB MUL DIV REM
%token <int> INT


%start <Ast.program> program


%%


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
```
**Question 8.2 (code):**  
**Test it in combination with your Lexer. To do it, you will have to write a function that prints the AST of Pfx. You should now use the provided file pfx/pfxVM.ml as the main file for the Pfx virtual machine. It filters every argument of the form \-a integer and adds to the argument list (args). A dune file is also provided.**

**Notice that it requires that you modify your lexer slightly to remove the main functions and replace the token type definition by an open of the parser module.**

The pfxVM.ml ([pfx/pfxVM.ml](pfx/pfxVM.ml)) code is:
```  
open BasicPfx
open Utils


let args = ref []


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


let _ =
 let register_arg i = args := !args@[i] in
 Arg.parse ["-a", Arg.Int register_arg,"integer argument"] parse_eval ""
```
To test manually the pfxVM, in the terminal using the command:  
**dune exec ./pfxVM.exe \-- \-a 7 \-a 3 \-a 2  basic/tests/ok\_prog1.pfx**  
With the ok\_prog.pfx as follow: *3 add div*  
It returns 5:  
![][image11]  
     
Now, if it added a syntax error, the pfxVM.ml is also able to show the error location:  
*3 add divv \-- 5 if passing -a 3 -a 7 -a 2*  
*![][image12]*

**Exercise 9**  
**Question 9.1 (expl):**  
**Do we need to change the rules for the already defined constructs?**

Not at all, but we have to define 3 new rules to deal with these 3 instruction sequences added. The semantic definition of these rules is shown in the following point.

**Question 9.2 (math):**  
**Give the formal semantics of these new constructions.**  
**![][image13]**

**Question 9.3 (code):**  
**If needed, extend the lexer and parser of Pfx to include these changes.**

Yes, it is required to add the declaration of these new 3 instructions as well as change the stack type because currently the stack accepts just int values, but adding the Exes Seq, it also has to accept a list of instruction sequences. 

So, we modify the lexer.mll, parser.mly, ast.ml and eval.ml modules

The lexer.mll ([pfx/basic/lexer.mll](pfx/basic/lexer.mll)) content is:
```  
open Parser


open Utils.Location


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
  | EXEC   -> print_string "EXEC"
  | GET    -> print_string "GET"
  | LBRACE -> print_string "LBRACE"
  | RBRACE -> print_string "RBRACE"
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
| "exec"                 { EXEC }
| "get"                  { GET }
| "{"                    { LBRACE }
| "}"                    { RBRACE }
(* illegal characters *)
| _ as c                 {
  let loc = curr lexbuf in
    raise (Error (Printf.sprintf "Illegal character '%c'" c, loc))
    }
```
The parser.mly ([pfx/basic/parser.mly](pfx/basic/parser.mly)) content is:
```  
%{
 (* Ocaml code here*)
 (* Exercise 8.1 *)
 open Ast


%}


(**************
* The tokens *
**************)


(* enter tokens here, they should begin with %token *)
%token EOF PUSH POP SWAP ADD SUB MUL DIV REM EXEC GET LBRACE RBRACE
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
 | EXEC     { Exec }
 | GET      { Get }
 | LBRACE commands RBRACE { ExecSeq $2 }


%%

```
The ast.ml ([pfx/basic/ast.ml](pfx/basic/ast.ml)) content is: 
``` 
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
```
The eval.ml ([pfx/basic/eval.ml](pfx/basic/eval.ml)) content is:

```  
open Ast
open Printf


(* Question 9.3 *)
type value =
 | Int of int
 | ExecSeq of Ast.command list
let string_of_value = function
 | Int i -> string_of_int i
 | ExecSeq cmds -> string_of_commands cmds


let string_of_stack stack = sprintf "[%s]" (String.concat ";" (List.map string_of_value stack))


let string_of_state (cmds, stack) =
 (match cmds with
  | [] -> "no command"
  | cmd::_ -> sprintf "executing %s" (string_of_command cmd))^
   (sprintf " with stack %s" (string_of_stack stack))


(* Question 4.2 and 9.3 *)
let step state =
 match state with
 | [], _ -> Error("Nothing to step", state)
 (* Valid configurations *)
 | Push n :: q , stack -> Ok (q, Int n :: stack)
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
 | Exec :: q, ExecSeq cmds :: rest -> Ok (cmds @ q, rest)
 | Get :: q, Int i :: rest ->
     if i < 0 || i >= List.length rest then
       Error("Invalid index for Get", state)
     else
       let elem = List.nth rest i in
       Ok (q, elem :: rest)
 | ExecSeq cmds :: q, stack -> Ok (q, ExecSeq cmds :: stack)
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
   | Ok (Some (ExecSeq _)) -> printf "= <executable sequence>\n"
   | Error(msg,s) -> printf "Raised error %s in state %s\n" msg (string_of_state s)
 else printf "Raised error \nMismatch between expected and actual number of args\n"
```
To test, it is added 2 new unit cases ([pfx/basic/tests/test_eval.ml](pfx/basic/tests/test_eval.ml)):
```
( "Test Exec" >:: fun _ ->
     let state = ([Exec], [ExecSeq [Push 20; Add]]) in
     let expected = Ok ([Push 20; Add], []) in
     assert_equal expected (step state));
    ("Test Get" >:: fun _ ->
     let state = ([Get], int_stack [1; 10; 20]) in
     let expected = Ok ([], [Int 20; Int 10; Int 20]) in
     assert_equal expected (step state));
```
**Exercise 10**  
**Question 10.1 (expl):**  
**Give the compiled version of the expression (λx.x \+ 1\) 2\. Then describe step by step the evaluation of its Pfx translation.**

The compiled expression and how to evaluate is explained as follow:  
**![][image14]**

**Question 10.2 (math):**  
**Give the formal rule for transformation.**  
It is required to add 2 new rules: one for functions and another one for applications.  
**![][image15]**  
**Question 10.3 (code):**  
**Provide a new version of generate.**

The new version for generate is ([expr/fun/toPfx.ml](expr/fun/toPfx.ml)):
```
open Ast
open BasicPfx.Ast

(* Question 10.3 *)
let rec generate env (expr : expression) : command list =
    match expr with
    | Const n -> [Push n]
    | Var x -> 
        (try 
           [Push (List.assoc x env); Get] 
         with Not_found -> failwith ("Unbound variable: " ^ x))
    | Binop (BinOp.Badd, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code1 @ code2 @ [Add]
    | Binop (BinOp.Bsub, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code2 @ code1 @ [Sub] (* Reverse order *)
    | Binop (BinOp.Bmul, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code1 @ code2 @ [Mul]
    | Binop (BinOp.Bdiv, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code2 @ code1 @ [Div]  (* Reverse order: denominator first *)
    | Binop (BinOp.Bmod, e1, e2) ->
        let code1 = generate env e1 in  
        let code2 = generate env e2 in  
        code2 @ code1 @ [Rem]  (* Reverse order: denominator first *)
    | Uminus e ->
        let code = generate env e in  
        code @ [Push 0; Sub]  
    | App(e1, e2) ->
        let code2 = generate env e2 in  
        let code1 = generate env e1 in  
        code2 @ code1 @ [Exec] 
    | Fun(x, e) ->
        let new_env = (x, List.length env) :: env in
        [ExecSeq (generate new_env e)]
  
```
To test it via terminal, it was required to edit also the **eval.ml ([expr/fun/eval.ml](expr/fun/eval.ml))**, **toPfx.ml** and the **compiler.ml.**  

The result of testing the content file: *(fun x \-\> x \+ 1\) 2* was 3 as expected.  
**![][image16]**

Also, we added unit test ([expr/fun/tests/test_generate.ml](expr/fun/tests/test_generate.ml)) for **eval.ml** and **generate.ml:** 
```
open OUnit2
open FunExpr.ToPfx
open BasicPfx.Ast
open FunExpr.Ast
open FunExpr.Eval


(* Test expression: 2 + (3 * 4) *)
let expr = Binop (BinOp.Badd, Const 2, Binop (BinOp.Bmul, Const 3, Const 4))
let pfx_code = generate [] expr
let result = eval [] expr


(* Test expression: (λx.x + 1) 2 *)
let expr2 = App(Fun("x", Binop(Badd, Var "x", Const 1)), Const 2)


(* Generate Pfx code from the expression *)
let pfx_code2 = generate [] expr2
let result2 = eval [] expr2


let generate_tests =
 [
   "Generated code for expression" >:: (fun _ ->
     let expected = [Push 2; Push 3; Push 4; Mul; Add] in
     assert_equal expected pfx_code
   );
  
   "Generated code for (λx.x + 1) 2" >:: (fun _ ->
     let expected = [Push 2; ExecSeq [Push 0; Get; Push 1; Add]; Exec] in
     assert_equal expected pfx_code2
   );
 ]
let eval_tests =
 [
   "Evaluate expression" >:: (fun _ ->
     let expected = Int 14 in
     assert_equal expected result
   );
   "Evaluate expression" >:: (fun _ ->
     let expected = Int 3 in
     assert_equal expected result2
   );
 ]
let suite =
 "Eval Tests"
 >::: [
        "Generate Tests" >::: generate_tests;
        "Eval Tests" >::: eval_tests;
      ]


let () = run_test_tt_main suite 
```

**Question 10.4 (expl):**  
**Give the compiled version of the expression ((λx.λy.(x − y)) 12\) 8\. Then describe step by step the evaluation of its Pfx translation. What do you think of the result? What is happening?**

The compiled version of this expression is:   
**![][image17]**

The evaluating process is:  
**![][image18]**  
According to this, we get an incorrect result to be fixed in the next questions.  
This is possible to replicate via terminal executing:  
 *(fun x \-\> (fun y \-\> x \- y) 12 ) 8*:  
![][image19] 

**Exercise 11 (Syntactic sugar)**  
**Question 11.1 (expl):**  
**What is the translation in the syntax of Expr already defined for a new let x = e1 in e2 ?**

The syntactic sugar translation is explained below:  
**![][image20]**  
Example:  
let x = 5 in x + 2 is translated to (fun x -> x + 2) 5  
 

**Question 11.2 (code):**  
**What part of the code must be modified to get support for let? Give the modifications.**

Initially, It is required to extend the lexer to recognize the new tokens “let”, “=” and “in” as well as the parser to give its meaning.  

It is important to place let at the top to give it the important precedence and also declaring the right associative property. 

The new parser.mly ([expr/fun/parser.mly](expr/fun/parser.mly)) contents is:
```
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
```
The new lexer.mll ([expr/fun/lexer.mll](expr/fun/lexer.mll)) content is:
```
(* Exercise 11.2 *)
{
 open Parser
 open Utils


 let mk_int nb loc =
   try INT (int_of_string nb)
   with Failure _ -> raise (Location.Error(Printf.sprintf "Illegal integer '%s': " nb,loc))
}


let newline = (['\n' '\r'] | "\r\n")
let blank = [' ' '\014' '\t' '\012']
let not_newline_char = [^ '\n' '\r']
let digit = ['0'-'9']
let integer = digit+
let letter = ['a'-'z' 'A'-'Z']
let ident = letter (letter | digit | '_')*


rule token = parse
 (* newlines *)
 | newline { Location.incr_line lexbuf; token lexbuf }
 (* blanks *)
 | blank + { token lexbuf }
 (* end of file *)
 | eof      { EOF }
 (* comments *)
 | "--" not_newline_char*  { token lexbuf }
 (* integers *)
 | integer as nb           { mk_int nb (Location.curr lexbuf)}
 (* commands *)
 | "+"      { PLUS }
 | "-"      { MINUS }
 | "/"      { DIV }
 | "*"      { TIMES }
 | "%"      { MOD }
 | "("      { LPAR }
 | ")"      { RPAR }
 (* For function support *)
 | "fun"    { FUN }
 | "->"     { RA }
 (* New tokens for let expressions *)
 | "let"    { LET }
 | "in"     { IN }
 | "="      { EQUAL }
 (* identifiers *)
 | ident as id { IDENT id }
 (* illegal characters *)
 | _ as c  { raise (Location.Error(Printf.sprintf "Illegal character '%c': " c, Location.curr lexbuf)) }  
```

Testing manually from terminal the sugar syntax of this application:  
let x = 5 in x + 2  
![][image21]

**Exercise 12 (math)**  
**Give the proof derivation computing the value of the term of question 10.4 (((λx.λy.(x−y)) 12\) 8).**

The proof derivation computing is presenting below:   
**![][image22]**  
**![][image23]**

[image1]: images/image1.png
[image2]: images/image2.png
[image3]: images/image3.png
[image4]: images/image4.png
[image5]: images/image5.png
[image6]: images/image6.png
[image7]: images/image7.png
[image8]: images/image8.png
[image9]: images/image9.png
[image10]: images/image10.png
[image11]: images/image11.png
[image12]: images/image12.png
[image13]: images/image13.png
[image14]: images/image14.png
[image15]: images/image15.png
[image16]: images/image16.png
[image17]: images/image17.png
[image18]: images/image18.png
[image19]: images/image19.png
[image20]: images/image20.png
[image21]: images/image21.png
[image22]: images/image22.png
[image23]: images/image23.png



