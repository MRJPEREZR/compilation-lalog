open OUnit2
open FunExpr.ToPfx
open BasicPfx.Ast
open FunExpr.Ast
open FunExpr.Eval

let test_cases = [
  (* 2 + (3 * 4) *)
  (Binop (BinOp.Badd, Const 2, Binop (BinOp.Bmul, Const 3, Const 4)), 
   [Push 2; Push 3; Push 4; Mul; Add], 
   Int 14, "Addition and multiplication");
  
  (* (\x. x + 1) 2 *)
  (App(Fun("x", Binop(Badd, Var "x", Const 1)), Const 2), 
   [Push 2; ExecSeq [Push 0; Get; Push 1; Add]; Exec], 
   Int 3, "Lambda application");
  
  (* (5 / 1) + (8 * -9) *)
  (Binop(BinOp.Badd, Binop(BinOp.Bdiv, Const 5, Const 1), Binop(BinOp.Bmul, Const 8, Uminus (Const 9))), 
   [Push 5; Push 1; Swap; Div; Push 8; Push 9; Push 0; Sub; Mul; Add], 
   Int (-67), "Division, multiplication, and negative number");

  (* (\x. x * 2) 5 *)
  (App(Fun("x", Binop(Bmul, Var "x", Const 2)), Const 5), 
   [Push 5; ExecSeq [Push 0; Get; Push 2; Mul]; Exec], 
   Int 10, "Lambda application with multiplication");

  (* (\x. x - 2) 5 *)
  (App(Fun("x", Binop(Bsub, Var "x", Const 2)), Const 5), 
  [Push 5; ExecSeq [Push 0; Get; Push 2; Swap; Sub]; Exec], 
  Int 3, "Lambda application with substraction");

  (* (\x. x % 2) 6 *)
  (App(Fun("x", Binop(Bmod, Var "x", Const 2)), Const 6), 
  [Push 6; ExecSeq [Push 0; Get; Push 2; Swap; Rem]; Exec], 
  Int 0, "Lambda application with remain");

  (* (\x. x / 2) 6 *)
  (App(Fun("x", Binop(Bdiv, Var "x", Const 2)), Const 6), 
  [Push 6; ExecSeq [Push 0; Get; Push 2; Swap; Div]; Exec], 
  Int 3, "Lambda application with division");

  (* Identity function: (\x. x) 42 *)
  (App(Fun("x", Var "x"), Const 42), 
  [Push 42; ExecSeq [Push 0; Get]; Exec], 
  Int 42, "Identity function");

  (* Constant only: -(-5) *)
  (Uminus(Uminus(Const 5)), 
  [Push 5; Push 0; Sub; Push 0; Sub], 
  Int 5, "Double negation");

  (* (\x. -x) 4 *)
  (App(Fun("x", Uminus(Var "x")), Const 4), 
  [Push 4; ExecSeq [Push 0; Get; Push 0; Sub]; Exec], 
  Int (-4), "Lambda with unary minus");
]

let generate_tests =
  List.map (fun (expr, expected_pfx, _, name) ->
    name >:: fun _ -> assert_equal expected_pfx (generate [] expr)
  ) test_cases

let eval_tests =
  List.map (fun (expr, _, expected_eval, name) ->
    name >:: fun _ -> assert_equal expected_eval (eval [] expr)
  ) test_cases

let suite =
  "Eval Tests"
  >::: [
         "Generate Tests" >::: generate_tests;
         "Eval Tests" >::: eval_tests;
       ]

let () = run_test_tt_main suite
