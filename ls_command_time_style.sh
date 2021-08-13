#!/bin/sh

NOW=`date +%s`
TMPFILE=/tmp/.monitor
THRESHOLD=`expr 45 \* 60`
DIR_SIT_STRESS_TEST=/export/home/bbyers/sqa-e100/SIT_STRESS_TEST

#   +------+
#---| doit |---
#   +------+

doit ()
{
  echo ""
  echo "INFO: === Checking log file ages in directory $1/"
  cd $1
  ls -l --time-style=+%s LOGS*log > $TMPFILE
  while read line
  do

    FILENAME=`echo $line | cut -d\  -f7`
    FILETIME=`echo $line | cut -d\  -f6`
    FILEAGE=`expr $NOW - $FILETIME`
    FILEAGE_MINS=`expr $FILEAGE / 60`

    #echo ""
    #echo LINE:$line
    #echo FILENAME:$FILENAME
    #echo FILETIME:$FILETIME
    #echo FILEAGE:$FILEAGE
    #echo FILEAGE_MINS:$FILEAGE_MINS

    if [ $FILEAGE -gt $THRESHOLD ]; then
      echo "WARN: $1/$FILENAME not updated in $FILEAGE_MINS minutes"
    else
      echo "INFO: $1/$FILENAME OK, updated $FILEAGE_MINS minutes ago"
    fi
  done < $TMPFILE
  cd ..
}

#   +------+
#---| MAIN |---
#   +------+

cd $DIR_SIT_STRESS_TEST

touch $TMPFILE
chmod 666 $TMPFILE

doit T14
doit T15
doit T16
doit T17

