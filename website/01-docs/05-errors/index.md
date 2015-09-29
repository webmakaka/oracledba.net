---
layout: page
title: INS-32148 - Execution of 'GI Install' script failed on nodes
permalink: /docs/errors/ins-32148/Execution-of-GI-Install-script-failed-on-nodes/
---


# Oracle RAC 12 with ASM, ISCSI, Device-Mapper


### [INS-32148] Execution of 'GI Install' script failed on nodes: [rac2]


	Action - Review the log files '/u01/app/oraInventory/logs/installActions2015-08-28_01-05-05AM.log' and '/u01/app/grid/12.1/cfgtoollogs/crsconfig/rootcrs_<nodename>_<timestamp>.log' for further details on failure.  More Details
	Execution of GI Install script is successful on nodes : [rac1]  Execution of GI Install script is failed on nodes : [rac2]  Exception details  - PRCZ-2009 : Failed to execute command "/u01/app/grid/12.1/root.sh" as root within 3,600 seconds on nodes "rac2"

	# /u01/app/grid/12.1/root.sh
	Performing root user operation.

	The following environment variables are set as:
	    ORACLE_OWNER= oracle12
	    ORACLE_HOME=  /u01/app/grid/12.1
	   Copying dbhome to /usr/local/bin ...
	   Copying oraenv to /usr/local/bin ...
	   Copying coraenv to /usr/local/bin ...

	Entries will be added to the /etc/oratab file as needed by
	Database Configuration Assistant when a database is created
	Finished running generic part of root script.
	Now product-specific root actions will be performed.
	Using configuration parameter file: /u01/app/grid/12.1/crs/install/crsconfig_params
	2015/08/28 01:56:25 CLSRSC-4001: Installing Oracle Trace File Analyzer (TFA) Collector.

	2015/08/28 01:56:25 CLSRSC-4002: Successfully installed Oracle Trace File Analyzer (TFA) Collector.

	2015/08/28 01:57:04 CLSRSC-507: The root script cannot proceed on this node rac2 because either the first-node operations have not completed on node rac1 or there was an error in obtaining the status of the first-node operations.

	Died at /u01/app/grid/12.1/crs/install/crsutils.pm line 3681.
	The command '/u01/app/grid/12.1/perl/bin/perl -I/u01/app/grid/12.1/perl/lib -I/u01/app/grid/12.1/crs/install /u01/app/grid/12.1/crs/install/rootcrs.pl ' execution failed


<br/>

### Solution:


Edit on each nodes file:

	# vi /etc/sysconfig/oracleasm

	ORACLEASM_SCANORDER=”dm”
	ORACLEASM_SCANEXCLUDE=”sd”

Restart asmlib service on all nodes except 1st node:

	# /etc/init.d/oracleasm restart


<br/>

Deconfigure failed service on nodes except 1st node:

	# /u01/app/grid/12.1/crs/install/rootcrs.pl  -verbose -deconfig -force
	Using configuration parameter file: /u01/app/grid/12.1/crs/install/crsconfig_params
	PRCR-1070 : Failed to check if resource ora.net1.network is registered
	CRS-0184 : Cannot communicate with the CRS daemon.
	PRCR-1070 : Failed to check if resource ora.helper is registered
	CRS-0184 : Cannot communicate with the CRS daemon.
	PRCR-1070 : Failed to check if resource ora.ons is registered
	CRS-0184 : Cannot communicate with the CRS daemon.

	2015/08/28 02:02:24 CLSRSC-4006: Removing Oracle Trace File Analyzer (TFA) Collector.

	2015/08/28 02:02:48 CLSRSC-4007: Successfully removed Oracle Trace File Analyzer (TFA) Collector.

	Failure in execution (rc=-1, 0, No such file or directory) for command /etc/init.d/ohasd deinstall
	2015/08/28 02:02:49 CLSRSC-336: Successfully deconfigured Oracle Clusterware stack on this node



<br/>

