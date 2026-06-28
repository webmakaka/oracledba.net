---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Final Backup (Hot Backup)
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Final Backup (Hot Backup)
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Hot Backup
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-final-hot-backup/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Final Backup (Hot Backup)

<br/>

    $ cd /u03/orabackups

<br/>

    $ vi rmanscript.rman

<br/>

    RUN {
    CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;
    BACKUP FULL DATABASE TAG "FULL_DATABASE" PLUS ARCHIVELOG TAG "FULL_DATABASE_ARCHIVELOGS";
    }

Check the syntax of the created script file

    $ rman CHECKSYNTAX @rmanscript.rman

Execute the backup script

    $ rman target / @rmanscript.rman

View the list of backups:

    RMAN> rman target /

<br/>

    RMAN> list backup of database summary;

<br/>

    List of Backups
    ===============
    Key     TY LV S Device Type Completion Time     #Pieces #Copies Compressed Tag
    ------- -- -- - ----------- ------------------- ------- ------- ---------- ---
    1       B  F  A DISK        10.06.2012 22:05:45 1       1       NO         TAG20120610T220429
    6       B  F  A DISK        10.06.2012 22:12:46 1       1       NO         TAG20120610T221132
    10      B  F  A DISK        10.06.2012 23:21:10 1       1       YES        FULL_DATABASE

The following command tells RMAN to mark all backups except the last one as obsolete.

    RMAN> CONFIGURE RETENTION POLICY TO REDUNDANCY 1;

Now ask RMAN to delete obsolete backups (without confirmation).

    RMAN> delete noprompt obsolete;

<br/>

    RMAN> list backup of database summary;

<br/>

    List of Backups
    ===============
    Key     TY LV S Device Type Completion Time     #Pieces #Copies Compressed Tag
    ------- -- -- - ----------- ------------------- ------- ------- ---------- ---
    10      B  F  A DISK        10.06.2012 23:21:10 1       1       YES        FULL_DATABASE

<br/>

    RMAN>  quit

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
