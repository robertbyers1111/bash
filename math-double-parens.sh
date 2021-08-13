#!/bin/bash

# See "test_cmd_shortcuts.txt" for confusing and possibly incorrect details

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I=11
while [ $I -ge 0 ]
do
    echo I:$I

    # NO SPACES AROUND '=' !!!
    I=$(($I-1))
done

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I=21
while [ $I -ge 0 ]
do
    echo I:$I

    # BUT SPACES INSIDE THE EXPRESSION ARE OK
    I=$(( $I-1 ))
    I=$(( $I - 1 ))
done

