AUTHORS
-------
- SOURABIE Kamon
- PEREZ RAMIREZ Julian

Description of the project
--------------------------

This μ-project is a very simple compiler. 
It produces a working Expr compiler and a working Pfx virtual machine.


Sources
-------

Git repository: https://gitlab-df.imt-atlantique.fr/j23perez1/compilation-lalog/-/tree/master

How to…
-------

…retrieve the sources?

  `git clone https://gitlab-df.imt-atlantique.fr/j23perez1/compilation-lalog/-/tree/master`

…compile?

  `dune build`

…execute and test?

  `dune exec ./pfxVM.exe -- -a 3 -a 7 -a 2 pfx/basic/tests/ok_prog1.pfx`


Structure of the project
------------------------

The project is organized as following:


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
