open OUnit2
open BasicExpr.ToPfx
open BasicPfx.Ast
open BasicExpr.Ast
open BasicExpr.Eval

(* 2 + 3 * 4 *)
let expr = Binop (BinOp.Badd, Const 2, Binop (BinOp.Bmul, Const 3, Const 4))
let pfx_code = generate expr
let result = eval [] expr

let expr1 = Binop(BinOp.Badd, Binop(BinOp.Bdiv, Const 5, Const 1), Binop(BinOp.Bmul, Const 8, Uminus (Const 9) ))
let pfx_code1 = generate expr1
let result1 = eval [] expr1

let step_tests =
  [
    "Generated code for expression" >:: (fun _ -> 
      let expected = [Push 2; Push 3; Push 4; Mul; Add] in
      assert_equal expected pfx_code
    );
    "Generated code for expression" >:: (fun _ -> 
      let expected = [Push 1; Push 5; Div ; Push 8; Push 9; Push 0; Sub; Mul; Add] in
      assert_equal expected pfx_code1
    ); 
  ]

let eval_tests =
  [
    "Evaluate expression" >:: (fun _ -> 
      let expected = 14 in
      assert_equal expected result
    ); 
    "Evaluate expression" >:: (fun _ -> 
      let expected =  -67 in
      assert_equal expected result1
    ); 
  ]
let suite =
  "Eval Tests"
  >::: [
         "Step Tests" >::: step_tests;
         "Eval Tests" >::: eval_tests;
       ]

let () = run_test_tt_main suite