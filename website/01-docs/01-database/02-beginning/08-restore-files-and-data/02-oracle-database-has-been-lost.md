---
layout: page
title: Oracle Database file loss
description: Oracle Database file loss
keywords: Oracle Database, File loss
permalink: /docs/architecture/restore-files-and-data/oracle-database-has-been-lost/
---

# Some old information. Needs revision!

<br/>

Maybe someone will break something and describe step by step how they recovered it?

<br/>

### File Loss

<strong>Loss of a control file.</strong>

Recovery after losing a control file (as long as at least one copy remains intact) can be performed as follows:

1. If the instance has not already crashed, execute the SHUTDOWN ABORT command.
2. Copy one of the remaining control files to the location where the lost file was located and reflect this in the initialization parameter file. You can also simply remove the reference to the lost control file in the initialization parameter.
3. Start the instance.

<br/>

<strong>Loss of a log file.</strong>

Recovery after losing one member of a log group does not affect instance operation.

1. Determine which file is lost by checking the alert log.
2. Restore the lost file by copying one of the remaining files from the same group.
3. If the cause of the media failure is a damaged drive or controller, rename the lost file.
4. If the log group has already been archived or the database is in NOARCHIVELOG mode, you can resolve the problem by clearing the log group, which recreates the lost file or files. In EM, select the required group and the Clear Logfile operation, or execute the command

```
SQL> ALTER DATABASE CLEAR LOGFILE GROUP <group number>;
```

Note: Database Control will not allow clearing a group that has not yet been archived. Such an action breaks the log chain. If it is necessary, then immediately after this, a full backup of the entire database must be performed. Otherwise, data will be lost after the next failure. To clear an unarchived group, execute the command:

```
SQL> ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP <group number>;
```

<strong>Loss of a data file in NOARCHIVELOG mode.</strong>

Loss of any data file in a database operating in NOARCHIVELOG mode requires a full database recovery, including control files and all data files.

For a database in NOARCHIVELOG mode, recovery is only possible to the point of the last backup. Therefore, users must redo all changes made since the backup.

1. Stop the instance if it is not already stopped.
2. Click on the Perform Recovery link on the Maintenance page.
3. Select "Whole Database" recovery type.

<strong>Loss of a non-essential data file in ARCHIVELOG mode</strong>

For a database in ARCHIVELOG mode, loss of any data file that does not belong to the SYSTEM and UNDO tablespaces will only affect objects stored in the lost file. The rest of the database will remain accessible to users who continue working.

To restore the lost file:

1. Click on the Perform Recovery link on the Maintenance page.
2. Select "Datafiles" recovery type and "Restore to current time".
3. Add all files that need to be restored.
4. Specify where the files should be copied from backup: to the old location or to a new one (in case of disk or controller loss).
5. Submit the work to the RMAN utility for copying from backup and restoring the lost files.

Since the database is in ARCHIVELOG mode, recovery is possible up to the last commit and users will not need to re-enter data.

<strong>Loss of a system-critical data file.</strong>

Data files belonging to the SYSTEM tablespace or containing UNDO data are considered system-critical. Loss of one of these files requires database recovery to be performed in MOUNT state.

1. Stop the instance if it is not already stopped.
2. Mount the database.
3. Click on the Perform Recovery link on the Maintenance page.
4. Select "Datafiles" recovery type and "Restore to current time"
5. Add all files that need to be restored.
6. Specify where the files should be copied from backup: to the old location or to a new one.
7. Submit the work to the RMAN utility for copying from backup and restoring the lost files.
8. Open the database. Users do not need to re-enter data since the recovery was performed up to the last commit.
