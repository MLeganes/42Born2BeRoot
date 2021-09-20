# 42Born2beRoot -- Defense

# Project overview

## Apt vs Aptitute
In Debian-based OS distributions, the default package manager we can use is **dpkg**. This tool allows us to install, remove and manage programs on our operating system. However, in most cases, these programs come with a list of dependencies that must be installed for the main program to function properly.
**APT (Advanced Package Tool)**, which is a tool that uses dpkg, can be used to install all the necessary dependencies when installing a program.
**Aptitude** a graphical interface package tool.

## AppArmor
AppArmor provides **Mandatory Access Control (MAC) security**. AppAmor allows the system administrator to restrict the actions that processes can perform.

## SELinux (Security-Enhanced Linux)
For CentOS. Like AppArmor.

# Simple setup

	sudo service ufw status
	sudo service ssh status

# Users

	id
	sudo adduser user1 user42
	passwd
	sudo usermod -aG user42 user1

	# Config-Passwd-Policy
	/etc/login.defs
	/etc/pam.d/common-password
	#visudo to edit **/etc/sudoers**
	

# Hostaname

	hostname
	nano /etc/hostname
	# Reboot

# LVM (Logical Volume Manager)
	
	lsblk

	||-------------------------OS----------------------------||
	||-------------------------LVM---------------------------||
	||  LV-1 (/)    |LV-2 (swap)|  LV 3 (/home) | LV-4 (/tmp)|| Logical Volumes(LV)
	||------------------------------------------|------------||
	||                  VG 1                    |    VG 2    || Volume Groups(VG)
	||------------------------------------------|------------||
	||  /dev/sda2 |    /dev/sda3    | /dev/sdb2 | /dev/sdd4  || Physical Volumes(PV)
	||-------------------------------------------------------||

# Sudo Su

	dpkg -l | grep sudo
	Sudo Stricts Rules #visudo
	cat /var/log/sudo/sudo.log

# UFW

	dpkg -l | grep ufw
	sudo ufw status

# SSH (Secure Shell) 

	dpkg -l | grep ssh
	sudo service ssh status

# Monitoring.sh
At server startup, the script will display some information on all terminals every 10 minutes. Schedule the task with cron and send masage with wall.
See the monitoring.sh script.

# Cron and wall
**Cron** Linux task manager that allows us to execute commands at a certain time. We can automate some tasks just by telling cron what command we want to run at a specific time. 
**Wall** command used by the root user to send a message to all users currently connected to the server. If the system administrator wants to alert about a major server change that could cause users to log out, the root user could alert them with wall.

Stop the monitoring script without change the crontab file:

	ps aux | grep cron 		[Find the pid from cron]
	kill -19 <pid>			[Send the stop sign to cron to stop the monitoring script]

