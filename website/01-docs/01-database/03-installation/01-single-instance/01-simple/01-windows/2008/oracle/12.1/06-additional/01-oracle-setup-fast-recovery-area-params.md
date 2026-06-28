---
layout: page
title: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Setting FAST RECOVERY AREA Parameters
description: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Setting FAST RECOVERY AREA Parameters
keywords: Oracle DataBase, Installation, Windows 2008, FAST RECOVERY AREA, FRA
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-setup-fast-recovery-area-params/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server]</a>: Setting FAST RECOVERY AREA Parameters

<br/>

Fast Recovery Area (FRA) is space for database backups and archived log files (if archiving of redo logs is enabled). It is necessary to ensure the database has enough space to write its data. If needed, it can be increased and/or cleared of outdated data. Cleaning should only be done using RMAN.

    sqlplus / as sysdba

<br/>

    SQL> show parameter db_recovery;

<br/>

    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- -----------
    db_recovery_file_dest                string
    db_recovery_file_dest_size           big integer 0

<br/>

    SQL> alter system set db_recovery_file_dest_size="20G";

<br/>

    SQL> alter system set db_recovery_file_dest="f:\app\oracle\oradata\ora121\backups";

<br/>

    SQL> show parameter db_recovery;

<br/>

    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    db_recovery_file_dest                string      f:\app\oracle\oradata\ora121\backups
    db_recovery_file_dest_size           big integer 20G
