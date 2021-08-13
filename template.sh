#!/bin/bash

#-----------------------------------------------------------------------
#-- This script features several common tasks..
#--
#--   Eats args
#--   Processes output of a command, line-by-line
#--   Sorts output of a func
#--   Single line tests using []
#--   Single line arg checks with usage
#--
#-----------------------------------------------------------------------

#   +---------+
#---| dolines |---
#   +---------+

dolines () {

  # PROCESSES OUTPUT LINE-BY-LINE

  cat $1 \
   | while read line
   do
     echo -n $line | wc -c
   done
}

#   +-------+
#---| doarg |---
#   +-------+

doarg ()
{
  [ $MULTIARGS -gt 0 ] && { echo; echo -n === $1; }

  if [ -f $1 ]
  then
    [ $MULTIARGS -gt 0 ] && echo
    dolines $1 | sort -Vu | tail -10
  else
    [ $MULTIARGS -gt 0 ] && echo " does not exist" || echo $1 does not exist
  fi
}

#   +--------+
#---| doargs |---
#   +--------+

doargs () {
  if [ $# -eq 1 ]; then
    MULTIARGS=0
    doarg $1
  else
    MULTIARGS=1
    while [ $# -ge 1 ]; do
      doarg $1
      shift
    done
  fi
}

#   +---------+
#---| M A I N |---
#   +---------+

  [ $# -lt 1 ] && { echo "USAGE: `basename $0` file.."; exit; }

  doargs $@

