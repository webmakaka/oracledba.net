---
layout: page
title: BACKUPs on DataGuard
description: BACKUPs on DataGuard
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/backups/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: BACKUPs on DataGuard

The point is that:

1. Backups still need to be made.
2. FRA can fill up with archive logs. If no action is taken, the server will stop.

The following backup approach is suggested by the author of the [Udemy] easy way to set oracle active dataguard course.

<br/>

    SQL> show parameter recovery

    NAME				     TYPE	 VALUE
    ------------------------------------ ----------- ------------------------------
    db_recovery_file_dest		     string	 +ARCH
    db_recovery_file_dest_size	     big integer 40000M
    recovery_parallelism		     integer	 0

<br/>

### ALL DB:

    RMAN> CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK CLEAR;

    RMAN> CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '+ARCH/%d_DB_%u_%s_%p';

<br/>

### PRIMARY database:

    RMAN> CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;

    RMAN> CONFIGURE DEFAULT DEVICE TYPE TO DISK;

    RMAN> CONFIGURE CONTROLFILE AUTOBACKUP ON;

<br/>

### STANDBY database:

    RMAN> CONFIGURE BACKUP OPTIMIZATION ON;

    RMAN> CONFIGURE ARCHIVELOG DELETION POLICY TO NONE;

<br/>

### Backups FULL

    RMAN> RUN {
        CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 1;
        BACKUP CHECK LOGICAL INCREMENTAL LEVEL 0 FILESPERSET 10 FORMAT '+ARCH/FULL0_%D_%U'
        (DATABASE INCLUDE CURRENT CONTROLFILE);
        BACKUP NOT BACKED UP 1 TIMES FILESPERSET 10
        (ARCHIVELOG ALL DELETE INPUT FORMAT '+ARCH/%d_DB_%u_%s_%p');
        BACKUP (CURRENT CONTROLFILE FORMAT '+ARCH');
    }

<br/>

    RMAN> RUN {
        COPY CURRENT CONTROLFILE TO '/backups/oracle/12.1/orcl12/controlfiles/CTL_STANDBY.CTL';
    }

<br/>

### Backup Archives

    RMAN> RUN {
       CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 2;
       BACKUP ARCHIVELOG ALL FORMAT '+ARCH/ARCH0_%D_%u' DELETE ALL INPUT;
    }

<br/>

    RMAN> RUN {
        COPY CURRENT CONTROLFILE TO '/backups/oracle/12.1/orcl12/controlfiles/CTL_STANDBY.CTL';
    }
