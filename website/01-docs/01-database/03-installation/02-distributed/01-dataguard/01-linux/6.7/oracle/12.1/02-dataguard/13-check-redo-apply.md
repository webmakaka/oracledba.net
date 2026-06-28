---
layout: page
title: Checking redo apply
description: Checking redo apply
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/check-redo-apply/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Checking redo apply

### Standby

First, let's see what state the instance is in

    SQL> select name,open_mode,log_mode from v$database;

    NAME	  OPEN_MODE	       LOG_MODE
    --------- -------------------- ------------
    ORCL12	  MOUNTED	       ARCHIVELOG

Then execute on primary and standby a query that shows the number of archive logs on the nodes:

    SQL> select max(sequence#) from v$archived_log;

<br/>

Then on primary, execute several times:

    SQL> ALTER SYSTEM SWITCH LOGFILE

And check the values on the nodes:

    SQL> select max(sequence#) from v$archived_log;

<br/>

    SQL> select recovery_mode from v$archive_dest_status;

    RECOVERY_MODE
    -----------------------
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE

Switch our standby database to Real-time apply redo mode:

    SQL> alter database recover managed standby database using current logfile disconnect;

Check the result:

    SQL> select recovery_mode from v$archive_dest_status;

    RECOVERY_MODE
    -----------------------
    MANAGED REAL TIME APPLY
    MANAGED REAL TIME APPLY
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE
    IDLE

<br/>

If we don't want to use Real-time apply redo mode, but want to wait until the next archive log is formed on the primary server and transferred to the standby for applying the transactions stored in it, then we need to switch our standby database to redo apply mode with:

    SQL> alter database recover managed standby database disconnect;

If something goes wrong, the first thing to do to fix the problem is to stop the log apply:

    SQL> alter database recover managed standby database cancel;

<br/>

### Open Standby Database Read Only

    SQL> shutdown immediate;
    SQL> startup mount;
    SQL> alter database open read only;

<br/>

    SQL> select name, open_mode, log_mode, database_role from v$database;

    NAME	  OPEN_MODE	       LOG_MODE     DATABASE_ROLE
    --------- -------------------- ------------ ----------------
    ORCL12	  READ ONLY WITH APPLY ARCHIVELOG   PHYSICAL STANDBY

<br/>

### Error:

    SQL> alter database open;
    alter database open
    *
    ERROR at line 1:
    ORA-10456: cannot open standby database; media recovery session may be in
    progress

<br/>

    SQL> alter database recover managed standby database cancel;

<br/>

    SQL> alter database open;

<br/>

    SQL> alter database recover managed standby database using current logfile disconnect;
