---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Enable ARCHIVELOG Mode
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Enable ARCHIVELOG Mode
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Enable ARCHIVELOG Mode
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/enable-archivelog-mod/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Enable ARCHIVELOG Mode

<br/>

When working in ARCHIVELOG mode, after redo-log switching, a copy of the log is archived and saved on disk. This allows you to roll back the database to a specific point in the past (e.g., to a specific time) if necessary. In ARCHIVELOG mode, it is possible to create database backups without stopping the database (hot backup). In this mode, additional server resources must be allocated, i.e., resources are taken away from other processes. This option is disabled by default.

    $ sqlplus / as sysdba

Check the database operation mode:

    SQL> select log_mode from v$database;

<br/>

    LOG_MODE
    ------------
    NOARCHIVELOG

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

Additional information can be obtained with the following command:

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

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
