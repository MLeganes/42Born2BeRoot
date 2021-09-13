# 42Born2beRoot

**Born2BeRoot** is about administration a linux system on a virtual machine.

# Debian vs CentOS
Debian is easy and more familiar. CentOS no more mantenance.

# SELinux (Security-Enhanced Linux)
For CentOS.

https://debian-handbook.info/browse/stable/sect.selinux.html

# AppArmor
For debian.
AppArmor provides **Mandatory Access Control (MAC) security**. In fact, **AppAmor allows the system administrator to restrict the actions that processes can perform**. For example, if an installed application can take photos by accessing the camera application, but the administrator denies this privilege, the application will not be able to access the camera application. If a vulnerability occurs (some of the restricted tasks are performed), AppArmor blocks the application so that the damage does not spread to the rest of the system.<br>

https://debian-handbook.info/browse/stable/sect.apparmor.html
https://wiki.debian.org/AppArmor/HowToUse

	systemctl status apparmor
	systemctl enable apparmor
	systemctl disable apparmor
	
	apt install apparmor-utils
	
	aa-status 
	apparmor_status (equal to aa-status)
	aa-logprof


# Apt vs Aptitute
In Debian-based OS distributions, the default package manager we can use is **dpkg**. This tool allows us to install, remove and manage programs on our operating system. However, in most cases, these programs come with a list of dependencies that must be installed for the main program to function properly.

**APT (Advanced Package Tool)**, which is a tool that uses dpkg, can be used to install all the necessary dependencies when installing a program.  

**Aptitude** a graphical interface packege tool.
 
https://wiki.debian.org/Aptitude

	apt-get install aptitude
	aptitude


# LVM (Logical Volume Manager)
https://wiki.debian.org/LVM

For the installation and partitions:
https://www.youtube.com/watch?v=2w-2MX5QrQw 	

	lsblk

# SUDO

	apt-get install sudo

To add an user in the sudo group

	sudo usermod -aG sudo <username>

To check if it added correctly. (file groups in the system: /etc/group)

	getent group <username>

To see the groups from an user

	groups
	groups <username>

# SU
Change to another user or super-user
	
	su <username>
	su




# SSH (Secure Shell) and UFW (Uncomplicated Firewall)

	apt-get install openssh-server

Config the ssh-server-file sshd_config, add the port 4242 and disable ssh login as root

	/etc/ssh/sshd_config
	Add		-> Port 4242
	Remove 	-> #PermitRootLogin prohibit-password
	Add		-> PermitRootLogin no

UFW

	apt-get install ufw
	ufw allow 4242
	ufw status
	ufw enable





sudo group is by default in the system. It is done before.


# Password Policy

## /etc/login.defs

	# Password has to expire every 30 days
	PASS_MAX_DAYS   30

	# The minimum number of days allowed before the modification of a password willbe set to 2
	PASS_MIN_DAYS   2

	# The user has to receive a warning message 7 days before their password expires
	PASS_WARN_AGE   7

## /etc/pam.d/common-password
**PAM** module to check password strength
Your password must be at least 10 characters long. It must contain an uppercaseletter and a number. It must not contain more than 3 consecutive identical characters. The password must not include the name of the user. 

The following rule does not apply to the root password: The password must have at least 7 characters that are not part of the former password.
Of course, your root password has to comply with this polic

	apt-get update -y
	apt-get install -y libpam-pwquality

Note: -y flag means to assume yes and silently install, without asking you questions in most cases. 

File to edit /etc/pam.d/common-password and add.
	
	# here are the per-package modules (the "Primary" block)
	password        requisite                       pam_pwquality.so retry=3
	
	# minimum password length
	minlen = 8
	
	# minimum uppercase character
	ucredit = -1

	#minimum digit character
	dcredit = -1

	#maximum number of allowed consecutive same characters
	maxrepeat = 3
	
	#reject the password if it contains <username> in some form
	reject_username

	#number of changes required in the new password from the old password to 7:
	difok=7

	#implement the same policy on root
	enforce_for_root


should look like the below:

	password	requisite	pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root


# Creating New User

	sudo adduser <<username>>
	getent passwd <username>
	chage -l <username>

# Groups user42 and sudo

	groupadd user42
	sudo usermod -aG user42 amorcill
		-a -> add
		-G -> group

# Sudo Stricts Rules

## 	/etc/sudoers
Info in the web https://www.tecmint.com/sudoers-configurations-for-setting-sudo-in-linux/

Authentication using sudo has to be limited to 3 attempts in the event of an incorrect password

	Defaults        passwd_tries=3

A custom message of your choice has to be displayed if an error due to a wrong password occurs when using sudo.

	#Defaults       badpass_message=="Password is wrong, remember it, idiot!!!!"
	Defaults        insults

Each action using sudo has to be archived, both inputs and outputs (Log sudo commands). The log file has to be saved in the/var/log/sudo/folder. 
The default I/O log directory is /var/log/sudo-io, and if there is a session sequence number, it is stored in this directory.

	Defaults        logfile="/var/log/sudo/sudo-io"
	Defaults        log_input, log_output
	
The TTY mode has to be enabled for security reasons

	Defaults        requiretty

For security reasons too, the paths that can be used by sudo must be restricted. 
Example:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

	Defaults   secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"



# Monitoring.sh
Script called monitoring.sh. It must be devel-oped inbash.At server startup, the script will display some information (listed below) on all ter-minals every 10 minutes (take a look atwall). The banner is optional. No error mustbe visible.Your script must always be able to display the following information:•The architecture of your operating system and its kernel version.•The number of physical processors.•The number of virtual processors.•The current available RAM on your server and its utilization rate as a percentage.•The current available memory on your server and its utilization rate as a percentage.•The current utilization rate of your processors as a percentage.•The date and time of the last reboot.•Whether LVM is active or not.•The number of active connections.•The number of users using the server.•The IPv4 address of your server and its MAC (Media Access Control) address.•The number of commands executed with thesudoprogra




# More commands

	id <username>			[Print info about the user]
	id -nG <username>
	ip address				[Ip address]	
	dpkg -l | grep ssh		[Check if the package is really installed]
	systemctl status ssh	[Check for the status of the service or restart]
	service ssh restart		[Check for the status of the service or restart, equal]
	

# cron & wall
Once we know a little more about how to build a server inside a Virtual Machine (remember that you also have to look in other pages apart from this README), we will see two commands that will be very helpful in case of being system administrators. These commands are:
- **Cron:** Linux task manager that allows us to execute commands at a certain time. We can automate some tasks just by telling cron what command we want to run at a specific time. For example, if we want to restart our server every day at 4:00 am, instead of having to wake up at that time, cron will do it for us.
- **Wall:** command used by the root user to send a message to all users currently connected to the server. If the system administrator wants to alert about a major server change that could cause users to log out, the root user could alert them with wall. 

# References
- https://www.youtube.com/watch?v=2w-2MX5QrQw 				[install debian]
  
- https://githubmemory.com/repo/hanshazairi/42-born2beroot	[reading OK]
- https://baigal.medium.com/born2beroot-e6e26dfb50ac

- https://github.com/HEADLIGHTER/Born2BeRoot-42				[good]

- https://github.com/pgomez-a/born2beroot					[info]

- https://baigal.medium.com/born2beroot-e6e26dfb50ac		[super]