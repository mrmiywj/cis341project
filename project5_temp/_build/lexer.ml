# 1 "lexer.mll"
 
  open Lexing
  open Parser
  open Range
  
  exception Lexer_error of Range.t * string

  let pos_of_lexpos (p:Lexing.position) : pos =
    mk_pos (p.pos_lnum) (p.pos_cnum - p.pos_bol)
    
  let mk_lex_range (p1:Lexing.position) (p2:Lexing.position) : Range.t =
    mk_range p1.pos_fname (pos_of_lexpos p1) (pos_of_lexpos p2)

  let lex_range lexbuf : Range.t = mk_lex_range (lexeme_start_p lexbuf)
      (lexeme_end_p lexbuf)

  let reset_lexbuf (filename:string) (lnum:int) lexbuf : unit =
    lexbuf.lex_curr_p <- {
      pos_fname = filename;
      pos_cnum = 0;
      pos_bol = 0;
      pos_lnum = lnum;
    }

  let newline lexbuf =
    lexbuf.lex_curr_p <- { (lexeme_end_p lexbuf) with
      pos_lnum = (lexeme_end_p lexbuf).pos_lnum + 1;
      pos_bol = (lexeme_end lexbuf) }
    
  (* Boilerplate to define exceptional cases in the lexer. *)
  let unexpected_char lexbuf (c:char) : 'a =
    raise (Lexer_error (lex_range lexbuf,
        Printf.sprintf "Unexpected character: '%c'" c))

  (* Lexing reserved words *)
  let reserved_words = [
  (* Keywords *)
  ("null", fun i -> NULL i);
  ("true", fun i -> TRUE i);
  ("false", fun i -> FALSE i);
  ("unit", fun i -> TUNIT i);
  ("bool", fun i -> TBOOL i);
  ("int", fun i -> TINT i);
  ("string", fun i -> TSTRING i);
  ("else", fun i -> ELSE i);
  ("if?", fun i -> IFNULL i);
  ("if", fun i -> IF i);
  ("cast", fun i -> CAST i);
  ("this", fun i -> THIS i);
  ("super", fun i -> SUPER i);
  ("fail", fun i -> FAIL i);
  ("for", fun i -> FOR i);
  ("while", fun i -> WHILE i);
  ("return", fun i -> RETURN i);
  ("new", fun i -> NEW i);
  ("fun", fun i -> FUN i);
  ("class", fun i -> CLASS i);
  ("extern", fun i -> EXTERN i);

  (* Symbols *)
  ( ";", fun i -> SEMI i);
  ( ",", fun i -> COMMA i);
  ( "{", fun i -> LBRACE i);
  ( "}", fun i -> RBRACE i);
  ( "+", fun i -> PLUS i);
  ( "-", fun i -> DASH i);
  ( "*", fun i -> STAR i);
  ( "=", fun i -> EQ i);
  ( "==", fun i -> EQEQ i);
  ( "<<", fun i -> LTLT i);
  ( ">>", fun i -> GTGT i);
  ( ">>>", fun i -> GTGTGT i);
  ( "!=", fun i -> BANGEQ i);
  ( "<", fun i -> LT i);
  ( "<=", fun i -> LTEQ i);
  ( ">", fun i -> GT i);
  ( ">=", fun i -> GTEQ i);
  ( "!", fun i -> BANG i);
  ( "~", fun i -> TILDE i);
  ( "&", fun i -> AMPER i);
  ( "|", fun i -> BAR i);
  ( "[&]", fun i -> IAND i);
  ( "[|]", fun i -> IOR i);
  ( "(", fun i -> LPAREN i);
  ( ")", fun i -> RPAREN i);
  ( "[", fun i -> LBRACKET i);
  ( "]", fun i -> RBRACKET i);
  ( "->", fun i -> ARROW i);
  ( "<:", fun i -> EXTEND i);
  ( ".", fun i -> DOT i);
  ( "?", fun i -> QUESTION i);
  ]

  type build_fun = Range.t -> Parser.token
  let (symbol_table : (string, build_fun) Hashtbl.t) = Hashtbl.create 1024
  let _ =
    List.iter (fun (str,f) -> Hashtbl.add symbol_table str f) reserved_words

  let create_token lexbuf =
    let str = lexeme lexbuf in 
    let r = lex_range lexbuf in
    try (Hashtbl.find symbol_table str) r 
    with _ -> IDENT (r, str)

  (* Lexing comments and strings *)
  let string_buffer = ref (String.create 2048)
  let string_end = ref 0
  let start_lex = ref (Range.start_of_range Range.norange)

  let start_pos_of_lexbuf lexbuf : pos =
    (pos_of_lexpos (lexeme_start_p lexbuf))

  let lex_long_range lexbuf : Range.t =
    let end_p = lexeme_end_p lexbuf in
    mk_range end_p.pos_fname (!start_lex) (pos_of_lexpos end_p)  

  let reset_str () = string_end := 0

  let add_str ch =
    let x = !string_end in
    let buffer = !string_buffer
    in
      if x = String.length buffer then
        begin
          let new_buffer = String.create (x*2) in
          String.blit buffer 0 new_buffer 0 x;
          String.set new_buffer x ch;
          string_buffer := new_buffer;
          string_end := x+1
        end
      else
        begin
          String.set buffer x ch;
          string_end := x+1
        end

  let get_str () = String.sub (!string_buffer) 0 (!string_end)

  (* Lexing directives *)
  let lnum = ref 1

