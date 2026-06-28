---
layout: page
title: Creating a copy of an active Oracle database using RMAN
description: Creating a copy of an active Oracle database using RMAN
keywords: Oracle Database, RMAN, Creating a copy of an active database
permalink: /database/backup-and-restore/rman/duplicate-instance/duplicate-active-database/
---

# Creating a copy of an active Oracle database using RMAN

Same as in the <a href="/database/backup-and-restore/rman/duplicate-instance/duplicate-database-from-backup/">previous document</a>, same as with dataguard.

Only the RMAN script is different.

    $ rman target sys/manager@ORCL12 nocatalog
    RMAN> connect auxiliary sys/manager@copy12

<br/>

    RMAN> RUN{
        allocate channel dupli1 type disk;
        allocate auxiliary channel1 dupli2 type disk;
        duplicate target database to copy12 from active database nofilenamecheck;
    }
