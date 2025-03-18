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