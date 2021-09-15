# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: x250 <x250@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/09/14 16:01:07 by amorcill          #+#    #+#              #
#    Updated: 2021/09/15 11:37:12 by x250             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
cpuphysical=$(lscpu | grep Core\(s\) | awk '{print $4}')
wall << FILE
#Architecture: $(uname -a)
# System Architecture: $(arch)
# Kernel Version: $(uname -r)
#CPU physical: $cpuphysical
#vCPU: $(nproc)
#Memory Usage:
#Disk Usage:
#CPU load:
#Last boot:
#LVM use:
#Connection TCP:
#User log:
#Network: IP
#Sudo:
FILE