type token =
  | EOF
  | INT of (Range.t * int32)
  | X of (Range.t)
  | PLUS of (Range.t)
  | TIMES of (Range.t)
  | DIGIT of (Range.t)
  | MINUS of (Range.t)
  | OR of (Range.t)
  | SHL of (Range.t)
  | SHR of (Range.t)
  | SAR of (Range.t)
  | LT of (Range.t)
  | LTE of (Range.t)
  | GT of (Range.t)
  | GTE of (Range.t)
  | EQ of (Range.t)
  | NEQ of (Range.t)
  | AND of (Range.t)
  | NEG of (Range.t)
  | LOGNOT of (Range.t)
  | NOT of (Range.t)
  | LPAREN of (Range.t)
  | RPAREN of (Range.t)
  | SPACE of (Range.t)

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
open Ast;;
# 32 "parser.ml"
let yytransl_const = [|
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* X *);
  259 (* PLUS *);
  260 (* TIMES *);
  261 (* DIGIT *);
  262 (* MINUS *);
  263 (* OR *);
  264 (* SHL *);
  265 (* SHR *);
  266 (* SAR *);
  267 (* LT *);
  268 (* LTE *);
  269 (* GT *);
  270 (* GTE *);
  271 (* EQ *);
  272 (* NEQ *);
  273 (* AND *);
  274 (* NEG *);
  275 (* LOGNOT *);
  276 (* NOT *);
  277 (* LPAREN *);
  278 (* RPAREN *);
  279 (* SPACE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\003\000\004\000\004\000\005\000\005\000\
\005\000\006\000\006\000\006\000\006\000\006\000\007\000\007\000\
\007\000\007\000\008\000\008\000\008\000\009\000\009\000\010\000\
\010\000\010\000\010\000\011\000\011\000\011\000\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\001\000\003\000\001\000\003\000\003\000\
\001\000\003\000\003\000\003\000\003\000\001\000\003\000\003\000\
\003\000\001\000\003\000\003\000\001\000\003\000\001\000\002\000\
\002\000\002\000\001\000\001\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\028\000\029\000\000\000\000\000\000\000\000\000\
\031\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\023\000\027\000\024\000\025\000\026\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\030\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\022\000"

let yydgoto = "\002\000\
\009\000\010\000\011\000\012\000\013\000\014\000\015\000\016\000\
\017\000\018\000\019\000"

let yysindex = "\255\255\
\005\255\000\000\000\000\000\000\005\255\005\255\005\255\005\255\
\000\000\012\000\007\255\023\255\015\255\253\254\019\255\010\255\
\039\255\000\000\000\000\000\000\000\000\000\000\251\254\000\000\
\005\255\005\255\005\255\005\255\005\255\005\255\005\255\005\255\
\005\255\005\255\005\255\005\255\005\255\005\255\000\000\023\255\
\015\255\253\254\253\254\019\255\019\255\019\255\019\255\010\255\
\010\255\010\255\039\255\039\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\044\000\015\000\161\000\170\000\111\000\051\000\
\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\032\000\
\186\000\173\000\184\000\123\000\135\000\147\000\159\000\067\000\
\083\000\099\000\018\000\035\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\037\000\021\000\022\000\006\000\246\255\004\000\
\005\000\254\255\000\000"

let yytablesize = 464
let yytable = "\001\000\
\021\000\025\000\020\000\021\000\022\000\003\000\004\000\029\000\
\030\000\031\000\032\000\024\000\036\000\025\000\004\000\037\000\
\039\000\019\000\044\000\045\000\046\000\047\000\005\000\006\000\
\007\000\008\000\033\000\034\000\035\000\027\000\028\000\003\000\
\042\000\043\000\020\000\053\000\048\000\049\000\050\000\026\000\
\051\000\052\000\038\000\002\000\023\000\040\000\000\000\041\000\
\000\000\000\000\018\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\015\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\016\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\017\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\014\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\010\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\011\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\012\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\013\000\000\000\
\006\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\009\000\000\000\000\000\008\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\007\000\
\000\000\005\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\021\000\000\000\000\000\021\000\021\000\
\021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
\021\000\021\000\000\000\000\000\019\000\004\000\021\000\019\000\
\019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
\019\000\019\000\019\000\000\000\004\000\020\000\003\000\019\000\
\020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
\020\000\020\000\020\000\020\000\000\000\003\000\000\000\000\000\
\020\000\018\000\018\000\018\000\018\000\018\000\018\000\018\000\
\018\000\018\000\018\000\018\000\000\000\000\000\000\000\000\000\
\018\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
\015\000\015\000\015\000\015\000\000\000\000\000\000\000\000\000\
\015\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
\016\000\016\000\016\000\016\000\000\000\000\000\000\000\000\000\
\016\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
\017\000\017\000\017\000\017\000\000\000\014\000\000\000\000\000\
\017\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
\000\000\010\000\000\000\000\000\014\000\010\000\010\000\010\000\
\010\000\010\000\010\000\010\000\000\000\011\000\000\000\000\000\
\010\000\011\000\011\000\011\000\011\000\011\000\011\000\011\000\
\000\000\012\000\000\000\000\000\011\000\012\000\012\000\012\000\
\012\000\012\000\012\000\012\000\000\000\013\000\000\000\006\000\
\012\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
\009\000\006\000\000\000\008\000\013\000\000\000\006\000\000\000\
\009\000\009\000\009\000\008\000\008\000\008\000\007\000\009\000\
\005\000\000\000\008\000\000\000\000\000\000\000\007\000\007\000\
\007\000\000\000\005\000\000\000\000\000\007\000\000\000\005\000"

let yycheck = "\001\000\
\000\000\007\001\005\000\006\000\007\000\001\001\002\001\011\001\
\012\001\013\001\014\001\000\000\003\001\007\001\000\000\006\001\
\022\001\000\000\029\000\030\000\031\000\032\000\018\001\019\001\
\020\001\021\001\008\001\009\001\010\001\015\001\016\001\000\000\
\027\000\028\000\000\000\038\000\033\000\034\000\035\000\017\001\
\036\000\037\000\004\001\000\000\008\000\025\000\255\255\026\000\
\255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\000\000\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\000\000\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\000\000\255\255\
\000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\000\000\255\255\255\255\000\000\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\000\000\
\255\255\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\003\001\255\255\255\255\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\255\255\255\255\003\001\007\001\022\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\255\255\022\001\003\001\007\001\022\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\022\001\255\255\255\255\
\022\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\255\255\255\255\255\255\
\022\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\255\255\255\255\255\255\
\022\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\255\255\255\255\255\255\
\022\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\007\001\255\255\255\255\
\022\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\255\255\007\001\255\255\255\255\022\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\007\001\255\255\255\255\
\022\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\255\255\007\001\255\255\255\255\022\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\007\001\255\255\007\001\
\022\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\007\001\017\001\255\255\007\001\022\001\255\255\022\001\255\255\
\015\001\016\001\017\001\015\001\016\001\017\001\007\001\022\001\
\007\001\255\255\022\001\255\255\255\255\255\255\015\001\016\001\
\017\001\255\255\017\001\255\255\255\255\022\001\255\255\022\001"

let yynames_const = "\
  EOF\000\
  "

let yynames_block = "\
  INT\000\
  X\000\
  PLUS\000\
  TIMES\000\
  DIGIT\000\
  MINUS\000\
  OR\000\
  SHL\000\
  SHR\000\
  SAR\000\
  LT\000\
  LTE\000\
  GT\000\
  GTE\000\
  EQ\000\
  NEQ\000\
  AND\000\
  NEG\000\
  LOGNOT\000\
  NOT\000\
  LPAREN\000\
  RPAREN\000\
  SPACE\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 39 "parser.mly"
            ( _1 )
# 268 "parser.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'A1) in
    Obj.repr(
# 44 "parser.mly"
       ( _1 )
# 275 "parser.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A1) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A2) in
    Obj.repr(
# 47 "parser.mly"
             (Binop (Or, _1, _3))
# 284 "parser.ml"
               : 'A1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'A2) in
    Obj.repr(
# 48 "parser.mly"
       ( _1 )
# 291 "parser.ml"
               : 'A1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A2) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A3) in
    Obj.repr(
# 50 "parser.mly"
              (Binop (And, _1, _3))
# 300 "parser.ml"
               : 'A2))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'A3) in
    Obj.repr(
# 51 "parser.mly"
       ( _1 )
# 307 "parser.ml"
               : 'A2))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A3) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A4) in
    Obj.repr(
# 53 "parser.mly"
              (Binop (Neq, _1, _3))
# 316 "parser.ml"
               : 'A3))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A3) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A4) in
    Obj.repr(
# 54 "parser.mly"
             (Binop (Eq, _1, _3) )
# 325 "parser.ml"
               : 'A3))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'A4) in
    Obj.repr(
# 55 "parser.mly"
       ( _1 )
# 332 "parser.ml"
               : 'A3))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A4) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A5) in
    Obj.repr(
# 57 "parser.mly"
             (Binop (Lt, _1, _3) )
# 341 "parser.ml"
               : 'A4))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A4) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A5) in
    Obj.repr(
# 58 "parser.mly"
              (Binop (Lte, _1, _3) )
# 350 "parser.ml"
               : 'A4))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A4) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A5) in
    Obj.repr(
# 59 "parser.mly"
             (Binop (Gt, _1, _3) )
# 359 "parser.ml"
               : 'A4))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A4) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A5) in
    Obj.repr(
# 60 "parser.mly"
              (Binop (Gte, _1, _3) )
# 368 "parser.ml"
               : 'A4))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'A5) in
    Obj.repr(
# 61 "parser.mly"
       ( _1 )
# 375 "parser.ml"
               : 'A4))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A5) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A6) in
    Obj.repr(
# 63 "parser.mly"
              (Binop (Shl, _1, _3) )
# 384 "parser.ml"
               : 'A5))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A5) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A6) in
    Obj.repr(
# 64 "parser.mly"
              (Binop (Shr, _1, _3) )
# 393 "parser.ml"
               : 'A5))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A5) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A6) in
    Obj.repr(
# 65 "parser.mly"
              (Binop (Sar, _1, _3) )
# 402 "parser.ml"
               : 'A5))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'A6) in
    Obj.repr(
# 66 "parser.mly"
       ( _1 )
# 409 "parser.ml"
               : 'A5))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A6) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A7) in
    Obj.repr(
# 68 "parser.mly"
               (Binop (Plus, _1, _3) )
# 418 "parser.ml"
               : 'A6))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A6) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A7) in
    Obj.repr(
# 69 "parser.mly"
                (Binop (Minus, _1, _3) )
# 427 "parser.ml"
               : 'A6))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'A7) in
    Obj.repr(
# 70 "parser.mly"
       ( _1 )
# 434 "parser.ml"
               : 'A6))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'A7) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'A8) in
    Obj.repr(
# 72 "parser.mly"
                (Binop (Times, _1, _3) )
# 443 "parser.ml"
               : 'A7))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'A8) in
    Obj.repr(
# 73 "parser.mly"
       ( _1 )
# 450 "parser.ml"
               : 'A7))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'A8) in
    Obj.repr(
# 75 "parser.mly"
           (Unop (Neg, _2) )
# 458 "parser.ml"
               : 'A8))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'A8) in
    Obj.repr(
# 76 "parser.mly"
              (Unop (Lognot, _2) )
# 466 "parser.ml"
               : 'A8))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Range.t) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'A8) in
    Obj.repr(
# 77 "parser.mly"
           (Unop (Not, _2) )
# 474 "parser.ml"
               : 'A8))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'A9) in
    Obj.repr(
# 78 "parser.mly"
       ( _1 )
# 481 "parser.ml"
               : 'A8))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Range.t * int32) in
    Obj.repr(
# 80 "parser.mly"
        (Cint (snd _1) )
# 488 "parser.ml"
               : 'A9))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Range.t) in
    Obj.repr(
# 81 "parser.mly"
        ( Arg )
# 495 "parser.ml"
               : 'A9))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Range.t) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'A1) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Range.t) in
    Obj.repr(
# 82 "parser.mly"
                     ( _2 )
# 504 "parser.ml"
               : 'A9))
(* Entry toplevel *)
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
let toplevel (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.exp)