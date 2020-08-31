type token =
  | NEWLINE
  | EOF
  | LPAREN
  | RPAREN
  | EQ
  | PLUS
  | MINUS
  | MUL
  | AND
  | OR
  | NUM of (int)
  | VAR of (string)
  | A
  | D
  | M
  | MD
  | AM
  | AD
  | AMD
  | AT
  | ONE
  | ZERO
  | BANG
  | COLON
  | SEMI
  | JGT
  | JEQ
  | JGE
  | JLT
  | JNE
  | JLE
  | JMP

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
    open Syntax
    open Support
    
    exception ALUError


    let symboltbl:tbl = Hashtbl.create 1024 
    let reserved = [
    ("SP", 0);
    ("LCL", 1);
    ("ARG", 2);
    ("THIS", 3);("THAT", 4); 
    ("R0", 0);("R1", 1);("R2", 2);("R3", 3);("R4", 4);
    ("R5", 5);("R6", 6);("R7", 7);("R8", 8);("R9", 9);
    ("R10",10);("R11",11);("R12",12);("R13",13);("R14",14);("R15",15);
    ("SCREEN", 16384);
    ("KBD", 24576)
    ]
    let _ = List.iter (fun (s,i)-> Hashtbl.add symboltbl s i) reserved 

    let line = ref 0
    let incr_line () = incr line 
    let decr_line () = decr line 


# 64 "parser.ml"
let yytransl_const = [|
  257 (* NEWLINE *);
    0 (* EOF *);
  258 (* LPAREN *);
  259 (* RPAREN *);
  260 (* EQ *);
  261 (* PLUS *);
  262 (* MINUS *);
  263 (* MUL *);
  264 (* AND *);
  265 (* OR *);
  268 (* A *);
  269 (* D *);
  270 (* M *);
  271 (* MD *);
  272 (* AM *);
  273 (* AD *);
  274 (* AMD *);
  275 (* AT *);
  276 (* ONE *);
  277 (* ZERO *);
  278 (* BANG *);
  279 (* COLON *);
  280 (* SEMI *);
  281 (* JGT *);
  282 (* JEQ *);
  283 (* JGE *);
  284 (* JLT *);
  285 (* JNE *);
  286 (* JLE *);
  287 (* JMP *);
    0|]

