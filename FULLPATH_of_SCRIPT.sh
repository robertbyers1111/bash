#!/bin/sh

##zz echo "         pwd: `pwd`"
##zz echo "           0: $0"
##zz echo "  basename 0: `basename $0`"
##zz echo "   dirname 0: `dirname $0`"
##zz 
##zz find $0 -print

RELDIR=`dirname $0`
echo RELDIR: $RELDIR

ABSDIR=`( cd $RELDIR ; pwd )`
echo ABSDIR: $ABSDIR

ABSSCR=$ABSDIR/`basename $0`
echo ABSSCR: $ABSSCR
