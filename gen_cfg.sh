#!/bin/bash
cat info.txt|sed -ne '8,$p'> hosts.txt

JDCAUTH=$(sed -n 2p info.txt)
JIMDBAUTH=$(sed -n 4p info.txt)
JDCURL=$(sed -n 6p info.txt)
if [[ $JIMDBAUTH == "" ]]
then
sed -i -e "s/JDCAUTH/$JDCAUTH/" -e 3d -e "s/JDCURL/$JDCURL/" rmt_password.conf
sed -i "s/-a PASSWORD//" sourceDbSize.sh
else
sed -i -e "s/JDCAUTH/$JDCAUTH/" -e "s/JIMDBAUTH/$JIMDBAUTH/" -e "s/JDCURL/$JDCURL/" rmt_password.conf
sed -i "s/PASSWORD/$JIMDBAUTH/" sourceDbSize.sh
fi