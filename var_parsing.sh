#!/bin/bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# THIS IS VERY BASIC! See further down for regex and other advanced features!
#
#   Substring matching:
#   
#   In Bash, the shortest and longest possible match of a substring can be
#   found and deleted from either front or back.
#   
#   Syntax:
#   
#   To delete the shortest substring match from front of $string:
#   
#       ${string#substring}
#   
#   To delete the shortest substring match from back of $string:
#   
#       ${string%substring}
#   
#   To delete the longest substring match from front of $string:
#   
#       ${string##substring}
#   
#   To delete the shortest substring match from back of $string of $string:
#   
#       ${string%%substring}
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

match="1232 [2021-6787-164322] uname -a"
echo
echo "Original string is: $match"

echo "This will delete the shortest substring that matches *] from front:" ${match#*]}
echo "This will delete the longest substring that matches *[0-9]] from front:" ${match##*[0-9]]}
echo "This will delete the longest substring that matches *[0-9] from front:" ${match##*[0-9]}
echo "This will delete the shortest substring that matches *[6-9] from front:" ${match#*[6-9]}
echo "This will NOT delete the shortest substring that matches *714 from front:" ${match#*714]}   # <== WRONG!!!

match="Welcome.to.GeeksForGeeks"
echo
echo "Original string is: $match"
echo "This will delete the shortest substring that matches *. from front:" ${match#*.}
echo "This will delete the shortest substring that matches .* from  back:" ${match%.*}
echo "This will delete the longest  substring that matches *. from front:" ${match##*.}
echo "This will delete the longest  substring that matches .* from  back:" ${match%%.*}

match="WelcomeZtoZGeeksForGeeks"
echo
echo "Original string is: $match"
echo "This will delete the shortest substring that matches *Z from front:" ${match#*Z}
echo "This will delete the shortest substring that matches Z* from  back:" ${match%Z*}
echo "This will delete the longest  substring that matches *Z from front:" ${match##*Z}
echo "This will delete the longest  substring that matches Z* from  back:" ${match%%Z*}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ADVANCED
#
# 3.2. Pattern Matching
# 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Bash has a built-in simple pattern matching system. It consists of a few wildcards:
# 
#     *  matches any number of characters
#     +  matches one or more characters
#     [abc] matches only given characters a, b or c
# 
# For example, we can check if the file has a .jpg extension using a
# conditional statement:

    if [[ "file.jpg" = *.jpg ]]; then echo "is jpg"; fi

# is jpg
# 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# [Extended Globbing]
#
# There’s also an extended matching system called 'extended globbing'. It
# enables us to constraint wildcards to specific patterns:
# 
#     *(pattern) matches any number of occurrence of pattern
#     ?(pattern) matches zero or one occurrence of pattern
#     +(pattern) matches one or more occurrence of pattern
#     !(pattern) negates the pattern, matches anything that doesn’t match the pattern
# 
# Extended globbing must be turned on with the shopt command. We can
# improve the last snippet to also match the .jpeg extension:

    shopt -s extglob
    if [[ "file.jpg" = *.jp?(e)g ]]; then echo "is jpg"; fi

# is jpg
# 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# [Regular Expressions]
#
# If we need more expressive pattern language we can also use regular
# expressions with the not-equals (=~) operator:

    if [[ "file.jpg" =~ .*\.jpe?g ]]; then echo "is jpg"; fi
 
# is jpg
# 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# [Enhanced Regular Expressions]
#
# We can use Extended Regular Expressions here, like when calling grep
# with the -E flag. If we use the capture groups, they’ll be stored in the
# BASH_REMATCH array variable and can be accessed later.
# 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.3. Removing Matched Substring
# 
# Bash provides us with a mechanism to remove a substring from a given
# string using the parameter expansion. It always removes only one matched
# substring. Depending on usage, it can match the longest or shortest
# substring and match starting from the beginning or from the end.
# 
# It’s important to note that it doesn’t modify a variable, and only
# returns a modified value. To make this fact explicit, we’ll use
# read-only variables in examples.
# 
# So, let’s remove an extension from a filename. To do this, we need to
# match from the end of the string using the percent (%) operator. The
# singular operator will match the shortest substring, double will match
# the longest one:
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# [Remove start of string - single match]

    declare -r FILENAME="index.component.js"
    echo ${FILENAME%.*}

# index.component
# 
# [Multiple Match]
#
# Because we used a singular percent sign, we matched only the .js
# substring. If we’d like to filter out all the extensions we’d do:

    declare -r FILENAME="index.component.js"
    echo ${FILENAME%%.*}

# index
# 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# [Remove end of string - single match]
#
# We can also remove filename, leaving only extensions. In that case, we
# need to start from the beginning using the hash (#) operator:

    declare -r FILENAME="index.component.js"
    echo ${FILENAME#*.}

# component.js
# 
# [Multiple Match]
#
# Analogically to the previous example, if we would like to leave only
# last extension we need to use a double-hash:

    declare -r FILENAME="index.component.js"
    echo ${FILENAME##*.}

# js
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3.4. Substituting Matched Substring
# 
# Instead of just removing substring we can substitute it using slash (/)
# operator.  The singular operator changes the first match and the double
# operator changes all matches. Both match the longest possible substring.
# 
# Let’s write code that changes the file name while leaving the extension intact:

    declare -r FILENAME="index.component.js"
    echo ${FILENAME/*./index.}

# index.js
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 4. Case Study
#
# Let’s put features described above to good use. We will write a script
# that updates all old version strings (for example 1.0.1 to 1.1.0) inside
# a provided file and also keeps backup of old file with old version
# attached to its name.

# We will pass filename and version strings as arguments to the script but
# we will redeclare them to make the rest of the code more readable.
# Finally, we will use the redirection mechanism to save modified content.

#!/bin/sh
declare -r FILENAME=$1
declare -r OLD_VERSION=$2
declare -r NEW_VERSION=$3
declare -r BACKUP_FILENAME=${FILENAME%.*}'_'$OLD_VERSION'.'${FILENAME##*.}
declare -r CONTENT=`cat $FILENAME`

cp $FILENAME $BACKUP_FILENAME
echo "${CONTENT//$OLD_VERSION/$NEW_VERSION}" > $FILENAME

