#!/bin/bash

IGNORELIST="\
.ICEauthority\
|.Xauthority\
|.bash_history\
|.lesshst\
|.rnd\
|.viminfo\
|.xsession-errors\
|.xsession-errors.old"

DEST="$HOME/work/myrootLin"

doit ()
{
  while [ $# -gt 0 ]; do
    if echo $1 | egrep -q $IGNORELIST
    then
      echo "  ignoring.... $1"
    else
      if [ $1 -nt $DEST/$1 ]; then
        echo UPDATING..... $1
        cp -p $1 $DEST
      else
        echo "  no changes.. $1"
      fi
    fi
    shift
  done
}

#   +------+
#---| MAIN |---
#   +------+

if [ "$HOME" == "" ]; then
  echo HOME not set
  exit
fi

cd $HOME

doit `find .??* -type f -o -type d -prune -a ! -type d` | sort

doit ~/.vim/vimrc_rbyers
