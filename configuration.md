# 42Born2beRoot -- Configuration

# AppArmor
AppAmor allows to restrict the actions that processes can perform on individual applications, by program profile.

	apt install apparmor [or] apt-get install apparmor
	apt install apparmor-utils

	aa-status
	apparmor_status				[equal to aa-status]

	systemctl status apparmor
	systemctl enable apparmor
	systemctl disable apparmor

# Dpkg, Apt and Aptitute

In Debian-based OS distributions, the default package manager we can use is **dpkg** is a lower level than apt. This tool allows us to install, remove and manage programs on our operating system. However, these programs come with a list of dependencies(more packages) that must be installed for the main program to function properly.

**APT (Advanced Package Tool)** used to download and install packages from online repositories. Which is a tool that uses dpkg, used to install all the necessary dependencies when installing a program.

**Aptitude** a graphical interface package tool.

	apt-get install aptitude
	aptitude					[start the app]


# LVM (Logical Volume Manager)
For the installation and partitions:
https://www.youtube.com/watch?v=2w-2MX5QrQw 	

	lsblk

**LVM** divides one disk into multiple partitions in Linux and connects it to a specific directory using a file system. 

You can also manage disk capacity more flexibly by dividing partitions into volumes, which are logical concepts. A volume resides in a single partition by default, but multiple partitions can be managed as a single volume. Therefore, it is easy to merge or split multiple partitions.

**Partitions** are fixed and have a strong physical concept, and once the size is set, it is difficult to change or add, and the OS treats each partition as a separate disk.

**Volumes** resides in a single partition on the disk and is more logically flexible than a partition. We use one disk by dividing it into several partitions. In this case, one volume may exist per partition, or only one volume may exist in several partitions.

The most basic way to use a disk in Linux is to divide the disk into partitions, mount it as a file system in each directory, and store data in a designated location for use.

Disk → Partition → Volume Group → Logical Group → File System (/home)

LVM When changing or adding disks, there is no need to touch the physical part, so you can use several disks together or use one disk divided as if it were several disks.

You can change the size of the partition in use or expand the capacity through simple operations after adding a disk.

LVM composition of:

	||-------------------------OS----------------------------||
	||-------------------------LVM---------------------------||
	||  LV-1 (/)    |LV-2 (swap)|  LV 3 (/home) | LV-4 (/tmp)|| Logical Volumes(LV)
	||------------------------------------------|------------||
	||                  VG 1                    |    VG 2    || Volume Groups(VG)
	||------------------------------------------|------------||
	||  /dev/sda2 |    /dev/sda3    | /dev/sdb2 | /dev/sdd4  || Physical Volumes(PV)
	||-------------------------------------------------------||


# Sudo, Su, adduser and groupadd

	apt-get install sudo
	dpkg -l | grep sudo
	
	Sudo Stricts Rules #visudo
	cat /var/log/sudo/sudo.log

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

	dpkg -l | grep ssh
	sudo service ssh status

**SSH** is a network protocol used to securely and safely to access a computer through network such as the Internet. SSH goes through an authentication process with the computer you want to access through a pair of keys. A pair of keys is:

    Private Key
    Public Key

A public key is a relatively secure key even if it is disclosed. Through this public key, the message is encrypted before being transmitted. Encryption is possible with the public key, but decryption is not possible.
The paired private key is a key that should never be exposed to the outside, and is stored inside your computer. The encrypted message can be decrypted using this private key.


## /etc/ssh/sshd_config
Config the ssh-server-file sshd_config, add the port 4242 and disable ssh login as root

	Add		-> Port 4242
	Remove 	-> #PermitRootLogin prohibit-password
	Add		-> PermitRootLogin no
	

## UFW

	apt-get install ufw
	dpkg -l | grep ufw
	sudo ufw status
	sudo service ufw status

	ufw allow 4242
	ufw enable
	ufw status
	ufw status numbered
	ufw delete <number>	[Delete ports 22]


# Password Policy
Need to edit this files:

	/etc/login.defs
	/etc/pam.d/common-password
	/etc/sudoers [sudo visudo]

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
Your password must be at least 10 characters long. It must contain an uppercase letter and a number. It must not contain more than 3 consecutive identical characters. The password must not include the name of the user. 

The following rule does not apply to the root password: The password must have at least 7 characters that are not part of the former password. Of course, your root password has to comply with this policy

Needed to install

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

To update the passwd-policy in the users that are already in the system, it must be changed manually by the admin.

	# Check the passwd status
	chage -l <username>
	
	# Password has to expire every 30 days
	sudo chage -M <days> <username>
	
	# The minimum number of days allowed before the modification of a password will be set to 2
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
At server startup, the script will display some information on all terminals every 10 minutes. Schedule the task with cron and send massage with wall.
See the monitoring.sh script.
	
	# Cpu load needed to install (mpstat).
	sudo apt-get install sysstat
	# Or this 
	cat /proc/cpuinfo or cat /proc/stat (nothing to install)

	# Net tools.
	sudo apt install net-tools
	# or use the command
	ss -s (nothing to install)


# Cron and wall
**Cron** Linux task manager that allows us to execute commands at a certain time. We can automate some tasks just by telling cron what command we want to run at a specific time. 

	sudo crontab -e

	#chedule a cron to execute on every 10 minutes
	*/10 * * * * /etc/monitoring.sh

	sudo service cron status

Stop the script without edit the cron file:

	ps aux | grep cron 		[Find the pid from cron task]
	kill -l 				[Find the right sign, 19=SIGSTOP]
	kill -19 <pid>			[Send the stop sign to cron to stop the monitoring script]



**Wall** command used by the root user to send a message to all users currently connected to the server. If the system administrator wants to alert about a major server change that could cause users to log out, the root user could alert them with wall.


# More commands

	id <username>			[Print info about the user]
	id -nG <username>
	ip address				[Ip address]	

	dpkg -l | grep ssh		[Check if the package is installed]
	
	systemctl status ssh	[Check for the status ssh of the service]
	service sudo restart
	service ssh restart
	