# 144 "lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\245\255\246\255\020\000\003\000\033\000\069\000\031\000\
    \034\000\001\000\247\255\005\000\083\000\097\000\121\000\196\000\
    \015\001\252\255\253\255\086\000\255\255\254\255\090\001\165\001\
    \188\001\079\000\049\000\050\000\003\002\251\255\002\000\252\255\
    \253\255\107\000\007\000\064\001\251\255\252\255\253\255\123\000\
    \119\000\255\255\254\255\213\001\251\255\252\255\253\255\254\255\
    \255\255\027\002\249\255\225\001\251\255\252\255\253\255\254\255\
    \255\255\246\001\250\255";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\009\000\009\000\009\000\009\000\009\000\
    \009\000\008\000\255\255\007\000\006\000\006\000\005\000\004\000\
    \004\000\255\255\255\255\010\000\255\255\255\255\004\000\255\255\
    \006\000\009\000\255\255\255\255\255\255\255\255\003\000\255\255\
    \255\255\001\000\000\000\255\255\255\255\255\255\255\255\002\000\
    \002\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\006\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\255\255\000\000\000\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\029\000\000\000\255\255\000\000\
    \000\000\255\255\255\255\038\000\000\000\000\000\000\000\255\255\
    \255\255\000\000\000\000\044\000\000\000\000\000\000\000\000\000\
    \000\000\050\000\000\000\255\255\000\000\000\000\000\000\000\000\
    \000\000\255\255\000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\011\000\010\000\010\000\031\000\009\000\011\000\000\000\
    \034\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \011\000\004\000\018\000\017\000\000\000\011\000\002\000\034\000\
    \002\000\002\000\002\000\002\000\002\000\008\000\002\000\019\000\
    \013\000\012\000\012\000\012\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\026\000\002\000\006\000\007\000\005\000\002\000\
    \002\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\003\000\002\000\002\000\002\000\025\000\
    \002\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\016\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\002\000\002\000\002\000\002\000\002\000\
    \021\000\002\000\002\000\012\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\012\000\012\000\012\000\002\000\002\000\002\000\
    \027\000\012\000\012\000\012\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\012\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\042\000\041\000\000\000\
    \000\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\000\000\000\000\000\000\000\000\
    \014\000\023\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\000\000\000\000\
    \020\000\000\000\000\000\000\000\000\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\000\000\
    \000\000\000\000\000\000\015\000\000\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\000\000\037\000\000\000\000\000\000\000\000\000\000\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\040\000\000\000\000\000\000\000\015\000\039\000\
    \015\000\015\000\015\000\015\000\015\000\022\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\000\000\000\000\000\000\000\000\
    \000\000\002\000\000\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\000\000\000\000\000\000\
    \000\000\015\000\000\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\024\000\046\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\000\000\048\000\
    \000\000\000\000\000\000\000\000\000\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\000\000\000\000\000\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\034\000\031\000\000\000\000\000\
    \030\000\057\000\057\000\057\000\057\000\057\000\057\000\057\000\
    \057\000\057\000\057\000\000\000\000\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\034\000\000\000\032\000\058\000\058\000\
    \058\000\058\000\058\000\058\000\058\000\058\000\058\000\058\000\
    \000\000\047\000\000\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\053\000\000\000\000\000\
    \036\000\000\000\052\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\054\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\056\000\000\000\000\000\000\000\000\000\000\000\055\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\045\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\009\000\030\000\000\000\011\000\255\255\
    \034\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\000\000\000\000\255\255\011\000\000\000\034\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\003\000\000\000\000\000\000\000\000\000\000\000\
    \004\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\007\000\000\000\005\000\005\000\
    \008\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\006\000\
    \019\000\006\000\006\000\012\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\012\000\012\000\012\000\025\000\026\000\027\000\
    \003\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\039\000\040\000\255\255\
    \255\255\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\255\255\255\255\255\255\255\255\
    \014\000\013\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\255\255\
    \255\255\255\255\255\255\015\000\255\255\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\255\255\035\000\255\255\255\255\255\255\255\255\255\255\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\035\000\255\255\255\255\255\255\016\000\035\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\255\255\255\255\255\255\255\255\
    \255\255\022\000\255\255\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\255\255\255\255\255\255\
    \255\255\022\000\255\255\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\023\000\023\000\023\000\
    \023\000\023\000\023\000\023\000\023\000\023\000\023\000\043\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\023\000\023\000\
    \023\000\023\000\023\000\023\000\024\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\255\255\043\000\
    \255\255\255\255\255\255\255\255\255\255\024\000\024\000\024\000\
    \024\000\024\000\024\000\255\255\255\255\255\255\023\000\023\000\
    \023\000\023\000\023\000\023\000\028\000\028\000\255\255\255\255\
    \028\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\255\255\255\255\024\000\024\000\024\000\
    \024\000\024\000\024\000\028\000\255\255\028\000\057\000\057\000\
    \057\000\057\000\057\000\057\000\057\000\057\000\057\000\057\000\
    \255\255\043\000\255\255\028\000\028\000\028\000\028\000\028\000\
    \028\000\028\000\028\000\028\000\028\000\049\000\255\255\255\255\
    \035\000\255\255\049\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\049\000\049\000\049\000\049\000\049\000\
    \049\000\049\000\049\000\049\000\049\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\049\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\049\000\255\255\255\255\255\255\255\255\255\255\049\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\043\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\028\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\049\000";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec token lexbuf =
    __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 153 "lexer.mll"
        ( EOF )
