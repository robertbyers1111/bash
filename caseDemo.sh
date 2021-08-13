#!/bin/bash

day=`date +%w`

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
case $day in

 0|6) echo Weekend
 ;;

 1|3|5) echo MWF
 ;;

 *) echo Tu/Th
 ;;

esac

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CASE-SENSITIVE MATCHING (or not)

doit()
{
    echo

    # Set or unset nocasematch shopt
    ${1}

    # Display current nocasematch shopt
    shopt -p nocasematch

    # Try it out!
    case $2 in
        AAA) echo "$2 is AAA!"
        ;;
        *) echo "$2 is not AAA"
        ;;
    esac
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  ***  M A I N  ***

echo
echo "NOTE: nocasematch is bash only!!!"

doit "shopt -u nocasematch" aaa
doit "shopt -s nocasematch" aaa

