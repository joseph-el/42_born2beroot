<h1 align="center">
	42 BORN2BE_ROOT 
</h1>

<p align="center">
	<b><i>WORLD OF VIRTUALISATION 🌒</i></b><br>
<p align="center">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/joseph-el/42_born2beroot?color=lightblue" />
	<img alt="Code language count" src="https://img.shields.io/github/languages/count/joseph-el/42_born2beroot?color=yellow" />
	<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/joseph-el/42_born2beroot?color=blue" />
	<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/joseph-el/42_born2beroot?color=green" />
 
 
<h3 align="center">
	<a href="#%EF%B8%8F-about">ENJOY</a>
 </h3>
 
---

## 💡 About Project

> _Born2beroot (42cursus). This project aims to introduce you to the wonderful world of virtualization.
  
  
### Step 1: Installing sudo

Switch to root by following command:

	$>su -
	$>Password: (root password)

First one you need to install text edito (VIM) by the following  command :

	$>apt-get update
	$>apt-get install vim

Install sudo via .

	$>apt install sudo

### Step 2: Adding User to sudo Group

Add user to sudo group by following command :

	$>adduser <user> sudo

Verify whether user was successfully 

	$>cat /etc/group | grep sudo

### Step 3: Configuring sudo

Configure  sudo by :
	$>sudo vi /etc/sudoers.d/

To limit authentication using sudo to 3 attempts (defaults to 3 anyway).

	Defaults        passwd_tries=3

To add a custom error message for badpassword:

	Defaults        badpass_message="you message here"

To log all sudo commands:

	$>sudo mkdir /var/log/sudo
	
	Defaults        logfile="/var/log/sudo/sudo.log"

To archive all sudo inputs & outputs :

	Defaults        log_input,log_output

To require TTY:

	Defaults        requiretty

To set _sudo_ paths to `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin`:

	Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

## SSH

### Step 1: Installing & Configuring SSH

Install openssh-server.

	$>sudo apt install openssh-server

Configure SSH via :

	$>sudo vi /etc/ssh/sshd_config

To set up SSH using Port 4242, replace below line:

	line15 #Port 22

with:

	line15 Port 4242

To disable SSH login as root ,replace below line

	line34 #PermitRootLogin prohibit-password

with:

	line34 PermitRootLogin no

Check SSH status via `sudo service ssh status`.

	$>sudo systemctl status sshd

Alternatively, check SSH status via `systemctl status ssh`.

	$>systemctl status ssh

### Step 2: Installing & Configuring UFW

Install ufw :

	$>sudo apt-get install ufw

Enable Firewall by :

	$>sudo ufw enable

Allow incoming connections using Port 4242 :

	$>sudo ufw allow 4242

Check UFW status :

	$>sudo ufw status

### Step 3: Connecting to Server via SSH

SSH into your virtual machine using Port 4242 via `ssh <username>@<ip-address> -p 4242`.

	$>ssh <your uuser here>@<ip-address> -p 4242

## User Management

### Step 1: Setting Up a Strong Password Policy

#### Password Age

Configure password age policy

	$>sudo vi /etc/login.defs

To set password to expire every 30 days, replace below line

	line160 PASS_MAX_DAYS   99999

with:

	line160 PASS_MAX_DAYS   30

To set minimum number of days between password changes to 2 days, replace below line

	line161 PASS_MIN_DAYS   0

with:

	line161 PASS_MIN_DAYS   2

To send user a warning message 7 days :

	line162 PASS_WARN_AGE   7

#### Password Strength

Secondly, to set up policies in relation to password strength :

	$>sudo apt install libpam-pwquality

Configure password strength policy, specifically the below line:

	$>sudo vi /etc/pam.d/common-password
	
	add the following line :
	
	line25 password        requisite                       pam_pwquality.so retry=3

To set password minimum length to 10 characters

	minlen=10

To require password to contain at least an uppercase character and a numeric character:

	ucredit=-1 dcredit=-1

To set a maximum of 3 consecutive identical characters:

	maxrepeat=3

To reject the password if it contains `<username>` in some form:

	reject_username

To set the number of changes required in the new password from the old password to 7:

	difok=7

To implement the same policy on root:

	enforce_for_root

### Step 2: Creating a New Group

Create new user42 group :

	$>sudo addgroup user42

Add user to user42 group :

	$>sudo adduser <your user> user42

Verify whether user was successfully added :

	$>cat /etc/group | grep user42

## cron

#### Setting Up a cron Job

Configure cron

	$>sudo crontab -u root -e

To schedule a shell script to run every 10 minutes, replace below line

	line23 # m h  dom mon dow   command

