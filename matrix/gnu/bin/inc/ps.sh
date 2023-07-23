#!/bin/sh

jobs -l
realpath --logical admin
catman --debug
debugedit -l ask.gdb "admin"