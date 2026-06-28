---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Multiplexing Archivelog
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Multiplexing Archivelog
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Multiplexing Archivelog
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-archivelogs-multiplexing/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Multiplexing Archivelog

<br/>

Create directory for storing backup files and archive logs

    $ mkdir -p /u02/oracle/oradata/12.2/${ORACLE_SID}/ARCHIVELOG
    $ mkdir -p /u03/oracle/oradata/12.2/${ORACLE_SID}/ARCHIVELOG

<br/>

    $ sqlplus / as sysdba

Set directories for archive logs

    SQL> ALTER SYSTEM SET LOG_ARCHIVE_DEST_1='location=/u02/oracle/oradata/12.2/orcl12/ARCHIVELOG mandatory' scope=both;

    SQL> ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='location=/u03/oracle/oradata/12.2/orcl12/ARCHIVELOG mandatory' scope=both;

View current values of the LOG_ARCHIVE_DEST parameter

    SQL> show parameter LOG_ARCHIVE_DEST;

Set format for archivelog files

    SQL> ALTER SYSTEM SET LOG_ARCHIVE_FORMAT='%t_%s_%R.arc' scope=spfile;

<br/>

    SQL> quit
