# 42Born2beRoot -- Defense

# Debian vs CentOS
Debian is easy and more familiar. More easy bla bla ...


# AppArmor
For debian.
AppArmor provides **Mandatory Access Control (MAC) security**. AppAmor allows the system administrator to restrict the actions that processes can perform.


# SELinux (Security-Enhanced Linux)
For CentOS. Like AppArmor.


# Apt vs Aptitute
In Debian-based OS distributions, the default package manager we can use is **dpkg**. This tool allows us to install, remove and manage programs on our operating system. However, in most cases, these programs come with a list of dependencies that must be installed for the main program to function properly.

**APT (Advanced Package Tool)**, which is a tool that uses dpkg, can be used to install all the necessary dependencies when installing a program.  
**Aptitude** a graphical interface packege tool.


# LVM (Logical Volume Manager)


# Sudo


# Su


# SSH (Secure Shell) and UFW (Uncomplicated Firewall)

	

## /etc/ssh/sshd_config

## UFW

# Password Policy

## /etc/login.defs

## /etc/pam.d/common-password
**PAM** module to check password strength
Your password must be at least 10 characters long. It must contain an uppercaseletter and a number. It must not contain more than 3 consecutive identical characters. The password must not include the name of the user. 

The following rule does not apply to the root password: The password must have at least 7 characters that are not part of the former password.
Of course, your root password has to comply with this polic



Note: -y flag means to assume yes and silently install, without asking you questions in most cases. 

File to edit /etc/pam.d/common-password and add.
	


# Creating New User

	
# Groups user42 and sudo

	
# Sudo Stricts Rules

## 	#visudo to edit **/etc/sudoers**
Info in the web https://www.tecmint.com/sudoers-configurations-for-setting-sudo-in-linux/

# Monitoring.sh
At server startup, the script will display some information on all terminals every 10 minutes. Schedule the task with cron and send masage with wall.
See the monitoring.sh script.

