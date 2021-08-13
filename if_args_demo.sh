#!/bin/bash

#------------------------------------------------------------------
#-- Evaluates to true only if one of the following are satisfied..
#--
#--   A) no args
#-- or..
#--   B) only one arg, AND it equals '--help'
#--
#------------------------------------------------------------------

[[ $# -eq 0 || ( $# -eq 1 && $1 = --help ) ]] && { echo HELP!; exit; }

echo OK
