---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Final Backup (Hot Backup)
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Final Backup (Hot Backup)
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, hot backup
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-final-hot-backup/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Final Backup (Hot Backup):

<br/>

    $ mkdir -p /u02/oracle/oradata/12.2/${ORACLE_SID}/scripts

<br/>

    $ cd /u02/oracle/oradata/12.2/${ORACLE_SID}/scripts

<br/>

    $ vi rmanscript.rman

<br/>

```
RUN {
    CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;
    BACKUP FULL DATABASE TAG "FULL_DATABASE" PLUS ARCHIVELOG TAG "FULL_DATABASE_ARCHIVELOGS";
    BACKUP CURRENT CONTROLFILE TAG "FULL_DATABASE_CONTROLFILE";
    BACKUP SPFILE TAG "FULL_DATABASE_SPFILE";
}
```

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

Now I tell RMAN to delete obsolete backups (without confirmation).

    RMAN> delete noprompt obsolete;

<br/>

    RMAN> list backup of database summary;

    List of Backups
    ===============
    Key     TY LV S Device Type Completion Time     #Pieces #Copies Compressed Tag
    ------- -- -- - ----------- ------------------- ------- ------- ---------- ---
    1       B  F  A DISK        14/08/2017 14:31:28 1       1       NO         FULL_DATABASE_DATAFILES
    8       B  F  A DISK        14/08/2017 15:15:39 1       1       YES        FULL_DATABASE

<br/>

    RMAN>  quit
