#!/bin/sh

if (($#<1)); then
  echo
  echo "    USAGE: `basename $0` file.."
  echo
  exit
fi

doit ()
{
  while [ $# -ge 1 ]; do
    if [ ! -f "$1" ]; then
      echo "  WTF: '$1' NOT EXIST"
    else
      printf "   %5d %5d %5d %5d   %s\n" `sum -r "$1"` `sum -s "$1"`
    fi
    shift
  done
}

doit $@ | sort -n

