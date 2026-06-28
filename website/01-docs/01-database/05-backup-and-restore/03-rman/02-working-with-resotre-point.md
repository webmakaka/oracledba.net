---
layout: page
title: Working with restore points
description: Working with restore points
keywords: Oracle Database, Working with restore points
permalink: /database/backup-and-restore/rman/restore-points/
---

# Working with restore points

To avoid remembering soulless SCN numbers, you can give it a name.
For example "Before_Upgrade". And in rman commands, you can also use human-readable words solely for the convenience of the human operator.

// Create a restore point

    SQL> create restore point <pointName>;

// Create a guaranteed restore point (with flashback enabled)

    SQL> create restore point <pointName> guarantee flashback database;

// Show restore points

    SQL> select * from v$restore_point;

// Delete a restore point

    SQL> drop restore point <pointName>

// Rollback to a restore point (with flashback enabled)

    SQL> shutdown immediate;
    SQL> startup mount exclusive;
    SQL> flashback database to restore point <pointName>;
    SQL> alter database open;
