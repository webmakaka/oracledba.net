---
layout: page
title: Restoring from backups using RMAN (Recovery Manager)
description: Restoring from backups using RMAN (Recovery Manager)
keywords: Oracle Database, RMAN, Restore
permalink: /database/backup-and-restore/rman/oracle-rman-restore-and-recover/
---

# Restoring from backups using RMAN (Recovery Manager)

<br/>

### Get information about available backups.

    set pagesize 200;

    SELECT start_time, end_time, status
    FROM v$rman_backup_job_details order by 1 desc;

<br/>

### Get a list of files needed for recovery from backup.

    RMAN> RESTORE DATABASE PREVIEW SUMMARY;

<br/>

```
Starting restore at 13.04.2012 18:48:51
using channel ORA_DISK_1


List of Backups
===============
Key     TY LV S Device Type Completion Time     #Pieces #Copies Compressed Tag
------- -- -- - ----------- ------------------- ------- ------- ---------- ---
214     B  F  A DISK        13.04.2012 18:46:40 1       1       YES        FULL_DATABASE_BEFORE_UPGRADE
213     B  F  A DISK        13.04.2012 18:45:57 1       1       YES        FULL_DATABASE_BEFORE_UPGRADE
210     B  F  A DISK        13.04.2012 18:45:21 1       1       YES        FULL_DATABASE_BEFORE_UPGRADE
211     B  F  A DISK        13.04.2012 18:45:23 1       1       YES        FULL_DATABASE_BEFORE_UPGRADE
212     B  F  A DISK        13.04.2012 18:45:24 1       1       YES        FULL_DATABASE_BEFORE_UPGRADE

List of Archived Log Copies for database with db_unique_name ORA112
=====================================================================

Key     Thrd Seq     S Low Time
------- ---- ------- - -------------------
295     1    242     A 13.04.2012 18:45:06
        Name: /u02/oradata/ora112/archivelogs/1_242_0767676036.arc

Media recovery start SCN is 8639788
Recovery must be done beyond SCN 8639822 to clear datafile fuzziness
Finished restore at 13.04.2012 18:48:51
```

<br/><br/>

**Command:**<br/>

RESTORE DATABASE PREVIEW - provides a detailed report of all backup copies that will be needed for the successful execution of the RESTORE command.

    RMAN> RESTORE DATABASE PREVIEW;

<br/>

```
Starting restore at 13.04.2012 18:51:29
using channel ORA_DISK_1


List of Backup Sets
===================


BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ -------------------
214     Full    191.88M    DISK        00:00:40     13.04.2012 18:46:40
        BP Key: 226   Status: AVAILABLE  Compressed: YES  Tag: FULL_DATABASE_BEFORE_UPGRADE
        Piece Name: /u03/oracle_backups/fra/ORA112/backupset/2012_04_13/o1_mf_nnndf_FULL_DATABASE_BEFORE_7rjh18jk_.bkp
    List of Datafiles in backup set 214
    File LV Type Ckp SCN    Ckp Time            Name
    ---- -- ---- ---------- ------------------- ----
    1       Full 8639822    13.04.2012 18:46:00 /u02/oradata/ora112/system01.dbf
    9       Full 8639822    13.04.2012 18:46:00 /u01/app/oracle/product/11.2/dbs/my_data04.dbf

BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ -------------------
213     Full    121.24M    DISK        00:00:32     13.04.2012 18:45:57
        BP Key: 225   Status: AVAILABLE  Compressed: YES  Tag: FULL_DATABASE_BEFORE_UPGRADE
        Piece Name: /u03/oracle_backups/fra/ORA112/backupset/2012_04_13/o1_mf_nnndf_FULL_DATABASE_BEFORE_7rjh059r_.bkp
    List of Datafiles in backup set 213
    File LV Type Ckp SCN    Ckp Time            Name
    ---- -- ---- ---------- ------------------- ----
    2       Full 8639802    13.04.2012 18:45:25 /u02/oradata/ora112/sysaux01.dbf
    3       Full 8639802    13.04.2012 18:45:25 /u02/oradata/ora112/undotbs01.dbf
    4       Full 8639802    13.04.2012 18:45:25 /u02/oradata/ora112/users01.dbf
    8       Full 8639802    13.04.2012 18:45:25 /u01/app/oracle/product/11.2/dbs/my_data03.dbf
    14      Full 8639802    13.04.2012 18:45:25 /u02/oradata/ORA112/datafile/o1_mf_my_data_7oy0k0vr_.dbf

BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ -------------------
210     Full    1.02M      DISK        00:00:00     13.04.2012 18:45:21
        BP Key: 222   Status: AVAILABLE  Compressed: YES  Tag: FULL_DATABASE_BEFORE_UPGRADE
        Piece Name: /u03/oracle_backups/fra/ORA112/backupset/2012_04_13/o1_mf_nnndf_FULL_DATABASE_BEFORE_7rjh01to_.bkp
    List of Datafiles in backup set 210
    File LV Type Ckp SCN    Ckp Time            Name
    ---- -- ---- ---------- ------------------- ----
    5       Full 8639798    13.04.2012 18:45:21 /u02/oradata/ora112/my_indexes01.dbf
    7       Full 8639798    13.04.2012 18:45:21 /u01/app/oracle/product/11.2/dbs/my_data02.dbf

BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ -------------------
211     Full    1.28M      DISK        00:00:01     13.04.2012 18:45:23
        BP Key: 223   Status: AVAILABLE  Compressed: YES  Tag: FULL_DATABASE_BEFORE_UPGRADE
        Piece Name: /u03/oracle_backups/fra/ORA112/backupset/2012_04_13/o1_mf_nnndf_FULL_DATABASE_BEFORE_7rjh02yy_.bkp
    List of Datafiles in backup set 211
    File LV Type Ckp SCN    Ckp Time            Name
    ---- -- ---- ---------- ------------------- ----
    6       Full 8639799    13.04.2012 18:45:22 /u02/oradata/ora112/my_data01.dbf
    12      Full 8639799    13.04.2012 18:45:22 /u01/app/oracle/product/11.2/dbs/my_data07.dbf
    13      Full 8639799    13.04.2012 18:45:22 /u01/app/oracle/product/11.2/dbs/my_data08.dbf

BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ -------------------
212     Full    1.02M      DISK        00:00:00     13.04.2012 18:45:24
        BP Key: 224   Status: AVAILABLE  Compressed: YES  Tag: FULL_DATABASE_BEFORE_UPGRADE
        Piece Name: /u03/oracle_backups/fra/ORA112/backupset/2012_04_13/o1_mf_nnndf_FULL_DATABASE_BEFORE_7rjh044h_.bkp
    List of Datafiles in backup set 212
    File LV Type Ckp SCN    Ckp Time            Name
    ---- -- ---- ---------- ------------------- ----
    10      Full 8639800    13.04.2012 18:45:24 /u01/app/oracle/product/11.2/dbs/my_data05.dbf
    11      Full 8639800    13.04.2012 18:45:24 /u01/app/oracle/product/11.2/dbs/my_data06.dbf

List of Archived Log Copies for database with db_unique_name ORA112
=====================================================================

Key     Thrd Seq     S Low Time
------- ---- ------- - -------------------
295     1    242     A 13.04.2012 18:45:06
        Name: /u02/oradata/ora112/archivelogs/1_242_0767676036.arc

Media recovery start SCN is 8639788
Recovery must be done beyond SCN 8639822 to clear datafile fuzziness
Finished restore at 13.04.2012 18:51:29
```

