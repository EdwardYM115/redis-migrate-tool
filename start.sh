#!/bin/sh
j=$(ls conf_password/rmt_*.conf|wc -l)
for((i=0;i<$j;i++))
do
  n=`expr 15000 + $i`
  ./redis-migrate-tool -c ./conf_password/rmt_$n.conf -o log/$n.log -d
sleep 5
done
