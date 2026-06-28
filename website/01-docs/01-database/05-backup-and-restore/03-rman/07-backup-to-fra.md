---
layout: page
title: RMAN script for backups. Backup to FRA
description: RMAN script for backups. Backup to FRA
keywords: Oracle Database, RMAN, creating backups, Backup to FRA
permalink: /database/backup-and-restore/rman/backup-to-fra/
---

# RMAN script for backups. Backup to FRA

<br/>

**Database in ARCHIVELOG mode**

<br/>

    $ mkdir -p $ORACLE_HOME/scripts

<br/>

    $ cd $ORACLE_HOME/scripts

<br/>

    $ vi backup-rman-script.rman

<br/>

```
RUN {

ALLOCATE CHANNEL c1 DEVICE TYPE DISK;

CONFIGURE RETENTION POLICY TO REDUNDANCY 1;
CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;

BACKUP FULL DATABASE TAG "FULL_DATABASE_DATAFILES";

SQL 'ALTER SYSTEM ARCHIVE LOG CURRENT';

BACKUP ARCHIVELOG ALL TAG "FULL_DATABASE_ARCHIVELOGS";

BACKUP CURRENT CONTROLFILE TAG "FULL_DATABASE_CONTROLFILE";

BACKUP SPFILE TAG "FULL_DATABASE_SPFILE";

DELETE NOPROMPT OBSOLETE;


CONFIGURE RETENTION POLICY CLEAR;
CONFIGURE BACKUP OPTIMIZATION CLEAR;
CONFIGURE DEVICE TYPE DISK CLEAR;

RELEASE CHANNEL c1;

}
```

Check syntax of the created script file

    $ rman CHECKSYNTAX @backup-rman-script.rman

Execute the backup script

    $ rman target / @backup-rman-script.rman

If using Oracle Catalog, the command may look like this

    $ rman target / catalog rman/rman123@rman12 @backup-rman-script.rman

<br/>

    RMAN> LIST BACKUPSET TAG="FULL_DATABASE_DATAFILES";

<br/>

```
RMAN> LIST BACKUP SUMMARY;


List of Backups
===============
Key     TY LV S Device Type Completion Time     #Pieces #Copies Compressed Tag
------- -- -- - ----------- ------------------- ------- ------- ---------- ---
48      B  F  A DISK        19/08/2015 15:34:49 1       1       YES        FULL_DATABASE_DATAFILES
50      B  A  A DISK        19/08/2015 15:35:03 1       1       YES        FULL_DATABASE_ARCHIVELOGS
51      B  F  A DISK        19/08/2015 15:35:07 1       1       YES        FULL_DATABASE_CONTROLFILE
52      B  F  A DISK        19/08/2015 15:35:08 1       1       YES        FULL_DATABASE_SPFILE
```

<br/>

    RMAN> list backupset summary;

<br/>
<br/>

### ALTER SYSTEM SWITCH LOGFILE vs ALTER SYSTEM ARCHIVE LOG CURRENT

What is the difference between the commands ALTER SYSTEM SWITCH LOGFILE and ALTER SYSTEM ARCHIVE LOG CURRENT?

At first glance, these commands do the same thing:

1. Trigger a checkpoint event
2. The LGWR process stops writing to the current log and starts writing to the next one
3. The ARCH process archives the old log

But they do it slightly differently.

**ALTER SYSTEM SWITCH LOGFILE** -
Works asynchronously and returns control to the calling session before ARCH archives the log. If RAC is used, it will only switch the log on the current instance.

**ALTER SYSTEM ARCHIVE LOG CURRENT** -
Waits for archiving to complete and returns control only when all 3 steps are completed. If RAC is used, it will switch and archive logs on all instances.

The main danger of using ALTER SYSTEM SWITCH LOGFILE in scripts (primarily in RMAN backup scripts) is the probability that due to the asynchronous nature of this command, control will be returned to the script immediately and the script will continue executing even though archiving has not yet completed. Thus, it is safer to always use ALTER SYSTEM ARCHIVE LOG CURRENT.

https://dba-notes.org/2011/11/18/alter-system-switch-logfile-vs-alter-system-archive-log-current/
