---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Creating a Backup of the Created Database (Cold Backup)
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Creating a Backup of the Created Database (Cold Backup)
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, cold backup
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-cold-backup/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Creating a Backup of the Created Database (Cold Backup)

<br/>

Run the following commands:

    $ rman target /

<br/>

    RMAN> shutdown immediate;
    RMAN> startup mount;

<br/>

    RMAN> BACKUP DATABASE TAG "FULL_DATABASE_DATAFILES";
    RMAN> BACKUP CURRENT CONTROLFILE TAG "FULL_DATABASE_CONTROLFILE";
    RMAN> BACKUP SPFILE TAG "FULL_DATABASE_SPFILE";

<br/>

    RMAN> alter database open;

<br/>

    RMAN> quit

<br/>

    $ sqlplus / as sysdba

Get information about FRA usage

    SQL> SELECT
        TO_CHAR(SPACE_USED, '999,999,999,999') AS "Used",
        TO_CHAR(SPACE_LIMIT - SPACE_USED + SPACE_RECLAIMABLE, '999,999,999,999')
           AS "Free",
        ROUND((SPACE_USED - SPACE_RECLAIMABLE)/SPACE_LIMIT * 100, 1)
           AS "Used %"
        FROM V$RECOVERY_FILE_DEST;

<br/>

    Used		 Free		      Used %
    ---------------- ---------------- ----------
         868,876,288   20,616,609,792	   4

<br/>

    SQL> quit
