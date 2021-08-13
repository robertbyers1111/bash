#!/bin/bash

##----------------------------------------------------------------------
## How to do multiple commands with an if-less test command
##
## Answer from StackOverflow..
##
## Simple command grouping should work; the syntax can be a little tricky
## though.
## 
## [[ $Var = 1 ]] && { echo "yes-1"; echo "yes-2"; } || { echo "no-1"; echo "no-2"; }
## 
## A few things to note:
## 
## Heed @tvm's advice about using an if-then-else statement if you do
## anything more complicated.
## 
## Every command inside the braces needs to be terminated with a
## semi-colon, even the last one.
## 
## Each brace must be separated from the surrounding text by spaces on both
## sides. Braces don't cause word breaks in bash, so "{echo" is a single
## word, "{ echo" is a brace followed by the word "echo".
##----------------------------------------------------------------------

#-- Example 1
#--
#-- This trick uses {}'s but each command isn't trailed by a ';' (wtf?
#-- the above posting suggests semicolons are REQUIRED after each
#-- statement)

    echo
    ANVILRC=bogus

    [ $# -eq 1 ] && {
      ANVILRC=/home/$1/.anvilrc
      z=w
      w=z
      echo 1A, ANVILRC:$ANVILRC z:$z w:$w

      [ ! -f $ANVILRC ] && {
        zz=ww
        ww=zz
        ANVILRC=$1/.anvilrc
        echo 1B, ANVILRC:$ANVILRC z:$z w:$w zz:$zz ww:$ww

        [ ! -f $ANVILRC ] && {
          zzz=www
          www=zzz
          ANVILRC=$1
          echo 1C, ANVILRC:$ANVILRC z:$z w:$w zz:$zz ww:$ww zzz$zzz www:$www

        }
      }
    }

    echo 1Z, ANVILRC:$ANVILRC

#-- Example 2
#--
#-- This trick to allow multiple lines with a [] test fails because
#-- the variable being set is scoped inside the ()'s. Even export
#-- won't work

    echo
    ANVILRC=bogus

    [ $# -eq 1 ] && (
      ANVILRC=/home/$1/.anvilrc
      echo 2A, ANVILRC:$ANVILRC
      [ ! -f $ANVILRC ] && (
        ANVILRC=$1/.anvilrc
        echo 2B, ANVILRC:$ANVILRC
        [ ! -f $ANVILRC ] && (
          ANVILRC=$1
          echo 2C, ANVILRC:$ANVILRC
        )
      )
    )

    echo 2Z, ANVILRC:$ANVILRC

#-- Example 3
#--
#-- Instead, when in doubt, use 'if'

    echo
    ANVILRC=bogus

    if [ $# -eq 1 ]; then
      ANVILRC=/home/$1/.anvilrc
      echo 3A, ANVILRC:$ANVILRC

    elif [ ! -f $ANVILRC ]; then
      ANVILRC=$1/.anvilrc
      echo 3B, ANVILRC:$ANVILRC

    elif [ ! -f $ANVILRC ]; then
      ANVILRC=$1
      echo 3C, ANVILRC:$ANVILRC

    else
      ANVILRC=unknown
      echo 3D, ANVILRC:$ANVILRC

    fi

    echo 3Z, ANVILRC:$ANVILRC

