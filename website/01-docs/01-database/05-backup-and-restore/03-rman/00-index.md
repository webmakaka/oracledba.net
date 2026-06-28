---
layout: page
title: Backup and Restore Oracle DataBase using RMAN
description: Backup and Restore Oracle DataBase using RMAN
keywords: Oracle database, backup, restore, rman
permalink: /database/backup-and-restore/rman/
---

# Backup and Restore Oracle DataBase using RMAN

<br/>

### General information

<ul>
    <li>
        <a href="/database/backup-and-restore/rman/about-oracle-rman/">RMAN Utility (Recovery Manager)</a>
    </li>
    <li>
        <a href="/database/backup-and-restore/rman/restore-points/">Working with restore points</a>
    </li>
    <li>
        <a href="/database/backup-and-restore/rman/rman-view/"> Basic RMAN views</a>
    </li>
    <li>
        <a href="/database/backup-and-restore/rman/low-space-in-fra/">Not enough free space in Fast Recovery Area</a>
    </li>
</ul>

<br/>

### Creating backups using Recovery Manager (RMAN)

<ul>
    <li>
        <a href="/database/backup-and-restore/rman/oracle-rman-backup/">Creating backups using RMAN</a>
    </li>
    <li>
        <a href="/database/backup-and-restore/rman/oracle-rman-backup-noarchivelog/">Creating backups using RMAN (NOARCHIVELOG)</a>
    </li>
    <li>
        <a href="/database/backup-and-restore/rman/backup-to-fra/">RMAN script for backups. Example 1. Backup to FRA (ARCHIVELOG)</a>
    </li>
    <li>
        <a href="/database/backup-and-restore/rman/backup-to-folder/">RMAN script for backups. Example 2. Backup to directory (ARCHIVELOG)</a>
    </li>
     <li>
        <a href="/database/backup-and-restore/rman/backup-sample-script/">Example shell script for backup</a>
    </li>
    <li>
        <a href="/database/backup-and-restore/rman/incremental-backup/">Creating an incremental database copy using RMAN</a>
    </li>
</ul>

<br/>

### Checks using RMAN (Recovery Manager)

<ul>
    <li>
        <a href="/database/backup-and-restore/rman/oracle-rman-check/">Checks using RMAN (Recovery Manager)</a>
    </li>
</ul>

<br/>

### Restoring from backups using RMAN (Recovery Manager)

<ul>
    <li>
        <a href="/database/backup-and-restore/rman/oracle-rman-restore-and-recover/">Restoring from backups using RMAN (Recovery Manager)</a>
    </li>
        <li>
        <a href="/database/backup-and-restore/rman/oracle-rman-restore-and-recover-windows/">Example from Windows telegram chat</a>
    </li>
</ul>

<br/>

### Deleting RMAN (Recovery Manager) objects

<ul>
    <li>
        <a href="/database/backup-and-restore/rman/oracle-rman-delete/">Deleting RMAN (Recovery Manager) objects</a>
    </li>
</ul>

<br/>

### Example with incarnations

<ul>
    <li>
        <a href="/database/backup-and-restore/rman/rman-incarnations-sample/">Example with incarnations</a>
    </li>
</ul>

<br/>

### RMAN Catalog (I haven't found a practical use for it yet)

<ul>
    <li>
        <a href="/database/backup-and-restore/rman/rman-catalog-installation/">Creating RMAN Catalog (For storing backup information in a special Oracle database)</a>
    </li>
    <li>
        <a href="/database/backup-and-restore/rman/change-db-unique-name-in-catalog/">Change db_unique_name in RMAN catalog</a>
    </li>
</ul>

<br/>

### Creating a database copy using RMAN

<ul>
    <li>
        <a href="/database/backup-and-restore/rman/duplicate-instance/duplicate-database-from-backup/">Creating a database copy from backup using RMAN on the same server</a>
    </li>
    <li>
        <a href="/database/backup-and-restore/rman/duplicate-instance/duplicate-active-database/">Creating a copy of an active database using RMAN</a>
    </li>
</ul>

<br/>

### Connecting in a bash script

```
// How to log into rman in a bash script, for example, with password !!PASSword!!
// Put the entire connection string in single quotes, password in double quotes
rman target 'sys/"!!PASSword!!"@MYBASE'
```

<br/>

### "Trendiest" RMAN script for creating Oracle backups. Sends telegram notifications about backup errors

https://github.com/wildmakaka/oracle-rman-with-telegram-notifications
