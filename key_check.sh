#!/bin/bash
sh sourceDbSize.sh > dbsize.out
j=$(cat hosts.txt | wc -l)
echo "请设置校验key数量占key总数量的除比，建议设置为10的n次幂"
read percent
expr $percent + 1 &>/dev/null
while [ $? -ne 0 -o $percent -eq 0 ]
do
 echo "非法输入值！请输入非零数字："
 read percent
 expr $percent + 1 > /dev/null 2>&1
done
for((i=0;i<j;i++))
do
k=`expr $i + 1`
m=$(awk 'NR=='$k'{print $4}' dbsize.out)
n=`expr $i + 15000`
x=`expr $m / $percent`
echo "分片$k：" >> checksum.out
./redis-migrate-tool -c conf_check/rmt_$n.conf -o log/check$i -C "redis_check $x" >> checksum.out
sleep 5
done