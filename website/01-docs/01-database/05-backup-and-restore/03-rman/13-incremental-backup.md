---
layout: page
title: Creating an incremental database copy using RMAN
description: Creating an incremental database copy using RMAN
keywords: Oracle Database, RMAN, Incremental
permalink: /database/backup-and-restore/rman/incremental-backup/
---

# Creating an incremental database copy using RMAN:

```
RUN {
    CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;
    BACKUP INCREMENTAL LEVEL 0 DATABASE PLUS ARCHIVELOG TAG "LEVEL 0";
    BACKUP CURRENT CONTROLFILE SPFILE;
}
```

<br/>

    BACKUP INCREMENTAL LEVEL 1 DATABASE PLUS ARCHIVELOG TAG "LEVEL 1";

Create a cumulative (includes changes reflected in incremental backups) backup with level 1

    RMAN> backup incremental level 1 cumulative database;

// Reset database to incarnation 3

    RMAN> reset database to incarnation 3;