Run root.sh again on the 2nd node (or other nodes):

    # /u01/app/grid/12.1/root.sh
    Performing root user operation.

    The following environment variables are set as:
        ORACLE_OWNER= oracle12
        ORACLE_HOME=  /u01/app/grid/12.1
       Copying dbhome to /usr/local/bin ...
       Copying oraenv to /usr/local/bin ...
       Copying coraenv to /usr/local/bin ...

    Entries will be added to the /etc/oratab file as needed by
    Database Configuration Assistant when a database is created
    Finished running generic part of root script.
    Now product-specific root actions will be performed.
    Using configuration parameter file: /u01/app/grid/12.1/crs/install/crsconfig_params
    2015/08/28 02:03:25 CLSRSC-4001: Installing Oracle Trace File Analyzer (TFA) Collector.

    2015/08/28 02:03:53 CLSRSC-4002: Successfully installed Oracle Trace File Analyzer (TFA) Collector.

    OLR initialization - successful

    2015/08/28 02:07:48 CLSRSC-330: Adding Clusterware entries to file 'oracle-ohasd.conf'

    CRS-4133: Oracle High Availability Services has been stopped.
    CRS-4123: Oracle High Availability Services has been started.
    CRS-4133: Oracle High Availability Services has been stopped.
    CRS-4123: Oracle High Availability Services has been started.
    CRS-2791: Starting shutdown of Oracle High Availability Services-managed resources on 'rac2'
    CRS-2673: Attempting to stop 'ora.drivers.acfs' on 'rac2'
    CRS-2677: Stop of 'ora.drivers.acfs' on 'rac2' succeeded
    CRS-2793: Shutdown of Oracle High Availability Services-managed resources on 'rac2' has completed
    CRS-4133: Oracle High Availability Services has been stopped.
    CRS-4123: Starting Oracle High Availability Services-managed resources
    CRS-2672: Attempting to start 'ora.mdnsd' on 'rac2'
    CRS-2672: Attempting to start 'ora.evmd' on 'rac2'
    CRS-2676: Start of 'ora.evmd' on 'rac2' succeeded
    CRS-2676: Start of 'ora.mdnsd' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.gpnpd' on 'rac2'
    CRS-2676: Start of 'ora.gpnpd' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.gipcd' on 'rac2'
    CRS-2676: Start of 'ora.gipcd' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.cssdmonitor' on 'rac2'
    CRS-2676: Start of 'ora.cssdmonitor' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.cssd' on 'rac2'
    CRS-2672: Attempting to start 'ora.diskmon' on 'rac2'
    CRS-2676: Start of 'ora.diskmon' on 'rac2' succeeded
    CRS-2676: Start of 'ora.cssd' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.cluster_interconnect.haip' on 'rac2'
    CRS-2672: Attempting to start 'ora.ctssd' on 'rac2'
    CRS-2676: Start of 'ora.ctssd' on 'rac2' succeeded
    CRS-2676: Start of 'ora.cluster_interconnect.haip' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.asm' on 'rac2'
    CRS-2676: Start of 'ora.asm' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.storage' on 'rac2'
    CRS-2676: Start of 'ora.storage' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.crf' on 'rac2'
    CRS-2676: Start of 'ora.crf' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.crsd' on 'rac2'
    CRS-2676: Start of 'ora.crsd' on 'rac2' succeeded
    CRS-6017: Processing resource auto-start for servers: rac2
    CRS-2672: Attempting to start 'ora.ASMNET1LSNR_ASM.lsnr' on 'rac2'
    CRS-2672: Attempting to start 'ora.net1.network' on 'rac2'
    CRS-2676: Start of 'ora.net1.network' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.ons' on 'rac2'
    CRS-2676: Start of 'ora.ASMNET1LSNR_ASM.lsnr' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.asm' on 'rac2'
    CRS-2676: Start of 'ora.ons' on 'rac2' succeeded
    CRS-2673: Attempting to stop 'ora.LISTENER_SCAN1.lsnr' on 'rac1'
    CRS-2677: Stop of 'ora.LISTENER_SCAN1.lsnr' on 'rac1' succeeded
    CRS-2673: Attempting to stop 'ora.scan1.vip' on 'rac1'
    CRS-2677: Stop of 'ora.scan1.vip' on 'rac1' succeeded
    CRS-2672: Attempting to start 'ora.scan1.vip' on 'rac2'
    CRS-2676: Start of 'ora.scan1.vip' on 'rac2' succeeded
    CRS-2672: Attempting to start 'ora.LISTENER_SCAN1.lsnr' on 'rac2'
    CRS-2676: Start of 'ora.LISTENER_SCAN1.lsnr' on 'rac2' succeeded
    CRS-2676: Start of 'ora.asm' on 'rac2' succeeded
    CRS-6016: Resource auto-start has completed for server rac2
    CRS-6024: Completed start of Oracle Cluster Ready Services-managed resources
    CRS-4123: Oracle High Availability Services has been started.
    2015/08/28 02:14:34 CLSRSC-343: Successfully started Oracle Clusterware stack

    Preparing packages for installation...
    cvuqdisk-1.0.9-1
    2015/08/28 02:14:53 CLSRSC-325: Configure Oracle Grid Infrastructure for a Cluster ... succeeded

<br/>

After all, i returned on Installation window and pressed retry.  
After some time, installation has been completed Successfully.

<br/>

I spent for this error huge time.  
That is the reason why i decided to share solution.

<br/><br/>

You may also read Metalink Doc for Oracle11:  
11GR2 GRID INFRASTRUCTURE INSTALLATION FAILS WHEN RUNNING ROOT.SH ON NODE 2 OF RAC [ID 1059847.1]
