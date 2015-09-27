---
layout: page
title: Oracle DataBase 12c - Linux - Final hot backup
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-final-hot-backup/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Final hot backup



    $ mkdir -p /u02/oracle/oradata/${ORACLE_SID}/scripts

<br/>

    $ cd /u02/oracle/oradata/${ORACLE_SID}/scripts



<br/>

    $ vi rmanscript.rman


<br/>

    RUN {
        CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;
        BACKUP FULL DATABASE TAG "FULL_DATABASE" PLUS ARCHIVELOG TAG "FULL_DATABASE_ARCHIVELOGS";
        BACKUP CURRENT CONTROLFILE TAG "FULL_DATABASE_CONTROLFILE";
        BACKUP SPFILE TAG "FULL_DATABASE_SPFILE";
    }



Check syntax


    $ rman CHECKSYNTAX @rmanscript.rman

Execute script

    $ rman target / @rmanscript.rman



Look to the list of backups

    RMAN> rman target /

<br/>

    RMAN> list backup of database summary;



With next command i inform RMAN, what all backups except last it should mark as obsolete.


    RMAN> CONFIGURE RETENTION POLICY TO REDUNDANCY 1;


Next command should remove all backups marked as obsolete without additional questions.


    RMAN> delete noprompt obsolete;

<br/>

    RMAN> list backup of database summary;

<br/>


    RMAN>  quit
