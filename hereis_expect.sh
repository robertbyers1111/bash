#!/bin/sh
cat <<EOF | /usr/local/bin/expect --
while {![eof stdin]} {
  gets stdin line
  puts line:$line
}
EOF
