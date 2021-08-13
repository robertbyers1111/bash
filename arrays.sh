#!/bin/sh

#-----------------------------------------------------------------------------------
# NOTE: I think bash arrays are simpler. Check this out ...
#
#    To create an array:
#        arr=("value1" value2 $value3)
# 
#    To print an array:
#        echo ${arr[@]}
# 
#    To print length of an array:
#        echo ${#arr[@]}
# 
#    Using indices (index starts from 0):
#        echo ${arr[index]}
# 
#    Note: echo ${arr} is the same as echo ${arr[0]}
#
# ..taken from https://www.geeksforgeeks.org/string-manipulation-in-shell-scripting/
#-----------------------------------------------------------------------------------



IN="abc:def::g h i:     :xyz:123"
set -- "$IN" 
IFS=":"
declare -a Array=($*) 
NUM=${#Array[*]}
echo NUM:$NUM

I=0
while [ $I -lt $NUM ]; do
  echo " Array($I): ${Array[$I]}" 
  I=`expr $I + 1`
done




#-- Full, working example..

    DEFECTRC_PRIMARY=$HOME/.defect_primary
    DEFECTRC_SECONDARY=$HOME/.defect_secondary
    DIR=$HOME/var/defects

  #-- Create array of choices

      FILES=$DIR/*
      set -- "$FILES"
      declare -a CHOICE=($*)
      NUM=${#CHOICE[*]}

  #-- Ask user which defect to select

      echo "Select a defect .."

      I=0

      for VAR in $DIR/*
      do
        if [ -f $VAR ]; then
          I=`expr $I + 1`
          echo "  $I) `basename $VAR`"
        fi
      done

      echo "  q) quit"

      read ANSWER

      if [ "$ANSWER" = "" ]; then
        echo Thank you for pressing ENTER
      elif [ "$ANSWER" = "q" ]; then
        echo Do nothing
        exit
      else
        if [ $ANSWER -gt 0 -a $ANSWER -le $I ] > /dev/null 2>&1
        then
          ANSWER0=`expr $ANSWER - 1`
          YOURCHOICE=${CHOICE[$ANSWER0]}
        else
          echo WTF \'$ANSWER\' not a valid choice
          exit
        fi
      fi

  #-- Perform the update to user's primary defect rc

      CMD="cp -f $YOURCHOICE $DEFECTRC_PRIMARY"
      echo % $CMD
      $CMD
      echo % cat $DEFECTRC_PRIMARY
      echo ""
      cat $DEFECTRC_PRIMARY | sed 's/^/      /'
      echo ""


#-- array ranges ('slices')

    A=( foo bar "a  b c" 42 )
    B=("${A[@]:1:2}")
    C=("${A[@]:1}")   # slice to the end of the array

    echo "${B[@]}"    # bar a  b c
    echo "${B[1]}"    # a  b c
    echo "${C[@]}"    # bar a  b c 42

