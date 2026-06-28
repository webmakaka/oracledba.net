---
layout: page
title: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Final Backup (Hot Backup)
description: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Final Backup (Hot Backup)
keywords: Oracle DataBase, Installation, Windows 2008, Hot Backup
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-final-hot-backup/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server]</a>: Final Backup (Hot Backup)

<br/>

    CMD>
    CMD> e:
    CMD> md  E:\app\oracle\oradata\ora121\scripts
    CMD> cd E:\app\oracle\oradata\ora121\scripts

<br/>

    $ Create a file named rmanscript.rman

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

    rman CHECKSYNTAX @rmanscript.rman

Execute the backup script

    rman target / @rmanscript.rman

View the list of backups:

    RMAN> rman target /

<br/>

    RMAN> list backup of database summary;

<br/>

The following command tells RMAN to mark all backups except the last one as obsolete.

    RMAN> CONFIGURE RETENTION POLICY TO REDUNDANCY 1;

Now ask RMAN to delete obsolete backups (without confirmation).

    RMAN> delete noprompt obsolete;

<br/>

    RMAN> list backup of database summary;

<br/>

    RMAN>  quit
