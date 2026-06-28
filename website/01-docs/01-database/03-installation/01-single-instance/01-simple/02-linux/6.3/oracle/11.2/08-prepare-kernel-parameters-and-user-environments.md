---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Configuring System Users and System Parameters
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Configuring System Users and System Parameters
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Configuring System Users, System Parameters
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/prepare-kernel-parameters-and-user-environments/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Configuring System Users and System Parameters

Before making changes to configuration files, it is recommended to create backup copies:

    # {
    cp /etc/sysctl.conf /etc/sysctl.conf.bkp
    cp /etc/security/limits.conf /etc/security/limits.conf.bkp
    cp /etc/pam.d/login /etc/pam.d/login.bkp
    cp /etc/profile /etc/profile.bkp
    }

Creating users and groups

Create groups:

    # groupadd -g 1000 oinstall
    # groupadd -g 1001 dba
    # groupadd -g 1002 oper

Create user oracle11, assign it to the dba and oinstall groups, and set its home directory to /home/oracle11

    # useradd \
    -g oinstall \
    -G dba \
    -d /home/oracle11 \
    -m oracle11

Set a password for user oracle11

    # passwd oracle11

Modifying kernel parameters and database administrator account parameters

1. Edit the /etc/sysctl.conf file

It is recommended to comment out (put a # sign before them) any existing kernel.shmmax and kernel.shmall parameters. They will later be added as parameters along with the other Oracle parameters.

    # sed -i.gres "s/kernel.shmmax/#kernel.shmmax/g" /etc/sysctl.conf
    # sed -i.gres "s/kernel.shmall/#kernel.shmall/g" /etc/sysctl.conf

<br/>

    # vi /etc/sysctl.conf

<br/>

kernel.shmmax = RAM (in bytes) / 2  
2104307712 / 2 = 1052153856

<br/>

The amount of RAM in bytes can be found with the command

    # free -b

<br/>

    2104307712

Add the following kernel parameters to the end of the document.

    ############################################
    #### Kernel Parameters for Oracle 11

    	kernel.sem = 250 32000 100 128
    	kernel.shmall = 2097152
    	kernel.shmmax = 1052153856
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

2.  Edit the /etc/security/limits.conf file

        	# vi /etc/security/limits.conf

Add the following lines

    ############################################
    #### Settings required for Oracle 11

    	oracle11 soft nproc 2047
    	oracle11 hard nproc 16384
    	oracle11 soft nofile 1024
    	oracle11 hard nofile 65536
    	oracle11 soft stack 10240
    	oracle11 hard stack 32768

    ############################################

3.  Edit the /etc/pam.d/login file

        	# vi /etc/pam.d/login

Add the following lines

    ############################################
    #### Settings required for Oracle 11

        session required pam_limits.so
    ############################################

4.  Edit the /etc/profile file

        	# vi /etc/profile

Before

    unset i
    unset pathmunge

Add

    ############################################
    #### Shell limits for Oracle 11 user accounts

            if [ $USER = "oracle11" ]; then
            ulimit -u 16384 -n 65536
            fi
    ############################################

5.  Edit the /home/oracle11/.bash_profile file

        	#  vi /home/oracle11/.bash_profile

After

    # User specific environment and startup programs

Add

    ############################################
    #### Oracle Parameters

        umask 022

        export ORACLE_BASE=/u01/oracle
        export ORACLE_HOME=$ORACLE_BASE/database/11.2
        export ORACLE_SID=ora112
        export ORACLE_UNQNAME=ora112
        export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
        export NLS_DATE_FORMAT="DD.MM.YYYY HH24:MI:SS"

        export PATH=$PATH:$ORACLE_HOME/bin
        export LD_LIBRARY_PATH=$ORACLE_HOME/lib

    	alias sqlplus='rlwrap sqlplus'
    	alias rman='rlwrap rman'

    ############################################

Apply kernel parameters without rebooting with the following command:

    # sysctl -p

Apply the variables defined in the .bash_profile file to the current bash session with the following command:

    # source ~/.bash_profile

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
