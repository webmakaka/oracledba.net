---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Enable FLASH BACK Mode
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Enable FLASH BACK Mode
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Enable FLASH BACK Mode
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/enable-flashback-mod/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Enable FLASH BACK Mode

<br/>

FlashBack is useful when you need to roll back changes or view the previous state of objects in the database.
As a result, server load increases because additional information must be stored.

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

UNDO_RETENTION - (when FLASHBACK is enabled) determines the minimum time in seconds for which changes in the database can be undone (viewed). The data will be stored in the UNDO_TABLESPACE (you need to ensure sufficient tablespace size) and will be overwritten as needed, ensuring the minimum value specified in UNDO_RETENTION. Not supported for LOB.

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

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
