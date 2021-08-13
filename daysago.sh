#!/bin/sh

# This script shows how to figure out the date an arbitrary number of days ago

doit ()
{
DAYS_BACK=$1

eval `date "+%d %m %Y $DAYS_BACK" | \
awk '
{
while(($1-=$4)<1){
  $4=-$1
  if(!(--$2)){$2=12;$3--}
  R=31
  if($2==4||$2==6||$2==9||$2==11)R--
  if($2==2){
           R=29
           if(($3%4)||!($3%100)&&($3%400))R--
           }
  $1=R
  } print "d="$1" m="$2" y="$3
}

'`

echo "date $DAYS_BACK day(s) ago=$d/$m/$y"
}

doit 1
doit 2
doit 3
doit 4
doit 5
doit 6
doit 7
doit 8
doit 9

doit 10
doit 11
doit 12
doit 13
doit 14
doit 15
doit 16
doit 17
doit 18
doit 19

doit 20
doit 21
doit 22
doit 23
doit 24
doit 25
doit 26
doit 27
doit 28
doit 29

doit 30
doit 31
doit 32
doit 33
doit 34
doit 35
doit 36
doit 37
doit 38
doit 39


