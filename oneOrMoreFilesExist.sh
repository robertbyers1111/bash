#!/bin/bash

# Check if one or more files exist

i=0 ; for var in x*tcl ; do
 [ -f $var ] && i=`expr $i + 1` && break
done

if [ $i -ne 0 ] ; then
  echo i=$i, OK
else
  echo i=$i, nope
fi
