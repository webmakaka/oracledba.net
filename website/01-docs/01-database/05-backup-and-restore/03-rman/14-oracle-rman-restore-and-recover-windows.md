---
layout: page
title: Restoring from backups using RMAN (Recovery Manager) Example from Windows telegram chat
description: Restoring from backups using RMAN (Recovery Manager) Example from Windows telegram chat
keywords: Oracle Database, RMAN, Restore, Example from Windows telegram chat, Oracle 11, Windows Server
permalink: /database/backup-and-restore/rman/oracle-rman-restore-and-recover-windows/
---

# Restoring from backups using RMAN (Recovery Manager) Example from Windows telegram chat

<br/>

Oracle 11, Windows Server

<br/>

**Relevance:**  
30.03.2022

<br/>

Yes, need to figure it out to understand what and how.

<br/>

```
I'll try to describe my tasks, actions, and problems in detail.
I need to deploy a database from certain ready-made backups on a new server.
The number of disks and their names differ from the original server.

OS Windows
on the new server, Oracle 11g is installed and a database was created during installation. It is empty.
There is a full incremental backup level 0,
 and one subsequent incremental cumulative backup level 1
archive.log included in backup

Restoring the backups themselves (2 folders with backup files) to the server was done from tape.

A pfile was created from the spfile of the source database. Adjusted according to new paths and names.

On the new server, a series of commands was run to deploy from backup:

1. Startup nomount pfile -my pfile

2. RESTORE CONTROLFILE FROM  - backup file with control file.

3. ALTER DATABASE MOUNT;

4. catalog start with '\my backupset'

5. run the script

run {
SET NEWNAME FOR DATABASE   TO  '\oradata\my_sid\%b';
SET NEWNAME FOR tempfile  1 TO  '\oradata\my_sid\%b';
restore database;
switch datafile all;
switch tempfile all;
}

Today I see that restore was successful.


But I'm afraid to run the next step

run {
set until sequence xxxxx thread 1;
recover database;
} alter database open resetlogs;
```

<br/>

https://t.me/oracledba_net/16630

<br/>

See previous messages.
