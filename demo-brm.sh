#!/bin/bash

doit (){

  echo
  echo =====

  date +%s > $1/x
  ls -l $1/x

  echo
  ls -ltr ~/.trash | tail -8

  brm $1/x

  echo
  ls -ltr ~/.trash | tail -8
}

doit a
doit b
doit a
doit b
doit a
doit b
doit a
doit b
doit a
doit b
doit a
doit b
doit a
doit b
