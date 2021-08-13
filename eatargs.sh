#!/bin/bash

#-------------------------------------------------------
#-- DEMO 1..
#
# eatargs () {
#   [ $# -lt 1 ] && { echo "USAGE: `basename $0` file.."; exit; }
#   while [ $# -ge 1 ]; do
#     [ -f $1 ] && echo $1 exists || echo $1 does not exist
#     shift
#   done
# }
#
# eatargs $@

#-------------------------------------------------------
#-- DEMO 2..

    USAGE () { echo "Usage: `basename $0` [-x|-r|-u user]"; exit; }

    [ $# -lt 1 ] && { USAGE; }

    REMUSER=logger

    while [ $# -ge 1 ]; do
      case $1 in
        -x) echo xxx
        ;;
        -r) REMUSER=root
        ;;
        -u) REMUSER=$2
            shift
        ;;
        *) echo Unkown option: $1
           USAGE
        ;;
      esac
      shift
    done

    echo REMUSER: $REMUSER

# vi /home/rbyers/public_html/sh/eatargs.sh