# 396 "lexer.ml"

  | 1 ->
# 155 "lexer.mll"
         ( start_lex := start_pos_of_lexbuf lexbuf; comments 0 lexbuf )
# 401 "lexer.ml"

  | 2 ->
# 156 "lexer.mll"
        ( reset_str(); start_lex := start_pos_of_lexbuf lexbuf; string false lexbuf )
# 406 "lexer.ml"

  | 3 ->
# 157 "lexer.mll"
        ( let p = lexeme_start_p lexbuf in
          if p.pos_cnum - p.pos_bol = 0 then directive 0 lexbuf 
          else raise (Lexer_error (lex_long_range lexbuf,
            Printf.sprintf "# can only be the 1st char in a line.")) )
# 414 "lexer.ml"

  | 4 ->
# 162 "lexer.mll"
                                         ( create_token lexbuf )
# 419 "lexer.ml"

  | 5 ->
# 164 "lexer.mll"
    ( CIDENT (lex_range lexbuf, lexeme lexbuf) )
# 424 "lexer.ml"

  | 6 ->
# 165 "lexer.mll"
                            ( INT (lex_range lexbuf, (Int32.of_string (lexeme lexbuf))) )
# 429 "lexer.ml"

  | 7 ->
# 166 "lexer.mll"
                ( token lexbuf )
# 434 "lexer.ml"

  | 8 ->
# 167 "lexer.mll"
            ( newline lexbuf; token lexbuf )
# 439 "lexer.ml"

  | 9 ->
# 172 "lexer.mll"
    ( create_token lexbuf )
# 444 "lexer.ml"

  | 10 ->
let
# 174 "lexer.mll"
         c
# 450 "lexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 174 "lexer.mll"
           ( unexpected_char lexbuf c )
# 454 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and directive state lexbuf =
    __ocaml_lex_directive_rec state lexbuf 28
and __ocaml_lex_directive_rec state lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 177 "lexer.mll"
                ( directive state lexbuf )
# 466 "lexer.ml"

  | 1 ->
# 178 "lexer.mll"
           ( if state = 0 then 
               (lnum := int_of_string (lexeme lexbuf); 
                directive 1 lexbuf)
             else if state = 2 then directive 3 lexbuf
             else raise (Lexer_error (lex_long_range lexbuf,
               Printf.sprintf "Illegal directives")) )
