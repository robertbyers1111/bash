#!/bin/sh

doit ()
{
  rcp -p $1 $2
  RETVAL=$?
  if [ $RETVAL -ne 0 ]; then
   echo rcp $1 $2 failed with err status: $RETVAL
  else
   echo rcp $1 $2 OK
  fi
}

doit $1 $2
