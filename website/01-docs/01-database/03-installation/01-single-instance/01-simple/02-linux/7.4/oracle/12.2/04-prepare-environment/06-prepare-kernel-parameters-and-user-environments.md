---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring System Users, System Parameter Settings
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring System Users, System Parameter Settings
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, creating users
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/prepare-kernel-parameters-and-user-environments/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Configuring System Users, System Parameter Settings

<br/>

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

<br/>

### Changing kernel parameters and account parameters with database administrator rights

    # echo 2076311552 > /proc/sys/kernel/shmmax

    # echo 6815744 > /proc/sys/fs/file-max
    # echo 1048576 > /proc/sys/fs/aio-max-nr


    # echo 262144 > /proc/sys/net/core/rmem_default
    # echo 4194304 > /proc/sys/net/core/rmem_max

    # echo 262144 > /proc/sys/net/core/wmem_default
    # echo 1048586 > /proc/sys/net/core/wmem_max

<br/>

    Apply kernel parameters without rebooting with the following command:

    	# sysctl -p

View the result:

    # sysctl -a | grep file-max

<br/>

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

<br/>

3.  Edit the /etc/pam.d/login file

        	# vi /etc/pam.d/login

Add the following lines

    ############################################
    #### Settings required for Oracle 12

    session required pam_limits.so
    ############################################

<br/>

4.  Edit the /etc/profile file

    # vi /etc/profile

At the end of the file before the following commands.

    unset i
    unset pathmunge

Add:

{% highlight shell %}

###########################################

#### Shell limits for Oracle 12 user accounts

if [ $USER = "oracle12" ]; then
ulimit -u 16384 -n 65536
fi
############################################

{% endhighlight %}

<br/>

5. Edit the /home/oracle/.bash_profile file

   # su - oracle12

<br/>

    $  vi ~/.bash_profile

After

    # User specific environment and startup programs

Add

{% highlight shell %}

############################################

#### Oracle 12 Parameters

umask 022

export ORACLE_BASE=/u01/oracle
export ORACLE_HOME=\$ORACLE_BASE/database/12.2
export ORACLE_SID=orcl12
export ORACLE_UNQNAME=orcl12
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export NLS_DATE_FORMAT="DD.MM.YYYY HH24:MI:SS"

export PATH=$PATH:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib

export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss'

alias sqlplus='rlwrap sqlplus'
alias rman='rlwrap rman'

############################################

{% endhighlight %}

Apply variables defined in the .bash_profile file to the current bash session with the following command:

    $ source ~/.bash_profile
