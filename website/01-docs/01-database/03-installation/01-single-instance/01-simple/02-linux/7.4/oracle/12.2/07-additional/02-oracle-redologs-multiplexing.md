---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Multiplexing Redologs
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Multiplexing Redologs
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Multiplexing Redologs
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-redologs-multiplexing/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Multiplexing Redologs

<br/>

    $ mkdir -p /u02/oracle/oradata/12.2/${ORACLE_SID}/REDOLOGS
    $ mkdir -p /u03/oracle/oradata/12.2/${ORACLE_SID}/REDOLOGS

<br/>

    $ sqlplus / as sysdba

A set of commands to make it easier to display query results on the screen.

    SQL> set linesize 250;
    SQL> set pagesize 0;
    SQL> col  GROUP# format 99;
    SQL> col  MEMBER format a50;
    SQL> col  STATUS format a10;
    SQL> col  MB format 999;

<br/>

    SQL> select a.group#, member, a.status, bytes/1024/1024 as "MB"
    from v$log a, v$logfile b
    where a.group# = b.group#
    order by 1;

<br/>

    1 /u02/oracle/oradata/12.2/orcl12/redo01.log	  INACTIVE     50
    2 /u02/oracle/oradata/12.2/orcl12/redo02.log	  INACTIVE     50
    3 /u02/oracle/oradata/12.2/orcl12/redo03.log	  CURRENT      50

Only files of an inactive group can be deleted. Groups can be switched, which will be shown below.  
Delete files of the INACTIVE group

1. Need to recreate group 1 and its files.

Delete files of group 1

    SQL> alter database drop logfile group 1;

    SQL> quit

<br/>

    $ rm /u02/oracle/oradata/12.2/orcl/redo01.log

<br/>

    $ sqlplus / as sysdba

Add a new group, list the files of the new group and specify their size.

    SQL> alter database add logfile group 1 ('/u02/oracle/oradata/12.2/orcl12/REDOLOGS/redo01.log' , '/u03/oracle/oradata/12.2/orcl12/REDOLOGS/redo01.log') size 100M;

<br/>

2. Need to recreate group 2 and its files.<br/>
   Delete files of group 2

   SQL> alter database drop logfile group 2;

   SQL> quit

<br/>

    $ rm /u02/oracle/oradata/12.2/orcl/redo02.log

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> alter database add logfile group 2 ('/u02/oracle/oradata/12.2/orcl12/REDOLOGS/redo02.log' , '/u03/oracle/oradata/12.2/orcl12/REDOLOGS/redo02.log') size 100M;

3. Need to recreate group 3 and its files.<br/>
   Since the group is active, you need to switch to the next group of files, making group 2 INACTIVE.

To switch, simply run the commands:

    SQL> alter system checkpoint;
    SQL> alter system switch logfile;

Delete files of group 3

    SQL> alter database drop logfile group 3;

    SQL> quit

<br/>

    $ rm /u02/oracle/oradata/12.2/orcl/redo03.log

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> alter database add logfile group 3 ('/u02/oracle/oradata/12.2/orcl12/REDOLOGS/redo03.log' , '/u03/oracle/oradata/12.2/orcl12/REDOLOGS/redo03.log') size 100M;

<br/>

    SQL> set linesize 250;
    SQL> set pagesize 0;
    SQL> col  GROUP# format 99;
    SQL> col  MEMBER format a55;
    SQL> col  STATUS format a10;
    SQL> col  MB format 999;

<br/>

    SQL> select a.group#, member, a.status, bytes/1024/1024 as "MB"
    from v$log a, v$logfile b
    where a.group# = b.group#
    order by 1,2;

<br/>

    1 /u02/oracle/oradata/12.2/orcl12/REDOLOGS/redo01.log     CURRENT	   100
    1 /u03/oracle/oradata/12.2/orcl12/REDOLOGS/redo01.log     CURRENT	   100
    2 /u02/oracle/oradata/12.2/orcl12/REDOLOGS/redo02.log     UNUSED	   100
    2 /u03/oracle/oradata/12.2/orcl12/REDOLOGS/redo02.log     UNUSED	   100
    3 /u02/oracle/oradata/12.2/orcl12/REDOLOGS/redo03.log     UNUSED	   100
    3 /u03/oracle/oradata/12.2/orcl12/REDOLOGS/redo03.log     UNUSED	   100

    6 rows selected.

<br/>

    SQL> quit
