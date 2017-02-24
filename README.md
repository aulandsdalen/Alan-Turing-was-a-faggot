
command | meaning
--------|--------
movl | decrement the data pointer  
movr | increment the DP 
inc | increment the byte at the DP 
dec | decrement the byte at the DP 
printb | print byte at the DP 
getb | get one byte from input, store at the DP  
jz | jump after the matching `end` command if data at the DP is non-zero 
endz | if data at the DP is non-zero, then jump back to matching `jz`  
