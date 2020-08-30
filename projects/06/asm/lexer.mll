{ 
    open Support 
    open Parser (* open parser.ml *) 

    let text = Lexing.lexeme

    let line = ref 1 
    let incr_line () = incr line 
    let info () = createInfo (!line) 
    
}

let digit = ['0'-'9']
let init  = ['a'-'z' 'A'-'Z' '_' ':' '.' '$']
let var   = init (init | digit )* 
rule token = parse
    | [' ' '\t']            { token lexbuf  }
    | '@'                   { AT(info()) } 
    | '='                   { EQ } 
    | '|'                   { OR } 
    | '&'                   { AND } 
    | '!'                   { BANG } 
    | ':'                   { COLON } 
    | ';'                   { SEMI } 
    | '('                   { LPAREN } 
    | ')'                   { RPAREN } 
    | 'A'                   { A   } 
    | 'M'                   { M   } 
    | 'D'                   { D   }
    | "MD"                  { MD  } 
    | "AM"                  { AM  } 
    | "AD"                  { AD  } 
    | "AMD"                 { AMD }
    | "JGT"                 { JGT } 
    | "JGE"                 { JGE } 
    | "JEQ"                 { JEQ } 
    | "JLT"                 { JLT } 
    | "JNE"                 { JNE } 
    | "JLE"                 { JLE } 
    | "JMP"                 { JMP } 
    | '+'                   { PLUS } 
    | '-'                   { MINUS } 
    | '*'                   { MUL } 
    | '\n'                  { incr_line(); NEWLINE (info())   }
    | "//"                  { comment lexbuf } 
    | var                   { VAR (text lexbuf)         } 
    | digit+   as num       { NUM (int_of_string num)   } 
    | eof                   { EOF                       } 
    | _                     { token lexbuf }

and comment = parse 
    | [^ '\n']              { comment lexbuf } 
    | '\n'                  { token lexbuf } 


