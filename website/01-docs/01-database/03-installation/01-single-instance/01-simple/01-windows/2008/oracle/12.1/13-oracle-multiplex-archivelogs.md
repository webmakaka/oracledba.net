---
layout: page
title: Oracle DataBase Server 12.1 installation on Windows 2008 Server - Archivelog miltiplexing
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-multiplex-archivelogs/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Windows 2008 Server]</a>: Archivelog miltiplexing

<br/>

Creating folders to store backups and archivelogs:


    $ md e:\app\oracle\oradata\ora121\archives
    $ md f:\app\oracle\oradata\ora121\archives

<br/>

    sqlplus / as sysdba

<br/>

Setup archive destination folders:


    SQL>  ALTER SYSTEM SET LOG_ARCHIVE_DEST_1='location=e:\app\oracle\oradata\ora121\archives mandatory' scope=both;
    SQL>  ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='location=f:\app\oracle\oradata\ora121\archives mandatory' scope=both;


Show parameter LOG_ARCHIVE_DEST

    SQL> show parameter LOG_ARCHIVE_DEST;


Set file format for archivelogs

    SQL>  ALTER SYSTEM SET LOG_ARCHIVE_FORMAT='%t_%s_%R.arc' scope=spfile;


<br/>

    SQL> shutdown immediate;
    SQL> startup;
    SQL> quit
