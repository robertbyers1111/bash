#!/bin/sh
if id -u | egrep "^0$" > /dev/null ; then
  echo "NOPE. You are NOT running as root"
else 
  echo "YES. You are running as root"
fi
