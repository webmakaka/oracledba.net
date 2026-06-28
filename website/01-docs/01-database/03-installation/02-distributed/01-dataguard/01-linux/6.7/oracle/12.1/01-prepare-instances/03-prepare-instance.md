---
layout: page
title: Preliminary steps for configuring instance parameters
description: Preliminary steps for configuring instance parameters
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/prepare-instance/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Preliminary steps for configuring instance parameters

### Primary

<br/>

    SQL> show parameter db_name

    NAME				     TYPE	 VALUE
    ------------------------------------ ----------- ------------------------------
    db_name 			     string	 orcl12

<br/>

    SQL> show parameter db_unique_name

    NAME				     TYPE	 VALUE
    ------------------------------------ ----------- ------------------------------
    db_unique_name			     string	 master

<br/>

**ENABLE ARCHIVELOG**

    SQL> archive log list;
    Database log mode	       No Archive Mode
    Automatic archival	       Disabled
    Archive destination	       USE_DB_RECOVERY_FILE_DEST
    Oldest online log sequence     8
    Current log sequence	       10

<br/>

    SQL> shutdown immediate;
    SQL> startup mount;
    SQL> alter database archivelog;
    SQL> alter database open;

<br/>

    SQL> archive log list;
    Database log mode	       Archive Mode
    Automatic archival	       Enabled
    Archive destination	       USE_DB_RECOVERY_FILE_DEST
    Oldest online log sequence     8
    Next log sequence to archive   10
    Current log sequence	       10

<br/>

**ENABLE FORCE LOGGING**

Force logging mode is needed to force transaction writes to redo logs even for operations performed with the NOLOGGING option. Without this mode, some data files on the standby database may be corrupted because when applying archive logs, transaction data performed with the NOLOGGING option cannot be retrieved.

    SQL> select force_logging from v$database;

    FORCE_LOGGING
    ---------------------------------------
    NO

<br/>

    SQL> alter database force logging;

<br/>

    SQL> select force_logging from v$database;

    FORCE_LOGGING
    ---------------------------------------
    YES

<br/>

### View recent archive logs

    SQL> alter system switch logfile;

<br/>

    SQL> select name from v$archived_log;

    NAME
    --------------------------------------------------------------------------------
    +ARCH/MASTER/ARCHIVELOG/2015_08_12/thread_1_seq_8.260.887572251

<br/>

    $ cd ~
    $ . asm.sh

<br/>

    $ asmcmd

<br/>

    ASMCMD> ls
    ARCHIVELOG/
    CONTROLFILE/

    ASMCMD> cd ARCHIVELOG

    ASMCMD> cd 2015_08_12

    ASMCMD> ls
    thread_1_seq_9.260.887541937
