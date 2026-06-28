---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring System Users, System Parameter Settings
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring System Users, System Parameter Settings
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Configuring System Users, System Parameter Settings
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/prepare-kernel-parameters-and-user-environments/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Configuring System Users, System Parameter Settings

Before making changes to configuration files, it is recommended to make backup copies:

    # {
        cp /etc/sysctl.conf /etc/sysctl.conf.bkp.$(date +%Y-%m-%d)
        cp /etc/security/limits.conf /etc/security/limits.conf.bkp.$(date +%Y-%m-%d)
        cp /etc/pam.d/login /etc/pam.d/login.bkp.$(date +%Y-%m-%d)
        cp /etc/profile /etc/profile.bkp.$(date +%Y-%m-%d)
    }

### Creating users and groups

Create groups:

    # groupadd -g 1000 oinstall
    # groupadd -g 1001 dba
    # groupadd -g 1002 oper

Create user oracle12, specify that he will be in groups dba and oinstall and his home directory will be /home/oracle12

    # useradd \
    -g oinstall \
    -G dba,oper \
    -d /home/oracle12 \
    -m oracle12

Set password for user oracle12

    # passwd oracle12

Changing kernel parameters and account parameters with database administrator rights

1. Edit the /etc/sysctl.conf file

It is recommended to comment out (put a # in front of them) the existing kernel.shmmax and kernel.shmall parameters. Then they will be added as parameters together with the rest of the Oracle parameters. To do this, run the following commands:

    # sed -i.gres "s/kernel.shmmax/#kernel.shmmax/g" /etc/sysctl.conf
    # sed -i.gres "s/kernel.shmall/#kernel.shmall/g" /etc/sysctl.conf

<br/>

    # vi /etc/sysctl.conf

<br/>

    kernel.shmmax = RAM (in bytes) / 2

<br/>

The number of bytes of RAM can be found with the command

    # free -b
    4152623104 / 2 = 2076311552

Add the following kernel parameters to the end of the /etc/sysctl.conf file.

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

2.  Edit the /etc/security/limits.conf file

        	# vi /etc/security/limits.conf

Add the following lines

    ############################################
    #### Settings required for Oracle 12

    oracle12 soft nproc 2047
    oracle12 hard nproc 16384
    oracle12 soft nofile 1024
    oracle12 hard nofile 65536
    oracle12 soft stack 10240
    oracle12 hard stack 32768

    ############################################

3.  Edit the /etc/pam.d/login file

        	# vi /etc/pam.d/login

Add the following lines

    ############################################
    #### Settings required for Oracle 12

    session required pam_limits.so
    ############################################

4.  Edit the /etc/profile file

        	# vi /etc/profile

Before

    unset i
    unset pathmunge

Add

    ###########################################
    #### Shell limits for Oracle 12 user accounts

    if [ $USER = "oracle12" ]; then
    ulimit -u 16384 -n 65536
    fi
    ############################################

Apply kernel parameters without rebooting with the following command:

    # sysctl -p

5. Edit the /home/oracle/.bash_profile file

    # su - oracle12

<br/>

    $  vi ~/.bash_profile

After

    # User specific environment and startup programs

Add

```
############################################
#### Oracle 12 Parameters

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
```

Apply variables defined in the .bash_profile file to the current bash session with the following command:

    $ source ~/.bash_profile
