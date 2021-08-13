#!/bin/bash

doit ()
{

#-- Here is the magic..

< /dev/urandom tr -dc $CHARSET | head -c$BYTES

}

#-- Generates a random integer between 0 and 65535

    CHARSET="0-9A-F"
    BYTES=4

#-- Set to 1 for result in decimal. Otherwise result is in hex

    DECIMAL=1

#-- Generate the number..

    RANDVAL=`doit`

#-- Display the result in desired radix..

    case $DECIMAL in
      1) echo 10o 16i $RANDVAL p | dc
      ;;
      *) echo $RANDVAL
      ;;
    esac

