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
   [Push 1; Push 5; Div; Push 8; Push 9; Push 0; Sub; Mul; Add], 
   Int (-67), "Division, multiplication, and negative number");

  (* (\x. x * 2) 5 *)
  (App(Fun("x", Binop(Bmul, Var "x", Const 2)), Const 5), 
   [Push 5; ExecSeq [Push 0; Get; Push 2; Mul]; Exec], 
   Int 10, "Lambda application with multiplication");
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
