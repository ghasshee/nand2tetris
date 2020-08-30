let pi = print_int 
let pn = print_newline 


type info           = L of int | UNKNOWN 
type 'a withinfo    = {i: info ; v: 'a} 

let createInfo l    = L(l) 


