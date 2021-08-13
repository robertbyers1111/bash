#!/bin/bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# A possilbe way to determine the extension of a file. In this
# example we define 'extension' as the trailing part of basename
# that was not part of basename due to using the "-s " param.
#
# We also set variables EF_BASENM0 and EF_BASENM1...
#
#    EF_BASENM0 : Essentially the output of `basename $FOO`
#    EF_BASENM1 : Same as EF_BASENM0, but with extension lopped off
#    EF_EXTENS: The extension

extensionFinder()
{
    FILENM=$*
    EF_BASENM0=`basename $FILENM`
    case $EF_BASENM0 in
        *.sh) EXTENSARG=" -s .sh" ;;
        *.py) EXTENSARG=" -s .py" ;;
        *.gz) EXTENSARG=" -s .gz" ;;
        *.tar) EXTENSARG=" -s .tar" ;;
        *) EXTENSARG="" ;;
    esac
    EF_BASENM1=`basename $EXTENSARG $FILENM`
    EF_EXTENS=`echo $EF_BASENM0 | sed "s/${EF_BASENM1}.//"`
    echo $EF_EXTENS
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# M A I N

for FNM in $*
do

    #Call like this to access the EF_ variables in caller's scope...
    extensionFinder $FNM
    echo
    echo FILENAME: $FNM
    echo EF_BASENM0: $EF_BASENM0
    echo EF_BASENM1: $EF_BASENM1
    echo EF_EXTENS: $EF_EXTENS

    #Reset the variables before next demo
    EXT=""
    EF_BASENM0=""
    EF_BASENM1=""
    EF_EXTENS=""

    #Call like this to set the extension to a variable in this scope. Won't see the EF_ variables
    EXT=`extensionFinder $FNM`
    echo
    echo FILENAME: $FNM
    echo EXT: $EXT
    echo "  These should be empty.."
    echo "    EF_BASENM0: $EF_BASENM0"
    echo "    EF_BASENM1: $EF_BASENM1"
    echo "    EF_EXTENS: $EF_EXTENS"
done
