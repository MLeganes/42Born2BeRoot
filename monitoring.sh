#!/bin/bash
cpuphysical=$(lscpu | grep Core\(s\) | awk '{print $4}')
mem=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }')
#memusage=$(free -m | awk '$1 == "Mem:" {print $3}')
#memtotal=$(free -m | awk '$1 == "Mem:" {print $2}')
#mempercen=$(free | awk '$1 == "Mem:" {printf("%.3f"), $3/$2*100}')
disk=$(df -h --total | awk '$1 == "total" {printf" %d/%dGB (%s)", $3,$2,$5}')
cpuload=$(mpstat | grep all | awk '{printf"%s%%", 100-$13}')
lastboot=$(	who -b | awk '{printf"%s %s", $3,$4}')
lvm=$(lsblk | grep lvm | wc -l | awk '{print ($0 > 0)?"yes":"no"}')
nettcp=$(ss -s | grep estab | awk '{printf"%d ESTABLISHED",$4}')
userlog=$(who | wc -l)
mac=$(ip addr | grep link/ether | awk '{printf" (%s) ",$2}')
sudo=$(cat /var/log/sudo/sudo.log | awk 'NR == 1 || NR % 2 == 1' | wc -l)
# +System Architecture: $(arch)
# +Kernel Version: $(uname -r)
wall "
#Architecture: $(uname -a)
#CPU physical: $cpuphysical
#vCPU: $(nproc)
#Memory Usage: $mem
#Disk Usage: $disk
#CPU load: $cpuload
#Last boot: $lastboot
#LVM use: $lvm
#Connection TCP: $nettcp
#User log: $userlog			
#Network: IP $(hostname -I) $mac
#Sudo: $sudo
"