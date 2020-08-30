%{
open Syntax
open Support

exception ALUError



%}

/* %token <arg> TOKEN */ 

%token <Support.info>NEWLINE 
%token EOF 
%token LPAREN RPAREN 
%token EQ 
%token PLUS MINUS MUL AND OR 
%token <int> NUM 
%token <string> VAR
%token A D M MD AM AD AMD 
%token <Support.info> AT 
%token ONE ZERO 
%token BANG
%token COLON SEMI 
%token JGT JEQ JGE JLT JNE JLE JMP 


%left  PLUS

%start input 
%type <Syntax.commands> input 

%%
input: 
    | EOF                       { [] } 
    | line input                { List.append $2 $1  } 

line : 
    | NEWLINE                   { []    }
    | command NEWLINE           { (* let L(l) = $2 in pi l;pn(); *) [$1]  }

command: 
    | comp jump                 { C_COMMAND([],$1,$2) } 
    | dest comp                 { C_COMMAND($1,$2,NULL) } 
    | dest comp jump            { C_COMMAND($1, $2, $3) }
    | AT symbol                 { A_COMMAND($2) }
    | LPAREN VAR RPAREN COLON   { L_COMMAND($2) }

symbol: 
    | VAR                       { VAR($1)  } 
    | NUM                       { ADDR($1) } 

jump: 
    | SEMI jjj                  { $2  } 
jjj: 
    | JGT                       { JGT } 
    | JEQ                       { JEQ } 
    | JGE                       { JGE } 
    | JLT                       { JLT } 
    | JNE                       { JNE } 
    | JLE                       { JLE } 
    | JMP                       { JMP } 

dest: 
    | regs EQ                   { $1 } 
regs: 
    | reg                       { [$1]      } 
    | MD                        { [M;D]     } 
    | AM                        { [A;M]     } 
    | AD                        { [A;D]     } 
    | AMD                       { [A;M;D]   } 

/* CPU instruction  */
comp: 
    |       regOI               { REG($1)                   } 
    | MINUS regOI               { UMINUS($2)                } 
    | BANG  reg                 { NOT($2)                   } 
    | reg PLUS  regOI           { PLUS($1, $3)              } 
    | reg MINUS regOI           { MINUS($1,$3)              } 
    | reg MUL   regOI           { MUL($1,$3)                } 
    | reg AND   regOI           { AND($1,$3)                } 
    | reg OR    regOI           { OR($1,$3)                 } 

reg: 
    | A                         { A                         }                    
    | M                         { M                         }                      
    | D                         { D                         }                     

regOI: 
    | reg                       { $1                        } 
    | NUM                       { if $1=0 then ZERO else if $1=1 then ONE else raise ALUError } 
