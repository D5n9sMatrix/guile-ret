#!/usr/bin/gdb

set print raw-values
set print vtbl
b main
p $bpnum
