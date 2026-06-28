---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Multiplexing Archivelogs
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Multiplexing Archivelogs
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Multiplexing Archivelogs
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-multiplex-archivelogs/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Multiplexing Archivelogs

<br/>

Creating a directory for storing backup files and archive logs

    $ mkdir -p /u02/oradata/${ORACLE_SID}/archivelogs
    $ mkdir -p /u03/oradata/${ORACLE_SID}/archivelogs

<br/>

    $ sqlplus / as sysdba

Set directories for archive logs

    SQL>  ALTER SYSTEM SET LOG_ARCHIVE_DEST_1='location=/u02/oradata/ora112/archivelogs mandatory' scope=both;
    SQL>  ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='location=/u03/oradata/ora112/archivelogs mandatory' scope=both;

View current values of the LOG_ARCHIVE_DEST parameter

    SQL> show parameter LOG_ARCHIVE_DEST;

Set format for archivelog files

    SQL>  ALTER SYSTEM SET LOG_ARCHIVE_FORMAT='%t_%s_%R.arc' scope=spfile;

<br/>

    SQL> quit

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
