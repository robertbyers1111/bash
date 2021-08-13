#!/bin/bash

echo
echo bbbbbbbbb
for VAR in a/*b*
do
  if [ -f $VAR ]
  then
    echo $VAR exists
  else
    echo $VAR not exist
  fi
done

echo
echo zzzzzzzz
for VAR in a/*z*
do
  if [ -f $VAR ]
  then
    echo $VAR exists
  else
    echo $VAR not exist
  fi
done
