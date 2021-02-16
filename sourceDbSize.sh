#!/bin/bash
FILENAME=hosts.txt
DBSIZE=0

for line in `cat ${FILENAME}`
do
    # echo ${line}
    IFS=":"
    array=($line)
    IP=${array[0]}
    PORT=${array[1]}
    num=$(../redis-cli -h ${IP} -p ${PORT}  DBSIZE)
    echo ${line} = $num
    DBSIZE=`expr $DBSIZE + $num `
done

echo ""
echo "Total DBSize: $DBSIZE"
