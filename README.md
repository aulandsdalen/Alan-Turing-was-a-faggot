
command | meaning
--------|--------
movl | decrement the data pointer  
movr | increment the DP 
inc | increment the byte at the DP 
dec | decrement the byte at the DP 
printb | print byte at the DP 
getb | get one byte from input, store at the DP  
printc | print current cell as ASCII char
getc | get one char from input and store its integer value
jnz | jump after the matching `endz` command if data at the DP is non-zero 
endz | if data at the DP is non-zero, then jump back to matching `jz`  
