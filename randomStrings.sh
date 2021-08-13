#!/bin/bash

#-- Not exactly like lptest. My version displays RANDOM strings, not a fixed pattern

cols=88
rows=44
charset="_A-Za-z0-9!@#%^+-=:,"

while [ $rows -gt 0 ]; do
    < /dev/urandom tr -dc $charset | head -c$cols ; echo
    rows=`expr $rows - 1`
done

