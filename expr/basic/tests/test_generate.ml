open OUnit2
open BasicExpr.ToPfx
open BasicPfx.Ast
open BasicExpr.Ast
open BasicExpr.Eval

let test_cases = [
  (* 2 + 3 * 4 *)
  (Binop (BinOp.Badd, Const 2, Binop (BinOp.Bmul, Const 3, Const 4)), 
   [Push 2; Push 3; Push 4; Mul; Add], 
   14, "Addition and multiplication");
  
  (* (5 / 1) + (8 * -9) *)
  (Binop(BinOp.Badd, Binop(BinOp.Bdiv, Const 5, Const 1), Binop(BinOp.Bmul, Const 8, Uminus (Const 9))), 
   [Push 1; Push 5; Div; Push 8; Push 9; Push 0; Sub; Mul; Add], 
   -67, "Division, multiplication, and negative number");
  
  (* 10 - 3 *)
  (Binop (BinOp.Bsub, Const 10, Const 3), 
   [Push 3; Push 10; Sub], 
   7, "Subtraction");
  
  (* 6 / 2 *)
  (Binop (BinOp.Bdiv, Const 6, Const 2), 
   [Push 2; Push 6; Div], 
   3, "Division");
  
  (* 8 % 3 *)
  (Binop (BinOp.Bmod, Const 8, Const 3), 
   [Push 3; Push 8; Rem], 
   2, "Modulo operation");
  
  (* (4 - 2) * (7 + 1) *)
  (Binop (BinOp.Bmul, Binop(BinOp.Bsub, Const 4, Const 2), Binop(BinOp.Badd, Const 7, Const 1)), 
   [Push 2; Push 4; Sub; Push 7; Push 1; Add; Mul], 
   16, "Complex expression with multiple operations");
  
  (* -5 * 3 *)
  (Binop (BinOp.Bmul, Uminus(Const 5), Const 3), 
   [Push 5; Push 0; Sub; Push 3; Mul], 
   -15, "Multiplication with a negative number");
]

let generate_tests =
  List.map (fun (expr, expected_pfx, _, name) ->
    name >:: fun _ -> assert_equal expected_pfx (generate expr)
  ) test_cases

let eval_tests =
  List.map (fun (expr, _, expected_eval, name) ->
    name >:: fun _ -> assert_equal expected_eval (eval [] expr)
  ) test_cases

let suite =
  "Eval Tests"
  >::: [
         "Step Tests" >::: generate_tests;
         "Eval Tests" >::: eval_tests;
       ]

let () = run_test_tt_main suite
