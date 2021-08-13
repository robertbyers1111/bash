#!/bin/bash

FN=/var/run/lock/../../var/mail/../log/syslog

# Display the full pathname (i.e., the canonical name) of a file or directory

CFN=`readlink -fn $FN`

# To get the canonical directory name two steps are needed:

     #-------------------------

        DIRN=`dirname $FN`

        CDIRN=`readlink -fn $DIRN`

     #-------------------------

echo
echo "   Relative directory: $DIRN"
echo "  Canonical directory: $CDIRN"
echo "       Canonical name: $CFN"
echo

