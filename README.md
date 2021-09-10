# 42Born2beRoot

**Born2BeRoot** is about administration a linux system on a virtual machine.

# Debian vs CentOS
Debian is easy and more familiar. CentOS no more mantenance.

# SELinux (Security-Enhanced Linux)
For CentOS.

https://debian-handbook.info/browse/stable/sect.selinux.html

# AppArmor
For debian. Running at the  start.
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
In Debian-based OS distributions, **the default package manager we can use is dpkg**. This tool allows us to install, remove and manage programs on our operating system. However, in most cases, these programs come with a list of dependencies that must be installed for the main program to function properly. One option is to manually install these dependencies. 

**APT (Advanced Package Tool)**, which is a tool that uses dpkg, **can be used to install all the necessary dependencies when installing a program**. So now we can install a useful program with a single command.
APT can work with different back-ends and fron-ends to make use of its services. One of them is **apt-get**, which **allows us to install and remove packages**. Along with apt-get, there are also many tools like apt-cache to manage programs. In this case, **apt-get and apt-cache are used by apt**. Thanks to apt we can install .deb programs easily and without worrying about dependencies. 

But in case we want to use a graphical interface, we will have to use aptitude. **Aptitude also does better control of dependencies**, allowing the user to choose between different dependencies when installing a program.


# LVM (Logical Volume Manager)
https://wiki.debian.org/LVM

For the installation and partitions:
https://www.youtube.com/watch?v=2w-2MX5QrQw 	

https://www.systutorials.com/docs/linux/man/8-lvrename/
	 lvrename - Rename a logical volume

### Commands
	lsblk

# SUDO
	apt-get install sudo

To add an user in the sudo group

	sudo usermod -aG sudo <username>

To check if it added. (groups in the system: /etc/group)

	getent group <username>

To see the groups from an user

	groups
	groups <username>

# SU
Change to another user or super user
	
	su <username>


# ID
Print info about the user
	id <username>
	id -nG <username>

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


# Groups user42 and sudo

	groupadd user42
	sudo usermod -aG user42 amorcill
		-a -> add
		-G -> group

sudo group is by default in the system. It is done before.


# Another commands

	ip address
	
Check if the package is really installed

	 dpkg -l | grep ssh

Check for the status of the service or restart

	systemctl status ssh
	
	service ssh restart


# cron & wall
Once we know a little more about how to build a server inside a Virtual Machine (remember that you also have to look in other pages apart from this README), we will see two commands that will be very helpful in case of being system administrators. These commands are:
- **Cron:** Linux task manager that allows us to execute commands at a certain time. We can automate some tasks just by telling cron what command we want to run at a specific time. For example, if we want to restart our server every day at 4:00 am, instead of having to wake up at that time, cron will do it for us.
- **Wall:** command used by the root user to send a message to all users currently connected to the server. If the system administrator wants to alert about a major server change that could cause users to log out, the root user could alert them with wall. 

# References
- https://www.youtube.com/watch?v=2w-2MX5QrQw 				[install debian]
  
- https://githubmemory.com/repo/hanshazairi/42-born2beroot	[reading]

- https://github.com/HEADLIGHTER/Born2BeRoot-42				[good]

- https://github.com/pgomez-a/born2beroot					[info]

- https://baigal.medium.com/born2beroot-e6e26dfb50ac		[super]
  