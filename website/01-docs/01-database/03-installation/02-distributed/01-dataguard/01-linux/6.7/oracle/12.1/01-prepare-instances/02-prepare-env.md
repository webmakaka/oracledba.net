---
layout: page
title: Preliminary steps for environment setup
description: Preliminary steps for environment setup
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/prepare-env/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Preliminary steps for environment setup

### The following steps are performed on Primary and Standby

I keep forgetting where the server hostname is set

    # vi /etc/sysconfig/network

**After renaming, it is better to reboot the server or apply the changes somehow, otherwise the configs will have something wrong and you will have to fix them later**

<br/>

Installing the scp package for copying data between servers on both nodes

    # yum install -y openssh-clients

<br/>

    # vi /etc/hosts

<br/>

    ## Localdomain and Localhost

    127.0.0.1 localhost.localdomain localhost


    ## DataBases

    # moscow - primary; piter - standby

    192.168.1.11 moscow.localdomain moscow
    192.168.1.12 piter.localdomain piter

<br/>

**PRIMARY (moscow)**

    $ vi ~/.bash_profile

<br/>

```
#######################################################
#### Oracle 12.1 Parameters ###########################

	umask 022

	export ORACLE_BASE=/u01/oracle
	export ORACLE_HOME=$ORACLE_BASE/database/12.1

	export GRID_HOME=$ORACLE_BASE/grid/12.1

	export ORACLE_SID=orcl12
	export ORACLE_UNQNAME=master
	export NLS_LANG=AMERICAN_AMERICA.AL32UTF8

	export PATH=$PATH:$ORACLE_HOME/bin:$GRID_HOME/bin
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib

	export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss'


	# rlwrap aliases

	alias sqlplus='rlwrap sqlplus'
	alias rman='rlwrap rman'
	alias asmcmd='rlwrap asmcmd'
	alias dgmgrl='rlwrap dgmgrl'

	# my alases

	alias alert='tail -f $ORACLE_BASE/diag/rdbms/$ORACLE_SID/$ORACLE_SID/trace/alert_$ORACLE_SID.log'

#### Oracle 12.1 Parameters ###########################
#######################################################
```

<br/>

    $ source ~/.bash_profile

<br/>

**Standby (piter)**

The only difference is in ORACLE_UNQNAME and the alert.log path
(The alert.log path changes when the duplicate is created. Need to fix this later)

<br/>

    $ vi ~/.bash_profile

<br/>

```
#######################################################
#### Oracle 12.1 Parameters ###########################

	umask 022

	export ORACLE_BASE=/u01/oracle
	export ORACLE_HOME=$ORACLE_BASE/database/12.1

	export GRID_HOME=$ORACLE_BASE/grid/12.1

	export ORACLE_SID=orcl12
	export ORACLE_UNQNAME=slave
	export NLS_LANG=AMERICAN_AMERICA.AL32UTF8

	export PATH=$PATH:$ORACLE_HOME/bin:$GRID_HOME/bin
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib

	export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss'


	# rlwrap aliases

	alias sqlplus='rlwrap sqlplus'
	alias rman='rlwrap rman'
	alias asmcmd='rlwrap asmcmd'
	alias dgmgrl='rlwrap dgmgrl'

	# my alases

	alias alert='tail -f $ORACLE_BASE/diag/rdbms/$ORACLE_SID/$ORACLE_SID/trace/alert_$ORACLE_SID.log'

#### Oracle 12.1 Parameters ###########################
#######################################################
```

<br/>

    $ source ~/.bash_profile
