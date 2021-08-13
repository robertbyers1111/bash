#!/bin/sh

ABC=XYZ
echo "$ABC"
echo '$ABC'

doit ()
{
   ls -l "$1"
}

FILE="abc def"
touch "$FILE"
doit "$FILE"