let yytransl_block = [|
  266 (* NUM *);
  267 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\004\000\004\000\004\000\
\004\000\004\000\008\000\008\000\006\000\009\000\009\000\009\000\
\009\000\009\000\009\000\009\000\007\000\010\000\010\000\010\000\
\010\000\010\000\005\000\005\000\005\000\005\000\005\000\005\000\
\005\000\005\000\011\000\011\000\011\000\012\000\012\000\000\000"

let yylen = "\002\000\
\001\000\001\000\002\000\001\000\002\000\002\000\002\000\003\000\
\002\000\003\000\001\000\001\000\002\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\002\000\001\000\001\000\001\000\
\001\000\001\000\001\000\002\000\002\000\003\000\003\000\003\000\
\003\000\003\000\001\000\001\000\001\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\004\000\002\000\000\000\000\000\039\000\035\000\
\037\000\036\000\023\000\024\000\025\000\026\000\000\000\000\000\
\040\000\001\000\000\000\000\000\000\000\000\000\000\000\000\000\
\027\000\000\000\038\000\028\000\012\000\011\000\009\000\029\000\
\003\000\005\000\000\000\006\000\000\000\000\000\021\000\000\000\
\000\000\000\000\000\000\000\000\010\000\014\000\015\000\016\000\
\017\000\018\000\019\000\020\000\013\000\008\000\030\000\031\000\
\032\000\033\000\034\000"

let yydgoto = "\002\000\
\017\000\018\000\019\000\020\000\021\000\036\000\022\000\031\000\
\053\000\023\000\027\000\025\000"

let yysindex = "\004\000\
\001\000\000\000\000\000\000\000\252\254\017\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\012\255\034\255\
\000\000\000\000\001\000\018\255\241\254\254\254\024\255\008\255\
\000\000\029\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\014\255\000\000\241\254\008\255\000\000\017\255\
\017\255\017\255\017\255\017\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\032\255\001\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\030\000\000\000\000\000\028\000\014\000\000\000\000\000\
\000\000\000\000\002\000\250\255"

let yytablesize = 279
let yytable = "\028\000\
\004\000\038\000\024\000\006\000\001\000\022\000\026\000\007\000\
\035\000\008\000\009\000\010\000\040\000\041\000\042\000\043\000\
\044\000\032\000\034\000\016\000\024\000\029\000\030\000\038\000\
\038\000\038\000\007\000\039\000\008\000\009\000\010\000\045\000\
\007\000\055\000\056\000\057\000\058\000\059\000\046\000\047\000\
\048\000\049\000\050\000\051\000\052\000\008\000\009\000\010\000\
\033\000\037\000\054\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\003\000\005\000\000\000\000\000\000\000\006\000\000\000\
\000\000\000\000\007\000\000\000\008\000\009\000\010\000\011\000\
\012\000\013\000\014\000\015\000\000\000\000\000\016\000"

let yycheck = "\006\000\
\000\000\001\001\001\000\006\001\001\000\004\001\011\001\010\001\
\024\001\012\001\013\001\014\001\005\001\006\001\007\001\008\001\
\009\001\016\000\001\001\022\001\019\000\010\001\011\001\022\000\
\024\001\024\001\010\001\004\001\012\001\013\001\014\001\003\001\
\001\001\040\000\041\000\042\000\043\000\044\000\025\001\026\001\
\027\001\028\001\029\001\030\001\031\001\012\001\013\001\014\001\
\019\000\022\000\037\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\001\001\002\001\255\255\255\255\255\255\006\001\255\255\
\255\255\255\255\010\001\255\255\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\255\255\255\255\022\001"

let yynames_const = "\
  NEWLINE\000\
  EOF\000\
  LPAREN\000\
  RPAREN\000\
  EQ\000\
  PLUS\000\
  MINUS\000\
  MUL\000\
  AND\000\
  OR\000\
  A\000\
  D\000\
  M\000\
  MD\000\
  AM\000\
  AD\000\
  AMD\000\
  AT\000\
  ONE\000\
  ZERO\000\
  BANG\000\
  COLON\000\
  SEMI\000\
  JGT\000\
  JEQ\000\
  JGE\000\
  JLT\000\
  JNE\000\
  JLE\000\
  JMP\000\
  "

let yynames_block = "\
  NUM\000\
  VAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'file) in
    Obj.repr(
# 53 "parser.mly"
                                ( _1,symboltbl )
# 275 "parser.ml"
               : Syntax.commands * Support.tbl))
