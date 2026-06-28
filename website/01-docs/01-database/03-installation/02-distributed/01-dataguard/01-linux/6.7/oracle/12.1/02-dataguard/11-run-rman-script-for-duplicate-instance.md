---
layout: page
title: Creating and executing RMAN script for duplicating primary
description: Creating and executing RMAN script for duplicating primary
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/run-rman-script-for-duplicate-instance/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Creating and executing RMAN script for duplicating primary

### On Primary

<br/>

    $ cd /tmp/

<br/>

    $ vi rmanscript.rman

<br/>

    run {
    	allocate channel prmy1 type disk;
    	allocate auxiliary channel stby type disk;
    	DUPLICATE TARGET DATABASE
    	  FOR STANDBY
    	  FROM ACTIVE DATABASE
    	  DORECOVER
    	  SPFILE

    		### SET ANY PARAMS FOR STANDBY

    		SET "db_unique_name"="slave"

    		### END of SET ANY PARAMS FOR STANDBY

    	  NOFILENAMECHECK;
    }

<br/>

I decided that it's better to create the duplicate and set the parameters later in the console. Therefore, there is only one set parameter in the script.

The nofilenamecheck parameter is needed so that RMAN does not complain about duplicate file names (if we use the same directory structure on the primary and standby servers).

The following example illustrates how to use DUPLICATE for active duplication. This example requires the NOFILENAMECHECK option because the primary database files have the same names as the standby database files. The SET clauses for SPFILE are required for log shipping to work properly. The db_unique_name must be set to ensure that the catalog and Data Guard can identify this database as being different from the primary.

RMAN automatically copies the server parameter file to the standby host, starts the auxiliary instance with the server parameter file, restores a backup control file, and copies all necessary database files and archived redo logs over the network to the standby host. RMAN recovers the standby database, but does not place it in manual or managed recovery mode.

DORECOVER option to recover the database after standby creation

http://docs.oracle.com/cd/B28359_01/server.111/b28294/rcmbackp.htm

If we want to place our standby database in directories different from those where the primary database is located, we will need additional parameters:

db_file_name_convert='/oradata_new/test','/oradata/test' - this parameter indicates that in the names of data files that will be created in the standby database (i.e., when our primary instance starts working in standby mode), the paths must be changed from '/oradata_new/test' to '/oradata/test'.

log_file_name_convert='/oradata_new/test/archive','/oradata/test/archive' - this parameter indicates that in the names of log files that will be created in the standby database, the paths must be changed from '/oradata_new/test/archive' to '/oradata/test/archive'.

<br/>

Let's check the script syntax.

    $ rman CHECKSYNTAX @rmanscript.rman

    ***
    The cmdfile has no syntax errors

Let's go:

    $ rman target sys/manager@primary auxiliary sys/manager@standby @rmanscript.rman

<br/>

    ***
    Finished Duplicate Db at 12-AUG-15
    released channel: prmy1
    released channel: stby

    Recovery Manager complete.

<!--

SQL>  select to_char(CURRENT_SCN) CURRENT_SCN FROM V$DATABASE;

-->

<br/>

### Error!

Sometimes an error occurred on primary.

    Oracle instance shut down

    connected to auxiliary database (not started)
    released channel: prmy1
    RMAN-00571: ===========================================================
    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
    RMAN-00571: ===========================================================
    RMAN-03002: failure of Duplicate Db command at 08/14/2015 06:42:26
    RMAN-05501: aborting duplication of target database
    RMAN-03015: error occurred in stored script Memory Script
    RMAN-04014: startup failed: ORA-00119: invalid specification for system parameter LOCAL_LISTENER
    ORA-00132: syntax error or unresolved network name 'LISTENER_ORCL12'

Fixed as follows:

    SQL> alter system set local_listener='(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = moscow.localdomain)(PORT = 1521)))' scope=both;
