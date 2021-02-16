#!/bin/bash
j=$(netstat -antlp|grep 127.0.0.1:1500*|wc -l)
for((i=0;i<j;i++))
do
n=`expr 15000 + $i`
/redis-cli -p $n shutdown
sleep 5
done