; (fun __caml_parser_env ->
    Obj.repr(
# 55 "parser.mly"
                                ( []                 )
# 281 "parser.ml"
               : 'file))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'line) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'file) in
    Obj.repr(
# 56 "parser.mly"
                                ( List.append _2 _1  )
# 289 "parser.ml"
               : 'file))
; (fun __caml_parser_env ->
    Obj.repr(
# 59 "parser.mly"
                                ( []    )
# 295 "parser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'command) in
    Obj.repr(
# 60 "parser.mly"
                                ( (* let L(l) = $2 in pi l;pn(); *) [_1]  )
# 302 "parser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'comp) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'jump) in
    Obj.repr(
# 63 "parser.mly"
                                ( incr_line(); C_COMMAND([],_1,_2) )
# 310 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'dest) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'comp) in
    Obj.repr(
# 64 "parser.mly"
                                ( incr_line(); C_COMMAND(_1,_2,NULL) )
# 318 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'dest) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'comp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'jump) in
    Obj.repr(
# 65 "parser.mly"
                                ( incr_line(); C_COMMAND(_1, _2, _3) )
# 327 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'symbol) in
    Obj.repr(
# 66 "parser.mly"
                                ( incr_line(); A_COMMAND(_2) )
# 334 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 67 "parser.mly"
                                ( add symboltbl _2 !line; L_COMMAND(_2) )
# 341 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 70 "parser.mly"
                                ( VAR(_1)  )
# 348 "parser.ml"
               : 'symbol))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 71 "parser.mly"
                                ( ADDR(_1) )
# 355 "parser.ml"
               : 'symbol))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'jjj) in
    Obj.repr(
# 74 "parser.mly"
                                ( _2  )
# 362 "parser.ml"
               : 'jump))
; (fun __caml_parser_env ->
    Obj.repr(
# 76 "parser.mly"
                                ( JGT )
# 368 "parser.ml"
               : 'jjj))
; (fun __caml_parser_env ->
    Obj.repr(
# 77 "parser.mly"
                                ( JEQ )
# 374 "parser.ml"
               : 'jjj))
; (fun __caml_parser_env ->
    Obj.repr(
# 78 "parser.mly"
                                ( JGE )
# 380 "parser.ml"
               : 'jjj))
; (fun __caml_parser_env ->
    Obj.repr(
# 79 "parser.mly"
                                ( JLT )
# 386 "parser.ml"
               : 'jjj))
; (fun __caml_parser_env ->
    Obj.repr(
# 80 "parser.mly"
                                ( JNE )
# 392 "parser.ml"
               : 'jjj))
; (fun __caml_parser_env ->
    Obj.repr(
# 81 "parser.mly"
                                ( JLE )
# 398 "parser.ml"
               : 'jjj))
; (fun __caml_parser_env ->
    Obj.repr(
# 82 "parser.mly"
                                ( JMP )
# 404 "parser.ml"
               : 'jjj))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'regs) in
    Obj.repr(
# 85 "parser.mly"
                                ( _1 )
# 411 "parser.ml"
               : 'dest))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'reg) in
    Obj.repr(
# 87 "parser.mly"
                                ( [_1]      )
# 418 "parser.ml"
               : 'regs))
; (fun __caml_parser_env ->
    Obj.repr(
# 88 "parser.mly"
                                ( [M;D]     )
# 424 "parser.ml"
               : 'regs))
; (fun __caml_parser_env ->
    Obj.repr(
# 89 "parser.mly"
                                ( [A;M]     )
# 430 "parser.ml"
               : 'regs))
; (fun __caml_parser_env ->
    Obj.repr(
# 90 "parser.mly"
                                ( [A;D]     )
# 436 "parser.ml"
               : 'regs))
; (fun __caml_parser_env ->
    Obj.repr(
# 91 "parser.mly"
                                ( [A;M;D]   )
# 442 "parser.ml"
               : 'regs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'regOI) in
    Obj.repr(
# 95 "parser.mly"
                                ( REG(_1)                   )
# 449 "parser.ml"
               : 'comp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'regOI) in
    Obj.repr(
# 96 "parser.mly"
                                ( UMINUS(_2)                )
# 456 "parser.ml"
               : 'comp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'reg) in
    Obj.repr(
# 97 "parser.mly"
                                ( NOT(_2)                   )
# 463 "parser.ml"
               : 'comp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'reg) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'regOI) in
    Obj.repr(
# 98 "parser.mly"
                                ( PLUS(_1, _3)              )
# 471 "parser.ml"
               : 'comp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'reg) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'regOI) in
    Obj.repr(
# 99 "parser.mly"
                                ( MINUS(_1,_3)              )
# 479 "parser.ml"
               : 'comp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'reg) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'regOI) in
    Obj.repr(
# 100 "parser.mly"
                                ( MUL(_1,_3)                )
# 487 "parser.ml"
               : 'comp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'reg) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'regOI) in
    Obj.repr(
# 101 "parser.mly"
                                ( AND(_1,_3)                )
# 495 "parser.ml"
               : 'comp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'reg) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'regOI) in
    Obj.repr(
# 102 "parser.mly"
                                ( OR(_1,_3)                 )
# 503 "parser.ml"
               : 'comp))
; (fun __caml_parser_env ->
    Obj.repr(
# 105 "parser.mly"
                                ( A                         )
# 509 "parser.ml"
               : 'reg))
; (fun __caml_parser_env ->
    Obj.repr(
# 106 "parser.mly"
                                ( M                         )
# 515 "parser.ml"
               : 'reg))
; (fun __caml_parser_env ->
    Obj.repr(
# 107 "parser.mly"
                                ( D                         )
# 521 "parser.ml"
               : 'reg))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'reg) in
    Obj.repr(
# 110 "parser.mly"
                                ( _1                        )
# 528 "parser.ml"
               : 'regOI))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 111 "parser.mly"
                                ( if _1=0 then ZERO else if _1=1 then ONE else raise ALUError )
# 535 "parser.ml"
               : 'regOI))
(* Entry input *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let input (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Syntax.commands * Support.tbl)
