open OUnit2
open BasicPfx.Ast
open BasicPfx.Eval  

let int_stack lst = List.map (fun x -> Int x) lst

let step_tests =
  [
    ( "Push command" >:: fun _ ->
      let state = ([ Push 42 ], []) in
      assert_equal (Ok([], [ Int 42 ])) (step state) );
    ( "Pop command" >:: fun _ ->
      let state = ([ Pop ], int_stack [ 1; 2 ]) in
      assert_equal (Ok([], [ Int 2 ])) (step state) );
    ( "Swap command" >:: fun _ ->
        let state = ([ Swap ], int_stack [ 1; 2 ]) in
        assert_equal (Ok([], [ Int 2; Int 1 ])) (step state) );
    ( "Add command" >:: fun _ ->
      let state = ([ Add ], int_stack [ 1; 2 ]) in
      assert_equal (Ok([], [ Int 3 ])) (step state) );
    ( "Invalid command" >:: fun _ ->
      let state = ([ Add ], int_stack [ 1 ]) in
      assert_equal (Error("Invalid Operation", state)) (step state) );
    ( "Sub command" >:: fun _ ->
      let state = ([ Sub ], int_stack [ 1; 2 ]) in
      assert_equal (Ok([], [ Int (-1) ])) (step state) );
    ( "Invalid command" >:: fun _ ->
      let state = ([ Sub ], int_stack [ 1 ]) in
      assert_equal (Error("Invalid Operation", state)) (step state) );
    ( "Mul command" >:: fun _ ->
      let state = ([ Mul ], int_stack [ 1; 2 ]) in
      assert_equal (Ok([], [ Int 2 ])) (step state) );
    ( "Invalid command" >:: fun _ ->
      let state = ([ Mul ], int_stack [ 1 ]) in
      assert_equal (Error("Invalid Operation", state)) (step state) );
    ( "Div command" >:: fun _ ->
      let state = ([ Div ], int_stack [ 6; 2 ]) in
      assert_equal (Ok([], [ Int 3 ])) (step state) );
    ( "Invalid command" >:: fun _ ->
      let state = ([ Div ], int_stack [ 1 ]) in
      assert_equal (Error("Invalid Operation", state)) (step state) );
      ( "Invalid command" >:: fun _ ->
        let state = ([ Div ], int_stack [ 1; 0 ]) in
        assert_equal (Error("Division by zero", state)) (step state) );
    ( "Rem command" >:: fun _ ->
      let state = ([ Rem ], int_stack [ 6; 2 ]) in
      assert_equal (Ok([], [ Int 0 ])) (step state) );
    ( "Invalid command" >:: fun _ ->
      let state = ([ Rem ], int_stack [ 1 ]) in
      assert_equal (Error("Invalid Operation", state)) (step state) );
    ( "Invalid command" >:: fun _ ->
      let state = ([ Rem ], int_stack [ 1; 0 ]) in
      assert_equal (Error("Remain by zero", state)) (step state) );
    ( "Test Exec" >:: fun _ ->
      let state = ([Exec], [ExecSeq [Push 20; Add]]) in
      let expected = Ok ([Push 20; Add], []) in
      assert_equal expected (step state));
     ("Test Get" >:: fun _ -> 
      let state = ([Get], int_stack [1; 10; 20]) in
      let expected = Ok ([], [Int 20; Int 10; Int 20]) in
      assert_equal expected (step state));
  ]
let suite =
  "Eval Tests"
  >::: [
         "Step Tests" >::: step_tests;
       ]

(* Run the tests *)
let () = run_test_tt_main suite