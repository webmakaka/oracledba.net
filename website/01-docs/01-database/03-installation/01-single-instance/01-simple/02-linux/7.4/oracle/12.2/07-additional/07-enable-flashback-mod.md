---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Enable FLASH BACK Mode
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Enable FLASH BACK Mode
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, FLASH BACK
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/enable-flashback-mod/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Enable FLASH BACK Mode

<br/>

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
