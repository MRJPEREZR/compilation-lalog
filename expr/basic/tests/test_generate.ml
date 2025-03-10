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