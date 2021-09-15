# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: x250 <x250@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/09/14 16:01:07 by amorcill          #+#    #+#              #
#    Updated: 2021/09/15 13:23:19 by x250             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
cpuphysical=$(lscpu | grep Core\(s\) | awk '{print $4}')
memusage=$(free -m | sed -n 2p | awk '{print $3}')
memtotal=$()
mempercen=$()
wall << FILE
#Architecture: $(uname -a)
# System Architecture: $(arch)
# Kernel Version: $(uname -r)
#CPU physical: $cpuphysical
#vCPU: $(nproc)
#Memory Usage:$(memusage)/$(memtotal) ($(mempercent))
#Disk Usage:
#CPU load:
#Last boot:
#LVM use:
#Connection TCP:
#User log:
#Network: IP
#Sudo:
FILE