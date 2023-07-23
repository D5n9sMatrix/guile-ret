#!/usr/bin/gdb

set print raw-values
set print vtbl
enable once(512)
trace(512)
print-object(512)
set $obj = 0x200
echo $obj
run "obj.inc"
set args
call 512
set check type
set code-cache
set confirm
set cp-abi gnu-v2
set cp-abi gnu-v3
set output 79
call 79
quit
