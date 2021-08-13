#!/bin/sh
#-- set variable 'COLS' to the number of columns currently set by the controllin terminal
COLS=`tput cols`
cut -c-$COLS
