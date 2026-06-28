---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Final Backup (Hot Backup)
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Final Backup (Hot Backup)
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Hot backup
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-final-hot-backup/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Final Backup (Hot Backup)

    $ mkdir -p /u02/oracle/oradata/12.1/${ORACLE_SID}/scripts

<br/>

    $ cd /u02/oracle/oradata/12.1/${ORACLE_SID}/scripts

<br/>

    $ vi rmanscript.rman

<br/>

    RUN {
    CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;
    BACKUP FULL DATABASE TAG "FULL_DATABASE" PLUS ARCHIVELOG TAG "FULL_DATABASE_ARCHIVELOGS";
    BACKUP CURRENT CONTROLFILE TAG "FULL_DATABASE_CONTROLFILE";
    BACKUP SPFILE TAG "FULL_DATABASE_SPFILE";
    }

Check the syntax of the created script file

    $ rman CHECKSYNTAX @rmanscript.rman

Run the backup script

    $ rman target / @rmanscript.rman

<br/>

### View the list of backups

    RMAN> rman target /

<br/>

    RMAN> list backup of database summary;

<br/>

With the following command, I specify that all backups except the last one should be marked as obsolete.

    RMAN> CONFIGURE RETENTION POLICY TO REDUNDANCY 1;

Now I ask RMAN to delete obsolete backups (without confirmation).

    RMAN> delete noprompt obsolete;

<br/>

    RMAN> list backup of database summary;

<br/>

    RMAN>  quit
