#!/bin/bash

#-------------------------------------------------------------------------------
# Note that grouping with '()' invokes a subshell, hence any vars it creates are
# not accessible in the parent. Therefore, I'm using an "inline group" ('{}').
#
# FYI: inline group ('{...}') is AKA anonymous function.
#
# Variables set in an anonymous function can be read by the parent (not true for
# standard functions!)
#
# Remember the ';' after the LAST command of the '{}' group is REQUIRED.
#-------------------------------------------------------------------------------

#   +---------------+
#---| BEEN_HERE_YET |---
#   +---------------+

BEEN_HERE_YET ()
{

    let ATTEMPTS++

    echo IN BEEN_HERE_YET

    [[ ! $BEEN_HERE ]] && { echo Yay! First time in here!; BEEN_HERE=1; }

}

#   +------+
#---| MAIN |---
#   +------+

    echo

    BEEN_HERE_YET
    BEEN_HERE_YET
    BEEN_HERE_YET

    echo
    echo IN MAIN
    echo "   BEEN_HERE=$BEEN_HERE
    echo "   ATTEMPTS=$ATTEMPTS"

