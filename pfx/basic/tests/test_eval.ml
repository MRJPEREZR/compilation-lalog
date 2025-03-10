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