---
layout: page
title: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Multiplexing Archivelogs
description: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Multiplexing Archivelogs
keywords: Oracle DataBase, Installation, Windows 2008, Multiplexing Archivelogs
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-multiplex-archivelogs/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server]</a>: Multiplexing Archivelogs

<br/>

Creating a directory for storing backup files and archive logs

    $ md e:\app\oracle\oradata\ora121\archives
    $ md f:\app\oracle\oradata\ora121\archives

<br/>

    sqlplus / as sysdba

<br/>

Set directories for archive logs

    SQL>  ALTER SYSTEM SET LOG_ARCHIVE_DEST_1='location=e:\app\oracle\oradata\ora121\archives mandatory' scope=both;
    SQL>  ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='location=f:\app\oracle\oradata\ora121\archives mandatory' scope=both;

View current values of the LOG_ARCHIVE_DEST parameter

    SQL> show parameter LOG_ARCHIVE_DEST;

Set format for archivelog files

    SQL>  ALTER SYSTEM SET LOG_ARCHIVE_FORMAT='%t_%s_%R.arc' scope=spfile;

<br/>

    SQL> shutdown immediate;
    SQL> startup;
    SQL> quit
