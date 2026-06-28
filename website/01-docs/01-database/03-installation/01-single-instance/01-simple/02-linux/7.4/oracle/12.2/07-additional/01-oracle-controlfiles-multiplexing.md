---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Multiplexing Controlfiles
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Multiplexing Controlfiles
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Multiplexing Controlfiles
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-controlfiles-multiplexing/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Multiplexing Controlfiles

<br/>

    $ mkdir -p /u02/oracle/oradata/12.2/${ORACLE_SID}/CONTROLFILE
    $ mkdir -p /u03/oracle/oradata/12.2/${ORACLE_SID}/CONTROLFILE

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> select name from v$CONTROLFILE;

<br/>

    NAME
    --------------------------------------------------------------------------------
    /u02/oracle/oradata/12.1/orcl12/control01.ctl
    /u02/oracle/oradata/12.1/orcl12/control02.ctl

<br/>

    SQL> shutdown immediate;

<br/>

    SQL> quit

<br/>

    $ cp /u02/oracle/oradata/12.2/orcl/control01.ctl /u02/oracle/oradata/12.2/${ORACLE_SID}/CONTROLFILE/control01.ctl

    $ cp /u02/oracle/oradata/12.2/orcl/control01.ctl /u02/oracle/oradata/12.2/${ORACLE_SID}/CONTROLFILE/control02.ctl

    $ cp /u02/oracle/oradata/12.2/orcl/control01.ctl /u03/oracle/oradata/12.2/${ORACLE_SID}/CONTROLFILE/control03.ctl

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> startup nomount;

<br/>

    SQL> ALTER SYSTEM SET control_files = '/u02/oracle/oradata/12.2/orcl12/CONTROLFILE/control01.ctl', '/u02/oracle/oradata/12.2/orcl12/CONTROLFILE/control02.ctl', '/u03/oracle/oradata/12.2/orcl12/CONTROLFILE/control03.ctl' scope=spfile;

<br/>

    SQL> shutdown immediate;

<br/>

    SQL> startup;

<br/>

    SQL> SELECT name FROM v$CONTROLFILE;

<br/>

    NAME
    --------------------------------------------------------------------------------
    /u02/oracle/oradata/12.1/orcl12/CONTROLFILE/control01.ctl
    /u02/oracle/oradata/12.1/orcl12/CONTROLFILE/control02.ctl
    /u03/oracle/oradata/12.1/orcl12/CONTROLFILE/control03.ctl

<br/>

    SQL> quit

Delete old controlfiles

    $ rm /u02/oracle/oradata/12.2/orcl/control01.ctl
    $ rm /u02/oracle/oradata/12.2/orcl/control02.ctl
