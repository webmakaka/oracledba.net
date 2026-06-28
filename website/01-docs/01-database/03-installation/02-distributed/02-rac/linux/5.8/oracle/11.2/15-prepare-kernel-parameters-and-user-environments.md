---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Changing kernel parameters and database administrator account parameters
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Changing kernel parameters and database administrator account parameters
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Changing kernel parameters and database administrator account parameters
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/prepare-kernel-parameters-and-user-environments/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Changing kernel parameters and database administrator account parameters

<br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Editing config files</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2</strong></span></td>
	</tr>
</table>

1. Edit the /etc/sysctl.conf file

It is recommended to comment out (put a # sign before them) the existing kernel.shmmax and kernel.shmall parameters. They will later be added as parameters along with the other Oracle parameters.

    # sed -i.gres "s/kernel.shmmax/#kernel.shmmax/g" /etc/sysctl.conf
    # sed -i.gres "s/kernel.shmall/#kernel.shmall/g" /etc/sysctl.conf

<br/>

    # vi /etc/sysctl.conf

<br/>

kernel.shmmax = 50% of RAM (in bytes) / 2

<br/>

The amount of RAM in bytes can be found by running the command

    # free -b

Add the following kernel parameters to the end of the file.

    #################################################
    #### New Oracle Kernel Parameters

    		kernel.sem = 250 32000 100 128

    		kernel.shmall = 2097152
    		kernel.shmmax = 2073176064
    		kernel.shmmni = 4096
    		fs.file-max = 6815744
    		fs.aio-max-nr = 1048576
    		net.ipv4.ip_local_port_range = 20000 65500
    		net.core.rmem_default = 262144
    		net.core.rmem_max = 4194304
    		net.core.wmem_default = 262144
    		net.core.wmem_max = 1048586
    		vm.min_free_kbytes = 23168
    ################################################

Apply kernel parameters with the command

    # sysctl -p

2. Edit the /etc/security/limits.conf file

   # vi /etc/security/limits.conf

<br/>

    ################################################
    # Settings required for Oracle 11

    		oracle11 soft nproc 2047
    		oracle11 hard nproc 16384
    		oracle11 soft nofile 1024
    		oracle11 hard nofile 65536
    		oracle11 soft stack 10240
    		oracle11 hard stack 32768
    ################################################

3. Edit the /etc/pam.d/login file

   # vi /etc/pam.d/login

<br/>

    ################################################
    # Settings required for Oracle

    	session required pam_limits.so
    ################################################

4. Edit the /etc/profile file

   # vi /etc/profile

Before

unset i  
unset pathmunge

Add:

    ################################################
    # Shell limits for Oracle 11 user accounts

    		if [ $USER = "oracle11" ]; then
    		ulimit -u 16384 -n 65536
    		fi
    ################################################

<br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Configuring oracle11 user environment parameters on cluster nodes</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1</strong></span></td>
	</tr>
</table>

5. Edit the /home/oracle11/.bash_profile file

The ORACLE_SID and ORACLE_UNQNAME values must be unique on each cluster node. Otherwise the configs are the same.

    #  vi /home/oracle11/.bash_profile

Сразу после:

    # User specific environment and startup programs


    ############################################
    #### Oracle Parameters node1

       umask 022

       # Different Parameters

        export ORACLE_SID=racnode1
        export ORACLE_UNQNAME=racnode1
        export ORACLE_HOSTNAME=node1.localdomain

       # Grid

        export GRID_HOME=/u01/app/grid/11.2
        export CRS_HOME=${GRID_HOME}/crs

       # DataBase

       export ORACLE_BASE=/u01/app/oracle
       export ORACLE_HOME=${ORACLE_BASE}/product/rac/11.2

       # NLS

       export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
       export NLS_DATE_FORMAT="DD.MM.YYYY HH24:MI:SS"

       # Other
       export ORACLE_OWNER=oracle11

       # Alias

        alias sqlplus='rlwrap sqlplus'
        alias rman='rlwrap rman'

       # Path

       export LD_LIBRARY_PATH=$ORACLE_HOME/lib
       export PATH=$PATH:$ORACLE_HOME/bin:$GRID_HOME/bin:$CRS_HOME/bin


    	if [ $TERM = 'xterm' ]; then
    	read -p 'Select Oracle Instance: [RAC | ASM]. Type "asm" if you want to work with ASM:' RESPONCE
    	 if [ "$RESPONCE" == "asm" ]; then
    		export ORACLE_SID=+ASM1
    		export ORACLE_HOME=$GRID_HOME

    	fi

    	echo "ORACLE_SID=$ORACLE_SID"

    ############################################

<br/><br/>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node2</strong></span></td>
	</tr>
</table>

    #  vi /home/oracle11/.bash_profile

<br/>

    ############################################
    #### Oracle Parameters node2

       umask 022

       # Different Parameters

        export ORACLE_SID=racnode2
        export ORACLE_UNQNAME=racnode2
        export ORACLE_HOSTNAME=node2.localdomain

       # Grid

        export GRID_HOME=/u01/app/grid/11.2
        export CRS_HOME=${GRID_HOME}/crs

       # DataBase

       export ORACLE_BASE=/u01/app/oracle
       export ORACLE_HOME=${ORACLE_BASE}/product/rac/11.2

       # NLS

       export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
       export NLS_DATE_FORMAT="DD.MM.YYYY HH24:MI:SS"

       # Other
       export ORACLE_OWNER=oracle11

       # Alias

        alias sqlplus='rlwrap sqlplus'
        alias rman='rlwrap rman'

       # Path

       export LD_LIBRARY_PATH=$ORACLE_HOME/lib
       export PATH=$PATH:$ORACLE_HOME/bin:$GRID_HOME/bin:$CRS_HOME/bin


    	if [ $TERM = 'xterm' ]; then
    	read -p 'Select Oracle Instance: [RAC | ASM]. Type "asm" if you want to work with ASM:' RESPONCE
    	 if [ "$RESPONCE" == "asm" ]; then
    		export ORACLE_SID=+ASM2
    		export ORACLE_HOME=$GRID_HOME
    	fi

    	echo "ORACLE_SID=$ORACLE_SID"

    ############################################

Apply the parameters to the current bash console session with the following command:

    # source ~/.bash_profile
