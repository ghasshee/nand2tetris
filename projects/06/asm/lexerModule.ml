
let str_buf     = ref (Bytes.create 2048)
let str_end     = ref 0 
let str_reset() = str_end := 0 
let addchar c   = Bytes.set !str_buf !str_end c; str_end := !str_end + 1 
let get_str ()  = Bytes.sub (!str_buf) 0 (!str_end) 