<br/><br/>

<strong>Using the RESTORE..VALIDATE command</strong>

RMAN will check whether it can restore data from the backup.<br/>
No actual recovery occurs.

    RMAN> RESTORE DATABASE VALIDATE;
    RMAN> RESTORE DATABASE VALIDATE CHECK LOGICAL;

<br/>

### Full recovery

    RMAN> restore database;
    RMAN> recover database;

<br/>

### Restore only the system tablespace to the time of the last backup

    RMAN> run{restore tablespace system; recover database;}

<br/>

### Incomplete recovery from the last backup to 15 minutes ago

```shell
RMAN> run{
shutdown immediate;
startup mount;
set until time "sysdate-15/(24*60)";
-- set until time "to_date('2010-06-01 12:50:30', 'yyyy-mm-dd hh24:mi:ss')";
-- set until scn=1891093;
restore database;
recover database;
alter database open resetlogs;}
```

<br/>

When performing incomplete recovery, you must open the database with the command:

    RMAN> ALTER DATABASE OPEN RESETLOGS;

When performing resetlogs, the database incarnation changes.

<br/>

### Restore up to the point where an error occurs (e.g., missing or corrupted archived log).

    RMAN> recover database until cancel;

<!--

<br/>

### In case of loss of everything, including data files, spfile, but with backups. (Not yet tested on real databases. Just for information.)


    $ export ORACLE_SID=ORCL12
    $ rman target / nocatalog

<br/>

    RMAN> startup force nomount;

<br/>

    RMAN> list backupset;

<br/>

    RMAN> restore spfile to pfile '/tmp/initora12.ora' from '+ARCH/ORCL12/BACKUPSET/2015_08_19/nnsnf0_full_database_spfile_0.289.888163613';

<br/>

    RMAN> restore spfile from '+ARCH/ORCL12/BACKUPSET/2015_08_19/nnsnf0_full_database_spfile_0.289.888163613';

<br/>

Restored spfile.

    SQL> shutdown immediate;
    SQL> startup nomount;

<br/>

    $ rmant rarget / nocatalog
    RMAN> restore controlfile from '+ARCH/ORCL12/BACKUPSET/2015_08_19/nnsnf0_full_database_spfile_0.289.888163613';

<br/>

    SQL> alter database mount;



Database is in: Mounted state

    RMAN> crosscheck backup;

    RMAN> catalog start with '+ARCH/ORCL12/BACKUPSET/2015_08_19/';

    RMAN> crosscheck archivelog all;


// If you need to restore to the directory where the data files were

    RMAN> restore database;
    RMAN> recover database;



// If you need to restore to a different directory than the original

    RMAN> RUN {
        set newname for datafile 1 to '...../system*.dbf';
        set newname for datafile 2 to '...../sysadux*.dbf';
        set newname for datafile 3 to '...../undo*.dbf';
        set newname for datafile 4 to '...../user*.dbf';

        restore datafile 1,2,3,4;
        switch datafile all;
        recover datafile 1,2,3,4;
    }

<br/>

    RMAN> alter database open resetlogs;

-->
