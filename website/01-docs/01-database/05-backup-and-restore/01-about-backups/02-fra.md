---
layout: page
title: Fast Recovery Area (FRA)
description: Fast Recovery Area (FRA)
keywords: Fast Recovery Area, FRA
permalink: /database/backup-and-restore/fra/
---

# Fast Recovery Area (FRA)

<br/>

<strong>FRA [Fast Recovery Area]</strong> - an area on disk for backup copies and archived logs. However, it is not at all necessary to store backups there. The advantage of using it is the ability to limit hard disk resource usage for backups and archived logs. Oracle settings define where this area is located and how much data can be stored there. It is better not to set the maximum possible value for FRA, so that if necessary there is room for maneuver. Ideally, you should monitor free space in FRA. If space runs out, the server will stop.

<strong>ARCHIVELOG </strong> - a database operating mode in which, after switching the active log group, a copy of the log is archived and saved to disk. Redo logs are gradually overwritten, and the information stored in them can be obtained from archive logs.

In ARCHIVELOG mode, archived logs accumulate and if there is no free space, the database stops working. If there is no free space at all, you can get stuck for a long time.

In ARCHIVELOG mode, you don't need to stop the database to create a backup, so databases usually work in this mode.

// Set the maximum FRA size

    SQL> alter system set db_recovery_file_dest_size = 60G;

// Change FRA location

    SQL> alter system set db_recovery_file_dest='/u03/oracle_backups/fra';

// View set values

    SQL> show parameter recov

// Enable archivelog (if needed)

    SQL> shutdown immediate;
    SQL> startup mount;
    SQL> alter database archivelog;
    SQL> alter database open;
