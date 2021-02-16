#!/bin/bash
PORT=15000
cat hosts.txt | while read source;
do
sed '$d' rmt_password.conf |sed "s/SOURCE_REDIS/$source/" > conf_check/rmt_$PORT.conf; ((PORT++)); 
done
