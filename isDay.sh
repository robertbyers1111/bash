#!/bin/sh

isDay ()
{
  TODAY=`/bin/date | cut -c1-3`
  if [ $TODAY = $1 ]; then
    echo Today \($TODAY\) is $1
    return 0
  else
    echo Today \($TODAY\) is NOT $1
    return 1
  fi
}

if isDay Mon ; then
  echo Yup, is Mon
elif isDay Tue ; then
  echo Yup, is Tue
elif isDay Wed ; then
  echo Yup, is Wed
elif isDay Thu ; then
  echo Yup, is Thu
elif isDay Fri ; then
  echo Yup, is Fri
elif isDay Sat ; then
  echo Yup, is Sat
elif isDay Sun ; then
  echo Yup, is Sun
fi

#-- This part isn't working
if isDay Mon -o isDay Wed -o isDay Fri ; then
  echo Yup, is M,W,F
elif isDay Tue -o isDay Thu ; then
  echo Yup, is Tu,Th
elif isDay Sat -o isDay Sun ; then
  echo Yup, is Weekend
fi
