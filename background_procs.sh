#!/bin/sh

doit1 ()
{
I=1
TODO=10
while [ $I -le $TODO ]
do
  echo "d1: $I of $TODO"
  I=`expr $I + 1`
  sleep 4
done
}

doit2 ()
{
I=1
TODO=10
while [ $I -le $TODO ]
do
  echo "d2: $I of $TODO"
  I=`expr $I + 1`
  sleep 4
done
}

doit3 ()
{
I=1
TODO=10
while [ $I -le $TODO ]
do
  echo "d3: $I of $TODO"
  I=`expr $I + 1`
  sleep 4
done
}

doit4 ()
{
I=1
TODO=10
while [ $I -le $TODO ]
do
  echo "d4: $I of $TODO"
  I=`expr $I + 1`
  sleep 4
done
}

doit1 &
sleep 1
doit2 &
sleep 1
doit3 &
sleep 1
doit4 &

