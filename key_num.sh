#!/bin/bash
JDCAUTH=$(sed -n 2p info.txt)
JDCURL=$(sed -n 6p info.txt)
sh sourceDbSize.sh > dbsize.out
echo "---------JIMDB-----------"
sed -n '$p' dbsize.out
echo "----------JDC------------"
redis-cli -h $JDCURL -a $JDCAUTH info|sed -n '$p'