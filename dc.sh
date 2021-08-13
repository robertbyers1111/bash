#!/bin/bash

#-- GOTCHA: This will NOT convert hex to decimal: '16i10o 20p' (!)

#-- The reason: '10' is input *after* we already declared input to be hex (!)

#-- The solution: '10o16i 20p' (always declare output radix before input radix)

dc -e "10o16i 20p"