# 476 "lexer.ml"

  | 2 ->
# 184 "lexer.mll"
        ( if state = 1 then
            begin
              reset_str(); 
              start_lex := start_pos_of_lexbuf lexbuf; 
              string true lexbuf
            end 
          else raise (Lexer_error (lex_long_range lexbuf,
            Printf.sprintf "Illegal directives")) 
         )
# 489 "lexer.ml"

  | 3 ->
# 193 "lexer.mll"
            ( if state = 2 or state = 3 then
                begin 
                  reset_lexbuf (get_str()) !lnum lexbuf;
                  token lexbuf
                end 
              else raise (Lexer_error (lex_long_range lexbuf,
                Printf.sprintf "Illegal directives")) )
# 500 "lexer.ml"

  | 4 ->
# 200 "lexer.mll"
      ( raise (Lexer_error (lex_long_range lexbuf, 
          Printf.sprintf "Illegal directives")) )
# 506 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_directive_rec state lexbuf __ocaml_lex_state

and comments level lexbuf =
    __ocaml_lex_comments_rec level lexbuf 35
and __ocaml_lex_comments_rec level lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 204 "lexer.mll"
         ( if level = 0 then token lexbuf
	   else comments (level-1) lexbuf )
# 519 "lexer.ml"

  | 1 ->
# 206 "lexer.mll"
         ( comments (level+1) lexbuf)
# 524 "lexer.ml"

  | 2 ->
# 207 "lexer.mll"
             ( comments level lexbuf )
# 529 "lexer.ml"

  | 3 ->
# 208 "lexer.mll"
         ( newline lexbuf; comments level lexbuf )
# 534 "lexer.ml"

  | 4 ->
# 209 "lexer.mll"
         ( raise (Lexer_error (lex_long_range lexbuf,
             Printf.sprintf "comments are not closed")) )
# 540 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_comments_rec level lexbuf __ocaml_lex_state

and string in_directive lexbuf =
    __ocaml_lex_string_rec in_directive lexbuf 43
and __ocaml_lex_string_rec in_directive lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 213 "lexer.mll"
         ( if in_directive = false then
             STRING (lex_long_range lexbuf, get_str())
           else directive 2 lexbuf )
# 554 "lexer.ml"

  | 1 ->
# 216 "lexer.mll"
         ( add_str(escaped lexbuf); string in_directive lexbuf )
# 559 "lexer.ml"

  | 2 ->
# 217 "lexer.mll"
         ( add_str '\n'; newline lexbuf; string in_directive lexbuf )
# 564 "lexer.ml"

  | 3 ->
# 218 "lexer.mll"
         ( raise (Lexer_error (lex_long_range lexbuf,
             Printf.sprintf "String is not terminated")) )
# 570 "lexer.ml"

  | 4 ->
# 220 "lexer.mll"
         ( add_str (Lexing.lexeme_char lexbuf 0); string in_directive lexbuf )
# 575 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_string_rec in_directive lexbuf __ocaml_lex_state

and escaped lexbuf =
    __ocaml_lex_escaped_rec lexbuf 49
and __ocaml_lex_escaped_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 223 "lexer.mll"
           ( '\n' )
# 587 "lexer.ml"

  | 1 ->
# 224 "lexer.mll"
           ( '\t' )
# 592 "lexer.ml"

  | 2 ->
# 225 "lexer.mll"
           ( '\\' )
# 597 "lexer.ml"

  | 3 ->
# 226 "lexer.mll"
           ( '\034'  )
# 602 "lexer.ml"

  | 4 ->
# 227 "lexer.mll"
           ( '\'' )
# 607 "lexer.ml"

  | 5 ->
# 229 "lexer.mll"
    (
      let x = int_of_string(lexeme lexbuf) in
      if x > 255 then
        raise (Lexer_error (lex_long_range lexbuf,
          (Printf.sprintf "%s is an illegal escaped character constant" (lexeme lexbuf))))
      else
        Char.chr x
    )
# 619 "lexer.ml"

  | 6 ->
# 238 "lexer.mll"
    ( raise (Lexer_error (lex_long_range lexbuf,
        (Printf.sprintf "%s is an illegal escaped character constant" (lexeme lexbuf) ))) )
# 625 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_escaped_rec lexbuf __ocaml_lex_state

;;
