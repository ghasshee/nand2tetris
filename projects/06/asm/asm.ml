
open Syntax


(* PARSE *) 
let parse in_channel = 
    let lexbuf  = Lexing.from_channel in_channel in 
    let cmds    = Parser.input Lexer.token lexbuf 
    in Parsing.clear_parser(); close_in in_channel; cmds 


(* INPUT FILE *) 
exception SingleFileMustBeSpecified
let file        = ref (None : string option ) 
let push_file   = fun str -> match !file with 
    | Some (_)      -> raise SingleFileMustBeSpecified
    | None          -> file := Some str 
let parseArgs() = Arg.parse [] push_file "" 

let get_file    = fun () -> match !file with 
    | Some s        -> s 
    | None          -> raise SingleFileMustBeSpecified  ;;

let _ = parseArgs () in 
let file = get_file () in 
let ch = open_in file in 
let cmds,tbl = parse ch  in 
let alloc = ref 16 in 
List.fold_right (fun c cs -> asm_cmd tbl alloc c; cs) cmds ()  ;;

