#!/bin/bash

if [ $# -eq 1 ]; then
  FN=$1
else
  FN=/etc/hosts
fi

FAGE=$(expr \( $(date +%s) - $(date +%s -r $FN ) \) / 86400)

echo $FN was last modified $FAGE days ago
