#!/bin/bash

#-- This is a bash shell approach to commifying a number


doit ()
{
    SZ=$1

    D1="[0-9]"
    D2="[0-9][0-9]"
    D3="[0-9][0-9][0-9]"

    if [ $SZ -ge 1000 -a $SZ -lt 10000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D1\)\($D3\)$/\1,\2/"`
    elif [ $SZ -ge 10000 -a $SZ -lt 100000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D2\)\($D3\)$/\1,\2/"`
    elif [ $SZ -ge 100000 -a $SZ -lt 1000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D3\)\($D3\)$/\1,\2/"`

    elif [ $SZ -ge 1000000 -a $SZ -lt 10000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D1\)\($D3\)\($D3\)$/\1,\2,\3/"`
    elif [ $SZ -ge 10000000 -a $SZ -lt 100000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D2\)\($D3\)\($D3\)$/\1,\2,\3/"`
    elif [ $SZ -ge 100000000 -a $SZ -lt 1000000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D3\)\($D3\)\($D3\)$/\1,\2,\3/"`

    elif [ $SZ -ge 1000000000 -a $SZ -lt 10000000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D1\)\($D3\)\($D3\)\($D3\)$/\1,\2,\3,\4/"`
    elif [ $SZ -ge 10000000000 -a $SZ -lt 100000000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D2\)\($D3\)\($D3\)\($D3\)$/\1,\2,\3,\4/"`
    elif [ $SZ -ge 100000000000 -a $SZ -lt 1000000000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D3\)\($D3\)\($D3\)\($D3\)$/\1,\2,\3,\4/"`

    elif [ $SZ -ge 1000000000000 -a $SZ -lt 10000000000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D1\)\($D3\)\($D3\)\($D3\)\($D3\)$/\1,\2,\3,\4,\5/"`
    elif [ $SZ -ge 10000000000000 -a $SZ -lt 100000000000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D2\)\($D3\)\($D3\)\($D3\)\($D3\)$/\1,\2,\3,\4,\5/"`
    elif [ $SZ -ge 100000000000000 -a $SZ -lt 1000000000000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D3\)\($D3\)\($D3\)\($D3\)\($D3\)$/\1,\2,\3,\4,\5/"`

    elif [ $SZ -ge 1000000000000000 -a $SZ -lt 10000000000000000 ] ; then
      SZCOMMIFIED=`echo $SZ | sed "s/^\($D1\)\($D3\)\($D3\)\($D3\)\($D3\)\($D3\)$/\1,\2,\3,\4,\5,\6/"`

    else
      SZCOMMIFIED=$SZ
    fi

    printf %22s\\n $SZCOMMIFIED
}

doit 1
doit 12
doit 123
doit 1234
doit 12345
doit 123456
doit 1234567
doit 12345678
doit 123456789
doit 1234567890
doit 12345678901
doit 123456789012
doit 1234567890123
doit 12345678901234
doit 123456789012345
doit 1234567890123456
