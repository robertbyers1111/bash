#!/bin/sh

#   +----------------------------------+
#---| PROCESS FILES AND/OR DIRECTORIES |---
#   +----------------------------------+

  for VAR in /var/spool/*
  do
   echo Found $VAR
  done

#   +---------------------------+
#---| PROCESS ITEMS FROM A LIST |---
#   +---------------------------+

  LIST="abc def 123"
  for VAR in $LIST
  do
    echo Processing $VAR
  done

#   +-----------------------------+
#---| CHECK ENVIRONMENT VARIABLES |---
#   +-----------------------------+

  SEARCH=abc-def

  ABC=XX.abc-def.XX
  DEF=XX.ABC-DEF.XX

  for VAR in $ABC $DEF ; do
    if echo $VAR | grep abc-def > /dev/null ; then
      echo "YES: '$VAR' contains         '$SEARCH'"
    else
      echo " NO: '$VAR' does not contain '$SEARCH'"
    fi
  done

#   +-----------------------------+
#---| PROCESS OUTPUT OF A COMMAND |---
#   +-----------------------------+

    grep -E "^[ 	]*/" /etc/fstab | while read line
    do
      echo LINE: $line
    done

#   +--------------------------+
#---| READ A FILE LINE-BY-LINE |---
#   +--------------------------+

    FILENAME="/etc/hosts"
    while read line; do
        echo LINE: $line
    done < $FILENAME

#   +------------------------------+
#---| LOOP A FIXED NUMBER OF TIMES |---
#   +------------------------------+

    for octet4 in {0..255}
    do
        echo 192.168.0.$octet4
    done

#   +------------------------------------------------------+
#---| Avoid each word on a line being processed separately |---
#   +------------------------------------------------------+

    # 'abc' and 'dev' have their own iterations (BAD)
    
    for x in `echo abc def`
    do
        echo x:$x
    done

    #>>> x:abc
    #>>> x:def
    
    # Solution (GOOD)
    
    for x in "`echo abc def`"
    do
        echo x:$x
    done

    #>>> x:abc def

