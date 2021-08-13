#!/bin/sh

OTHERDIR=/tmp
PWD=`pwd`
BN=`basename $PWD`
echo PWD=$PWD
echo BN=$BN

for VAR in *
do
 if [ -f $VAR ]; then
   echo ""
   ls -l $VAR
   (cd $OTHERDIR$BN ; echo "`ls -l $VAR`   ($OTHERDIR$BN)")
  fi
done
