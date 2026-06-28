---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Enable ARCHIVELOG Mode
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Enable ARCHIVELOG Mode
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, ARCHIVELOG
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/enable-archivelog-mod/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Enable ARCHIVELOG Mode

<br/>

When operating in ARCHIVELOG mode, after redo-log switching, a copy of the log is archived and saved to disk. This allows you to roll back the database to a specific point in the past (e.g., to a specific time) if necessary. When operating in ARCHIVELOG mode, you can create database backups without stopping the database (hot backup). This mode requires allocating additional server resources, i.e., taking resources away from other processes. By default, this option is disabled.

    $ sqlplus / as sysdba

Check the database operating mode:

    SQL> select log_mode from v$database;

<br/>

    LOG_MODE
    ------------
    NOARCHIVELOG

<br/>

Enable archivelog (if disabled)

    SQL> shutdown immediate;
    SQL> startup mount exclusive;
    SQL> alter database archivelog;
    SQL> alter database open;

<br/>

    SQL> select log_mode from v$database;

<br/>

    LOG_MODE
    ------------------------------------
    ARCHIVELOG

Get additional information with the following command:

    SQL> ARCHIVE LOG LIST

<br/>

    Database log mode              Archive Mode
    Automatic archival             Enabled
    Archive destination            USE_DB_RECOVERY_FILE_DEST
    Oldest online log sequence     30
    Next log sequence to archive   32
    Current log sequence           32

<br/>

    SQL> quit
