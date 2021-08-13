#!/bin/bash

#-------------------------------------------------
#
# o Quotes around `expr` statement are BACKQUOTES!
# o Spaces on both sides of "+" sign are REQUIRED!
#
#-------------------------------------------------

#-- Finite loop..

    I=1
    TODO=10
    while [ $I -le $TODO ]
    do
      echo Processing $I of $TODO
      I=`expr $I + 1`
      if [ "$ANOTHER_VAR" = "17" ]; then
        break
      fi
    done

#-- Infinite loop..

    while [ 1 ]
    do
      date
      sleep 1
    done

#-- From cmd line..

    while [ 1 ]; do echo; pwd; date; sleep 1; done

