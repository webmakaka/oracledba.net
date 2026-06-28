---
layout: page
title: Introductory information about backing up Oracle databases
description: Introductory information about backing up Oracle databases
keywords: Oracle DataBase, backups, резервное копирование
permalink: /database/backup-and-restore/oracle-database-backup/
---

# Introductory information about backing up Oracle databases

<br/>

Blah, blah, blah. You should always make backups, otherwise it will be like the picture "He dropped the database and didn't make backups".

Backups should be performed automatically, according to established rules. The administrator should intervene if something goes wrong, not every time a backup is needed.

It is recommended to occasionally restore a copy of the database from backups to make sure everything is up to date, and you should always have a prepared recovery procedure.

Backups should be stored on a different server, preferably not in the same room. If this is not possible, they should be stored on a different disk than the one where the database files are stored.

Backing up Oracle databases involves creating backup copies of data files, control files, and archived log files.
Additionally, the backup set may include spfile, init.ora, listener.ora and tnsnames.ora files

Backup is performed:

<ul>
<li>Using operating system tools. </li>
<li>Using RMAN (Recovery Manager). </li>
</ul>

For centralized storage of backups for a large number of databases, Oracle offers the Oracle Catalog - another database created specifically for backups (What is stored in it, I cannot say yet. I have never used it). For some reason I thought backups were stored in it. But I started to doubt this.

In addition to backups, you can export the desired schema to a file. It can then be imported as desired. No other files are needed except the dump file itself.

<br/>

### ARCHIVELOG and NOARCHIVELOG modes

Oracle records all changes made to data blocks in memory to online redo logs, and does this, as a rule, before writing them to database files. During the recovery process, Oracle uses the changes recorded in these log files to bring the database to a current state. Oracle supports two modes for managing such files.

<ul>
<li>Archive log mode (ARCHIVELOG). In this mode, Oracle saves (archives) filled redo logs. Therefore, no matter how long ago the backup was performed, if ARCHIVELOG mode is used, the database can always be restored to any point in time using archived logs. </li>

<li>
No archive log mode (NOARCHIVELOG). In this mode, filled redo logs are overwritten rather than saved. This consequently means that in NOARCHIVELOG mode, recovery can only be performed from a backup copy and all other changes that were made to the database after the backup will be lost. This mode only allows recovery after a database instance failure. In the event of media problems (e.g., disk loss), a database running in NOARCHIVELOG mode can only be restored from a backup and, naturally, with the loss of all changes made to it since the backup was created. </li>
</ul>

Almost all production databases run in ARCHIVELOG mode. NOARCHIVELOG mode is used only when data can be recovered from other sources, or when the database is still only in development or testing and therefore does not need the ability to recover its data to the minute.

<br/>

### Full or partial database backup

You can back up either the entire database or just a part of it, such as a tablespace or data file. Note that when the database is running in NOARCHIVELOG mode, you cannot perform partial database backups unless all the tablespaces and files to be backed up are read-only. You can perform a whole database backup in both ARCHIVELOG and NOARCHIVELOG modes.

Most often, a full backup is performed. It involves copying not only all data files, but also another important file – the control file. Without the control file, Oracle will not open the database, so for recovery, in addition to backup copies of all data files, you must also have the latest backup copy of the control file.

<br/>

### Consistent and inconsistent backup

Consistent backup creates consistent backup copies and does not require a recovery process. When using a backup to restore a database or part of it (e.g., a tablespace or data file), you usually first need to restore the data from the backup (i.e., the RESTORE procedure), and then restore the database to working order (i.e., the RECOVER procedure). In the case of consistent backup, neither of these recovery steps is required. In the case of inconsistent backup, these recovery steps are always mandatory.

Oracle assigns a unique System Change Number (SCN) to each transaction. Each commit, for example, will increase this number. Whenever Oracle sets a checkpoint, all changed data in online data files is written to disk. And whenever this happens, Oracle updates the thread checkpoint in the control file. During this update, Oracle makes all read-write data files and control files consistent with the same SCN number. A database is considered consistent when the SCN numbers stored in the headers of all data files are identical and match the data file header information contained in the control files. The main thing to remember is that the same SCN number must be present in all data files and the control file (or files). The presence of an identical SCN number means that the data files contain data for the same time period. If the data is consistent, no recovery steps are needed after returning (or copying) the set of backup files to their original location.

To create a consistent database backup, you must either shut down (with a normal SHUTDOWN or SHUTDOWN TRANSACTIONAL command, but not SHUTDOWN ABORT), or stop (using a graceful shutdown command) and start again in mount mode.

When performing an inconsistent backup, the backup files contain data from different time periods. The fact is that most production systems cannot be interrupted for a consistent backup. Instead, these databases must run 24 hours a day, 7 days a week. This consequently means that backing up these databases must be done online, i.e., while they remain open for transactions. Changes to data files by users during backup is what leads to inconsistent backups. Performing an inconsistent backup does not mean getting incorrect backups. However, during recovery, simply returning such backups to their original location is not enough. In addition to returning them, you must also apply all archived and online redo logs that were created between the time of the backup and the point to which you need to recover the database. Oracle will read these files and automatically apply all necessary changes to the backup files.

Since only inconsistent backup can be performed with an open database, most production databases use strategies based on inconsistent backup procedures.

<br/>

### Open and closed database backup

Open backup, also called online backup or hot/warm backup, involves creating backups while the database is open and available to users. You can perform an online backup of the entire database (as well as just a tablespace or data file) only if the database is running in ARCHIVELOG mode. It cannot be performed when the database is running in NOARCHIVELOG mode.

Closed backup, also called cold backup, involves creating backups while the database is closed (stopped). Such backup always results in consistent backups, unless the database was stopped with the SHUTDOWN ABORT command.

<br/>

### Physical and logical backup

From a technical point of view, Oracle backup procedures can be divided into logical and physical. Logical backup means creating backups using the Data Pump Export utility, which contain logical objects such as tables and procedures. These backups are saved in a special binary format, and data from them can only be extracted using the Data Pump Import utility.

Physical backup means creating backups of key Oracle database files, i.e., data files, archived redo log files, and control files. These backups can be stored on both disk and tape drives<br/><br/>

<br/>

### Backup levels

Below are the levels at which Oracle database backups can be performed:

<ul>
<li>Whole database level. This level involves backing up all files, including the control file. Whole database backup can be performed in both ARCHIVELOG and NOARCHIVELOG modes. </li>
<li>Tablespace level. This level involves backing up all data files belonging to a specific tablespace. Backup at this level is only allowed when using ARCHIVELOG mode. </li>
<li>Datafile level. This level involves backing up a single data file. Backup at this level is only allowed when using ARCHIVELOG mode. </li>
</ul>