with:

	 */10 * * * * bash "path of ur script"
	 
For check cron (1 min \ 1 min) replace 10 by 1 like :

	 */1 * * * * bash "path of ur script"

# Bonus

##PART ONE

### Step 1: Installing Lighttpd

Install lighttpd

	&>sudo apt install lighttpd

Allow incoming connections using Port 80

	$>sudo ufw allow 80

### Step 2: Installing & Configuring MariaDB

Install mariadb-server

	$>sudo apt install mariadb-server

Start interactive script to remove insecure default settings

	$>sudo mysql_secure_installation
	Enter current password for root (enter for none): #Just press Enter (do not confuse database root with system root)
	Set root password? [Y/n] n
	Remove anonymous users? [Y/n] Y
	Disallow root login remotely? [Y/n] Y
	Remove test database and access to it? [Y/n] Y
	Reload privilege tables now? [Y/n] Y

Log in to the MariaDB console 

	$>sudo mariadb

Create new database 

	MariaDB [(none)]> CREATE DATABASE <DATA BASE NAME>;

Create new database user and grant them full privileges on the newly-created database

	MariaDB [(none)]> GRANT ALL ON <database-name>.* TO '<username-2>'@'localhost' IDENTIFIED BY '<password-2>' WITH GRANT OPTION;

Flush the privileges

	MariaDB [(none)]> FLUSH PRIVILEGES;

Exit the MariaDB shell

	MariaDB [(none)]> exit

Verify whether database user was successfully created by logging in to the MariaDB 

	$ mariadb -u <username-2> -p
	Enter password: <password-2>
	MariaDB [(none)]>

Confirm whether database user has access to the database via `SHOW DATABASES;`.

	MariaDB [(none)]> SHOW DATABASES;
	+--------------------+
	| Database           |
	+--------------------+
	| <joseph>.          |
	| information_schema |
	+--------------------+

### Step 3: Installing PHP

Install php-cgi & php-mysql .

	$>sudo apt install php-cgi php-mysql


### Step 4: Downloading & Configuring WordPress

Install wget

	$>sudo apt install wget

Download WordPress to `/var/www/html`

	$>sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html

Extract downloaded content 
	$>sudo tar -xzvf /var/www/html/latest.tar.gz

Copy content of `/var/www/html/wordpress` to `/var/www/html`

	$>sudo cp -r /var/www/html/wordpress/* /var/www/html

Create WordPress configuration file from its sample

	$>sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

Configure WordPress to reference previously-created MariaDB database & user

	$>sudo vi /var/www/html/wp-config.php

Replace the below

	line23 define( 'DB_NAME', 'database_name_here' );
	line26 define( 'DB_USER', 'username_here' );
	line29 define( 'DB_PASSWORD', 'password_here' );

with:

	line23 define( 'DB_NAME', '<database-name>' );
	line26 define( 'DB_USER', '<username-2>' );
	line29 define( 'DB_PASSWORD', '<password-2>' );

### Step 5: Configuring Lighttpd

Enable below modules

	$>sudo lighty-enable-mod fastcgi
	$>sudo lighty-enable-mod fastcgi-php
	$>sudo service lighttpd force-reload

#PART TWO

# 3: File Transfer Protocol (FTP)

### Step 1: Installing & Configuring FTP

Install FTP server 

	$>sudo apt install vsftpd

Install FTP client

	$>sudo apt install ftp

Allow incoming connections using Port 21 and 20

	$>sudo ufw allow 21
	$>sudo ufw allow 20

Configure vsftpd

	$>sudo vi /etc/vsftpd.conf

To enable any form of FTP write command, uncomment below line:

	line31 #write_enable=YES

To set root folder for FTP-connected user 

	$>sudo mkdir /home/<username>/ftp
	$>sudo mkdir /home/<username>/ftp/files
	$>sudo chown nobody:nogroup /home/<username>/ftp
	$>sudo chmod a-w /home/<username>/ftp

Add these lines to the top of vsftpd.conf 

	user_sub_token=$USER
	local_root=/home/$USER/ftp

To prevent user from accessing files or using commands outside the directory tree, uncomment below line:

	line114 #chroot_local_user=YES

To whitelist FTP, add below lines:

	$>sudo vi /etc/vsftpd.userlist

To add your username, save and leave the file

	$>echo <username> | sudo tee -a /etc/vsftpd.userlist

Add these lines to the file vsftpd.userlist

	userlist_enable=YES
	userlist_file=/etc/vsftpd.userlist
	userlist_deny=NO

### Step 2: Connecting to Server via FTP

FTP into your virtual machine

	$>ftp ip-address 

Terminate FTP session at any time by exit in FTP shell
