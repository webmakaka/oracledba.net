---
layout: page
title: Oracle DataBase 12c - Linux - Configure system users and kernel parameters
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/prepare-kernel-parameters-and-user-environments/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Configure system users and kernel parameters



Backup current config files:


	# {
	cp /etc/sysctl.conf /etc/sysctl.conf.bkp.$(date +%Y-%m-%d)
	cp /etc/security/limits.conf /etc/security/limits.conf.bkp.$(date +%Y-%m-%d)
	cp /etc/pam.d/login /etc/pam.d/login.bkp.$(date +%Y-%m-%d)
	cp /etc/profile /etc/profile.bkp.$(date +%Y-%m-%d)
	}

<br/>

### Creating users and groups

	# groupadd -g 1000 oinstall
	# groupadd -g 1001 dba
	# groupadd -g 1002 oper


We create user oracle12 and add user to groups. Home foler for this user will be /home/oracle

	# useradd \
	-g oinstall \
	-G dba,oper \
	-d /home/oracle12 \
	-m oracle12


Setup password for user oracle12

	# passwd oracle12


<br/>

### Change kernel parameters and back profile for user oracle12


1) Now we edit file  /etc/sysctl.conf


I recommend to comment next parameters by 2 next command:

	# sed -i.gres "s/kernel.shmmax/#kernel.shmmax/g" /etc/sysctl.conf
	# sed -i.gres "s/kernel.shmall/#kernel.shmall/g" /etc/sysctl.conf

<br/>

	# vi /etc/sysctl.conf

<br/>

	kernel.shmmax = RAM (in bytes) / 2

<br/>

Bytes of RAM you could get with command^

	# free -b
	4152623104 / 2 = 2076311552


In the end of file /etc/sysctl.conf add:

	############################################
	#### Kernel Parameters for Oracle 12

	kernel.sem = 250 32000 100 128
	kernel.shmall = 2097152
	kernel.shmmax = 2076311552
	kernel.shmmni = 4096
	fs.file-max = 6815744
	fs.aio-max-nr = 1048576
	net.ipv4.ip_local_port_range = 20000 65500
	net.core.rmem_default = 262144
	net.core.rmem_max = 4194304
	net.core.wmem_default = 262144
	net.core.wmem_max = 1048586
	vm.min_free_kbytes = 23168

	############################################



2) Edit file /etc/security/limits.conf

	# vi /etc/security/limits.conf


Add next:

	############################################
	#### Settings required for Oracle 12

	oracle12 soft nproc 2047
	oracle12 hard nproc 16384
	oracle12 soft nofile 1024
	oracle12 hard nofile 65536
	oracle12 soft stack 10240
	oracle12 hard stack 32768

	############################################


3)  Edit file /etc/pam.d/login

	# vi /etc/pam.d/login

Add next:

	############################################
	#### Settings required for Oracle 12

	session required pam_limits.so
	############################################



4) Edit file /etc/profile

	# vi /etc/profile


Before

	unset i
	unset pathmunge


Add next:

	###########################################
	#### Shell limits for Oracle 12 user accounts

	if [ $USER = "oracle12" ]; then
	ulimit -u 16384 -n 65536
	fi
	############################################


Apply kernel parameter to working server you could by next command:

	# sysctl -p


5) Edit file /home/oracle/.bash_profile


	# su - oracle12

<br/>

	$  vi /home/oracle/.bash_profile


После  

	# User specific environment and startup programs


Add next

	############################################
	#### Oracle Parameters

	umask 022

	export ORACLE_BASE=/u01/oracle
	export ORACLE_HOME=$ORACLE_BASE/database/12.1
	export ORACLE_SID=orcl12
	export ORACLE_UNQNAME=orcl12
	export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
	export NLS_DATE_FORMAT="DD.MM.YYYY HH24:MI:SS"

	export PATH=$PATH:$ORACLE_HOME/bin
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib

	export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss'

	alias sqlplus='rlwrap sqlplus'
	alias rman='rlwrap rman'

	############################################

Apply new parameters to current session you could by next command:

	$ source ~/.bash_profile
