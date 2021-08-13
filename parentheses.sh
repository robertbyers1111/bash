#!/bin/sh

#---| Use parens to sort the entire output of a for loop |---

PROCS=`ps -efj | grep -v ^UID | cut -d\  -f1`

(for VAR in `echo $PROCS | tr ' ' '\n' | sort -u`
do
  echo $VAR
done) | sort -n

