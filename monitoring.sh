# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yoel-idr <yoel-idr@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/04 23:10:11 by yoel-idr          #+#    #+#              #
#    Updated: 2022/11/14 20:37:11 by yoel-idr         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

ar=$(uname -a)
cpu=$(lscpu | grep "CPU(s)" | head -1 | awk '{print $2}')
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
totalm=$(free -m | head -n 2 | tail -n 1| awk '{ print $2}' )
usedm=$(free -m | head -n 2 | awk '{ print $3}' |tail -n 1 )
perc=$(free | head -2 | tail -1 | awk '{printf("%.2f",$3/$2*100)}')
lvm=$(lsblk | grep lvm | head -1 | awk '{if ($6 == "lvm") print "yes";else print "no"}')
tcp=$(ss -s | grep estab | awk '{print $4}' | cut -c -1)
log=$(who | awk '{print $1}' | sort -u | wc -l)
ip=$(ip addr | tail -4 | head -1 | awk '{print $2}' | cut -c -9)
mac=$(ip addr | tail -5 | head -1 | awk '{print $2}')
logsudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
USAGE=$(df -h /dev/sda1 | tail -1 | awk '{print $3 "/" $2 " (" $5 ")"}')
cpuload=$(top -b -n 1 | grep load | awk '{print $11}' | cut -c -4)
lastboot=$(who -b | awk '{print $3 " " $4}')

wall -n "
         SHOWING ALL ABOUT SERVER !
#Architecture	: $ar
#CPU physical	: $cpu
#vCPU 		: $vcpu
#Memory Usage	: $usedm/$totalm MB ($perc%)
#Disk Usage	: $USAGE
#CPU load	: $cpuload
#Last boot	: $lastboot
#LVM use	: $lvm
#Connexions tcp	: $tcp ESTABLISHED
#User log	: $log
#Network	: $ip  ($mac)
#Sudo 		: $logsudo cmd"