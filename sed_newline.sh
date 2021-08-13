#!/bin/bash

#------------------------------------------------------------------------
# In bash at least, $'' strings will replace \n with a real newline,
# but then you have to double the backslash that sed will see to escape
# the newline, e.g.
#------------------------------------------------------------------------

#-- non-$'' method

    echo ABC | sed 's/B/\
X/g'

#-- $'' method

    echo "a,b" | sed -e $'s/,/\\\n/g'
