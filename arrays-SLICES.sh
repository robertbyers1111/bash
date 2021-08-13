#!/bin/bash

doit () {
 echo
 echo "In doit.."
 echo "  zeroth: ${*:0:1}" #(curly braces are required!)
 echo "   first: ${*:1:1}"
 echo "  second: ${*:2:1}"
 echo "   third: ${*:3:1}"
 echo "  fourth: ${*:4:1}"
 echo "   fifth: ${*:5:1}"
 echo "   sixth: ${*:6:1}"
 echo " seventh: ${*:7:1}"
 echo
 echo "   Fourth, fifth and sixth:   ${*:4:3}"
 echo "       Second through last:   ${*:2}"
}

doit one two three four five six seven

A=(one two three four five six seven)

echo
echo "In main.."
echo "   first: ${A[@]:0:1}"
echo "  second: ${A[@]:1:1}"
echo "   third: ${A[@]:2:1}"
echo "  fourth: ${A[@]:3:1}"
echo "   fifth: ${A[@]:4:1}"
echo "   sixth: ${A[@]:5:1}"
echo " seventh: ${A[@]:6:1}"
echo
echo "   Fourth, fifth and sixth:   ${A[@]:3:3}"
echo "       Second through last:   ${A[@]:1}"
