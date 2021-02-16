#!/bin/bash
echo "**********************************************************"
echo "*                                                        *"
echo "*                                                        *"
echo "*                                                        *"
echo "*                                                        *"
echo "*                                                        *"
echo "*                京东云REDIS迁移工具                     *"
echo "*                                                        *"
echo "*                 Version 0.3 Alpha                      *"
echo "*                                                        *"
echo "*                 Powered By Edward                      *"
echo "*                                                        *"
while :
do
echo "**********************************************************"
echo "*            输入'1':生成迁移配置文件                    *"
echo "*            输入'2':启动迁移进程                        *"
echo "*            输入'3':迁移日志概要                        *"
echo "*            输入'4':迁移数据校验                        *"
echo "*            输入'5':迁移数据key数量比对                 *"
echo "*            输入'6':停止迁移进程                        *"
echo "*            输入'7':删除迁移配置文件                    *"
echo "*            输入'8':退出                                *"
echo "**********************************************************"
    echo "请输入数字1~8执行操作："
    read cmdnum
    case $cmdnum in
        1)
		sh gen.sh
		sleep 1
		echo "配置文件生成完毕，建议再次确认hosts.txt以及conf_password目录和conf_check目录下的conf文件是否正确配置"
        ;;
        2)
		startb=$(ps -ef|grep "redis-migrate-tool"|wc -l)
		standard=`expr $(cat hosts.txt |wc -l) + 1`
		if [ $startb == 1 ]
		then
		sh start.sh
		sleep 10
		starta=$(ps -ef|grep "redis-migrate-tool"|wc -l)
		if [ $starta == $standard ]
		then
		echo "迁移进程已启动"
		else
		echo "迁移进程未启动或未全部启动，请确认"
		fi
		else
		echo "系统中已有迁移进程存在，不可重复启动"
		fi
        ;;
        3)
		echo "迁移日志概要，完整日志请查看log目录下log文件："
		sh log_check.sh
        ;;
        4)
		#echo "该功能尚未完成测试，敬请期待"
                echo "请确认迁移源实例有从库且当前连接的是从库。确认请输入y，如无从库请输入其它任意字符退出，进行手动校验。"
                read cmd
                if [ $cmd == "y" ]
                then
		sh key_check.sh
		echo "key校验完成，结果请查看checksum.out和log目录下check文件"
                else 
                continue
                fi
        ;;
        5)
		echo "源端和目的端key数量信息："
		sh key_num.sh
        ;;
        6)
		echo "请确认是否要结束迁移进程。确认请输入y，取消请输入其它任意字符。"
                read cmd
                if [[ $cmd == "y" ]]
                then
                sh stop.sh
		sleep 10
		stop=$(ps -ef|grep "redis-migrate-tool"|wc -l)
		if [ $stop == 1 ]
		then
		echo "迁移进程已结束"
		else
		echo "迁移进程未全部结束，请手动结束redis-migrate-tool进程"
                fi
                else if [[ $cmd == "" ]] 
                then
                continue
                else
                continue
                fi
                fi
        ;;
	7)
                clearb=$(ps -ef|grep "redis-migrate-tool"|wc -l)
                if [ $clearb == 1 ]
                then
                rm -f conf_password/*.conf
                rm -f conf_check/*.conf
                echo "已清空目录conf_password和conf_check下的配置文件"
                else
                echo "尚有迁移进程未结束，不能清空配置"
                fi
        ;;
        8)
		echo "工具退出"
                break
        ;;
    esac
done