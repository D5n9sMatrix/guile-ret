#!/usr/bin/gdb

set print raw-values
set print vtbl
set confirm
set args
call 27
info inferiors
inferior 1
add-inferior -copies n -exec 1 -no-connection
clone-inferior -copies n infno
set $i = 27
set enviroment 27
info inferiors 1
set print inferior-events
set print inferior-events on
show print inferior-events 
maint info program-spaces
set print thread-events 
maintenance space 1