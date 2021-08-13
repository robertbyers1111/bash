#!/bin/sh

  #-- Ask user something

      echo "Press ENTER to continue, 'q' to quit"
      read ANSWER

      if [ "$ANSWER" = "" ]; then
        echo Thank you for pressing ENTER
      elif [ "$ANSWER" = "q" ]; then
        echo Quitting..
        exit
      else
        echo You typed $ANSWER
      fi

  #-- Read direct from file

    while read line; do
        echo LINE: $line
    done < $1

  #-- Read from pipe

    cat $1 | while read line; do
        echo LINE: $line
    done
