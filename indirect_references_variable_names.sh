#!/bin/sh

a=letter_of_alphabet   # Variable "a" holds the name of another variable.
letter_of_alphabet=z

echo

# Direct reference.
echo "a = $a"          # a = letter_of_alphabet

# Indirect reference.
  eval a=\$$a
# ^^^        Forcing an eval(uation), and ...
#        ^   Escaping the first $ ...
# ------------------------------------------------------------------------
# The 'eval' forces an update of $a, sets it to the updated value of \$$a.
# So, we see why 'eval' so often shows up in indirect reference notation.
# ------------------------------------------------------------------------
  echo "Now a = $a"    # Now a = z

#   +---------------+
#---| CMD LINE DEMO |---
#   +---------------+

# This demo sets an arbitrary number of variables to the values specified on command line
# (FYI the first two cmd line args are ignored in this demo)

STARTING_ARGC=$#

while [ $# -gt 2 ]; do

  I=`expr $STARTING_ARGC - $# + 1`
  J=`expr $I + 1`

  echo

  # Set variable names
    VARNAME_I=PATTERN$I
    VARNAME_J=PATTERN$J

  # Populate the variables
    eval $VARNAME_I=$3
    eval $VARNAME_J=$4

  # Get values into a new variable
    eval VAL_I=\$$VARNAME_I
    eval VAL_J=\$$VARNAME_J

  # Display results
    echo $VARNAME_I = $VAL_I
    echo $VARNAME_J = $VAL_J

    I=`expr $I + 2`

  shift
  shift

done

