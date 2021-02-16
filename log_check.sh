#!/bin/bash
m=$(cat log/15*|grep "All nodes' rdb file parsed finished for this write thread"|wc -l)
n=$(cat hosts.txt|wc -l)
if [ $m == $n ]
then
echo "All parsed finished!"
echo "----------------------------------------------"
else
echo "Parsed finished:$m"
echo "Not finished list:"
grep "All nodes' rdb file parsed finished for this write thread" -L log/15*
echo "----------------------------------------------"
fi
sleep 2
if [ $(cat log/15*|grep "I/O error"|wc -l) -ne 0 ]
then
echo "I/O error:$(cat log/15*|grep "I/O error"|wc -l)"
grep "I/O error" -l log/15*
echo "----------------------------------------------"
else
echo "No I/O error"
echo "----------------------------------------------"
fi
sleep 2
if [ $(cat log/15*|grep "lost connect"|wc -l) -ne 0 ]
then
echo "Lost connect:$(cat log/15*|grep "lost connect"|wc -l)"
grep "lost connect" -l log/15*
echo "----------------------------------------------"
else
echo "No Lost connect"
echo "----------------------------------------------"
fi