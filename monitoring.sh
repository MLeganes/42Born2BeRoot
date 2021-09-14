# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: amorcill <amorcill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/09/14 16:01:07 by amorcill          #+#    #+#              #
#    Updated: 2021/09/14 19:33:33 by amorcill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!bash
# 
arch=$(arch)
kernev=$(uname -r)
cpuphysical=$(lscpu | grep Core\(s\) | awk '{print $4}')
vcpu=$(lscpu | grep "CPU(s)" | awk '{print $2}')

wall "	
#Architecture and kernel version: $arch $kernev
#CPU physical: $cpuphysical
#vCPU: 
"