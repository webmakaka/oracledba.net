---
layout: page
title: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Enable FLASH BACK Mode
description: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Enable FLASH BACK Mode
keywords: Oracle DataBase, Installation, Windows 2008, Enable FLASH BACK
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/enable-flashback-mod/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server]</a>: Enable FLASH BACK Mode

<br/>

FlashBack is useful when you need to roll back changes or view the previous state of objects in the database.
As a result, server load increases because additional information must be stored.

    sqlplus / as sysdba

<br/>

    SQL> shutdown immediate;
    SQL> startup mount exclusive;
    SQL> alter database flashback on;
    SQL> alter database open;

<br/>

    SQL> select flashback_on from v$database;

<br/>

```
FLASHBACK_ON
------------------
YES
```

<br/>

UNDO_RETENTION - (when FLASHBACK is enabled) determines the minimum time in seconds for which changes in the database can be undone (viewed). The data will be stored in the UNDO_TABLESPACE (you need to ensure sufficient tablespace size) and will be overwritten as needed, ensuring the minimum value specified in UNDO_RETENTION. Not supported for LOB.

Set the UNDO_RETENTION parameter to 30 minutes

    SQL> alter system set UNDO_RETENTION = 1800;
    SQL> alter tablespace UNDO RETENTION GUARANTEE;

<br/>

    SQL> show parameter UNDO_RETENTION

<br/>

```
NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
undo_retention                       integer     1800
```

<br/>

    SQL> quit
