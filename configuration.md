# 42Born2beRoot -- Configuration

# AppArmor

	systemctl status apparmor
	systemctl enable apparmor
	systemctl disable apparmor
	
	apt install apparmor-utils
	
	aa-status 
	apparmor_status				[equal to aa-status]
	aa-logprof

# Apt and Aptitute

	apt-get install aptitude
	aptitude					[start the app]


# LVM (Logical Volume Manager)
For the installation and partitions:
https://www.youtube.com/watch?v=2w-2MX5QrQw 	

	lsblk


# Sudo, Su, adduser and groupadd

	apt-get install sudo

Change to another user or super-user
	
	su <username>
	su

Create a GROUP user42

	sudo groupadd user42
	cat /etc/group			[Checking created group]
	
	sudo usermod -aG user42 amorcill
		-a -> add
		-G -> group

	groups					[Check if the user is in the group]
	groups <username>		[Checking, same]

Create an USER and add in the sudo group

	sudo adduser <username>
	sudo adduser <username> <groupname>
	
	passwd						[To change passwd in the user]	

	getent passwd <username>	[Checking]
	chage -l <username>			[Info about passwd]



# SSH (Secure Shell) and UFW (Uncomplicated Firewall)

	apt-get install openssh-server

## /etc/ssh/sshd_config
Config the ssh-server-file sshd_config, add the port 4242 and disable ssh login as root

	Add		-> Port 4242
	Remove 	-> #PermitRootLogin prohibit-password
	Add		-> PermitRootLogin no

## UFW

	apt-get install ufw
	ufw allow 4242
	ufw enable
	ufw status


# Password Policy

## /etc/login.defs

	# Password has to expire every 30 days
	PASS_MAX_DAYS   30

	# The minimum number of days allowed before the modification of a password willbe set to 2
	PASS_MIN_DAYS   2

	# The user has to receive a warning message 7 days before their password expires
	PASS_WARN_AGE   7


Checking the changes in the user
	
	chage -l <username>

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
	minlen = 10
	
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

**should looks like:**

	password	requisite	pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root

## Update passwds

	passwd			[Change passwd for actual user]
	sudo passwd		[Change pass for root]

To update the passwd policy in the users that are already in the system, it must be changed manually by the admin.

	# Check the passwd status
	chage -l <username>
	
	# Password has to expire every 30 days
	sudo chage -M <days> <username>
	
	# The minimum number of days allowed before the modification of a password willbe set to 2
	sudo chage -m <days> <username>

	# The user has to receive a warning message 7 days before their password expires
	sudo chage -W <days> <username>


# Sudo Stricts Rules #visudo to edit **/etc/sudoers**
Authentication using sudo has to be limited to 3 attempts in the event of an incorrect password

	Defaults        passwd_tries=3

A custom message of your choice has to be displayed if an error due to a wrong password occurs when using sudo.

	#Defaults       badpass_message="Password is wrong, try it again!"
	Defaults        insults

Each action using sudo has to be archived, both inputs and outputs (Log sudo commands). The log file has to be saved in the/var/log/sudo/sudo.log 

	# Sudo log file, EXTRA.
	Defaults  log_host, log_year, logfile="/var/log/sudo/sudo.log"
	
The TTY mode has to be enabled for security reasons

	Defaults        requiretty

For security reasons too, the paths that can be used by sudo must be restricted. 
Example:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

	Defaults   secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"


# Monitoring.sh
At server startup, the script will display some information on all terminals every 10 minutes. Schedule the task with cron and send masage with wall.
See the monitoring.sh script.
	
	# Cpu load needed to install (mpstat).
	sudo apt-get install sysstat
	# Or this 
	cat /proc/cpuinfo or cat /proc/stat (nothing to install)

	# Net tools.
	sudo apt install net-tools
	# or use the command
	ss -s (nothing to install)

## Cron

	sudo crontab -e

	#chedule a cron to execute on every 10 minutes
	*/10 * * * * /etc/monitoring.sh

	sudo service cron status


# More commands

	id <username>			[Print info about the user]
	id -nG <username>
	ip address				[Ip address]	
	dpkg -l | grep ssh		[Check if the package is installed]
	
	systemctl status ssh	[Check for the status of the service or restart]
	
	service sudo restart
	service ssh restart		[Check for the status of the service or restart, equal]

