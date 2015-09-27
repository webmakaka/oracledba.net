---
layout: page
title: Oracle DataBase 12c - Linux - Archivelog miltiplexing
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/archivelogs-multiplexing/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Archivelog miltiplexing


Creating folders to store backups and archivelogs:

    $ mkdir -p /u02/oracle/oradata/12.1/${ORACLE_SID}/ARCHIVELOG
    $ mkdir -p /u03/oracle/oradata/12.1/${ORACLE_SID}/ARCHIVELOG

<br/>

    $ sqlplus / as sysdba

Setup archive destination folders:

    SQL> ALTER SYSTEM SET LOG_ARCHIVE_DEST_1='location=/u02/oracle/oradata/12.1/orcl12/ARCHIVELOG mandatory' scope=both;

    SQL> ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='location=/u03/oracle/oradata/12.1/orcl12/ARCHIVELOG mandatory' scope=both;


Show parameter LOG_ARCHIVE_DEST

    SQL> show parameter LOG_ARCHIVE_DEST;


Set file format for archivelogs

    SQL> ALTER SYSTEM SET LOG_ARCHIVE_FORMAT='%t_%s_%R.arc' scope=spfile;


<br/>

    SQL> quit
