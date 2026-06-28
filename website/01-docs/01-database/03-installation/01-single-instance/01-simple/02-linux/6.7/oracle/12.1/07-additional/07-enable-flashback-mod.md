---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Enable FLASH BACK Mode
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Enable FLASH BACK Mode
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Enable FLASH BACK Mode
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/enable-flashback-mod/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Enable FLASH BACK Mode

FlashBack is useful when you need to roll back changes or view the previous state of objects in the database.
As a consequence, server load increases because additional information must be stored.

    $ sqlplus / as sysdba

<br/>

    SQL> shutdown immediate;
    SQL> startup mount exclusive;
    SQL> alter database flashback on;
    SQL> alter database open;

<br/>

    SQL> select flashback_on from v$database;

<br/>

    FLASHBACK_ON
    ------------------
    YES

UNDO_RETENTION - (with FLASHBACK enabled) determines the minimum time in seconds for which a change in the database can be undone (viewed). The data will be stored in UNDO_TABLESPACE (you must ensure sufficient tablespace size) and overwritten as needed, ensuring the minimum value specified in UNDO_RETENTION. Not supported for LOB.

<br/>

Set the UNDO_RETENTION parameter to 30 minutes

    SQL> alter system set UNDO_RETENTION = 1800;
    SQL> alter tablespace UNDO RETENTION GUARANTEE;

<br/>

    SQL> show parameter UNDO_RETENTION

<br/>

    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    undo_retention                       integer     1800

<br/>

    SQL> quit
