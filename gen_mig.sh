#!/bin/bash

PORT=15000
cat hosts.txt | while read source;
do
sed "s/LISTEN_PORT/$PORT/" rmt_password.conf | sed "s/SOURCE_REDIS/$source/" > conf_password/rmt_$PORT.conf;
((PORT++));
done
