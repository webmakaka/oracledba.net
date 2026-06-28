---
layout: page
title: Not enough free space in Fast Recovery Area
description: Not enough free space in Fast Recovery Area
keywords: Oracle Database, FRA
permalink: /database/backup-and-restore/rman/low-space-in-fra/
---

# Not enough free space in Fast Recovery Area

**Specific solution when the database is running in ARCHIVELOG mode**

The database stopped working because it could not write the archive log to the
designated location.

Main reason: backup with deletion of obsolete archived log files had not been performed for several days.

View Fast Recovery data:

    SQL> select ROUND((SPACE_USED)/1024/1024/1024) as "Used GB",
    ROUND((SPACE_LIMIT)/1024/1024/1024) as "MAX GB",
    ROUND(((SPACE_LIMIT)-(SPACE_USED))/1024/1024/1024) as "FREE GB"
    from V$recovery_File_Dest;

FRA usage percentage:

    SELECT
        TO_CHAR(SPACE_USED, '999,999,999,999') AS "Used",
        TO_CHAR(SPACE_LIMIT - SPACE_USED + SPACE_RECLAIMABLE, '999,999,999,999')
           AS "Free",
        ROUND((SPACE_USED - SPACE_RECLAIMABLE)/SPACE_LIMIT * 100, 1)
           AS "Persent Used"
        FROM V$RECOVERY_FILE_DEST;

<br/>

Algorithm (very old, used on "toy" databases):

Connect to RMAN

1. CMD> rman target /

Make sure the database is running in Archivelog mode

2. RMAN> 'select log_mode from v\$database';

Increase the flash recovery area size

2. RMAN> sql 'alter system set db_recovery_file_dest_size = 25G';

Create backup

3. backup database

Specify the number of backups to keep as 1.

4. RMAN> CONFIGURE RETENTION POLICY TO REDUNDANCY 1;

5. RMAN> delete noprompt obsolete;

Restore the previous flash recovery area value

6. RMAN> sql 'alter system set db_recovery_file_dest_size = 20G';
