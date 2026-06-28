---
layout: page
title: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Multiplexing Redologs
description: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Multiplexing Redologs
keywords: Oracle DataBase, Installation, Windows 2008, Multiplexing Redologs
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-multiplex-redologs/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server]</a>: Multiplexing Redologs

<br/>

    md e:\app\oracle\oradata\ora121\redo
    md f:\app\oracle\oradata\ora121\redo

<br/>

    sqlplus / as sysdba

Set of commands to make query results easier to display on screen.

    SQL> set linesize 250;
    SQL> set pagesize 0;
    SQL> col  GROUP# format 99;
    SQL> col  MEMBER format a40;
    SQL> col  STATUS format a10;
    SQL> col  MB format 999;

<br/>

```sql
SQL> select a.group#, member, a.status, bytes/1024/1024 as "MB"
from v$log a, v$logfile b
where a.group# = b.group#
order by 1;
```

<br/>

     1 E:\APP\ORACLE\ORADATA\ORA121\REDO01.LOG  INACTIVE     50
     2 E:\APP\ORACLE\ORADATA\ORA121\REDO02.LOG  INACTIVE     50
     3 E:\APP\ORACLE\ORADATA\ORA121\REDO03.LOG  CURRENT      50

<br/>

Only inactive group files can be deleted. Groups can be switched, as shown below.
Delete files of groups in INACTIVE state

1. Need to recreate group 1 and its files.

<br/>

Delete files of group 1

    SQL> alter database drop logfile group 1;

<br/>

    SQL> quit

<br/>

    del E:\APP\ORACLE\ORADATA\ORA121\REDO01.LOG

<br/>

    $ sqlplus / as sysdba

Add a new group, list the files of the new group and define their size.

    SQL> alter database add logfile group 1 ('e:\app\oracle\oradata\ora121\redo\redo01.log', 'f:\app\oracle\oradata\ora121\redo\redo01.log') size 100M;

2.  Need to recreate group 2 and its files.<br/>
    Delete files of group 2

        SQL> alter database drop logfile group 2;

<br/>

    SQL> quit

<br/>

    del E:\APP\ORACLE\ORADATA\ORA121\REDO02.LOG

<br/>

    $ sqlplus / as sysdba

<br/>

       SQL> alter database add logfile group 2 ('e:\app\oracle\oradata\ora121\redo\redo02.log', 'f:\app\oracle\oradata\ora121\redo\redo02.log') size 100M;

<br/>

3. Need to recreate group 3 and its files.<br/>
   Since the group is active, you need to switch to the next file group, making group 2 INACTIVE.
   <br/>
   To switch, execute the following commands:

<br/>

    SQL> alter system checkpoint;
    SQL> alter system switch logfile;

<br/>

Delete files of group 3

    SQL> alter database drop logfile group 3;

<br/>

    SQL> quit

<br/>

    del E:\APP\ORACLE\ORADATA\ORA121\REDO03.LOG

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> alter database add logfile group 3 ('e:\app\oracle\oradata\ora121\redo\redo03.log', 'f:\app\oracle\oradata\ora121\redo\redo03.log') size 100M;

<br/>

    SQL> set linesize 250;
    SQL> set pagesize 0;
    SQL> col  GROUP# format 99;
    SQL> col  MEMBER format a40;
    SQL> col  STATUS format a10;
    SQL> col  MB format 999;

<br/>

```sql
SQL> select a.group#, member, a.status, bytes/1024/1024 as "MB"
from v$log a, v$logfile b
where a.group# = b.group#
order by 1,2;
```

<br/>

     1 E:\APP\ORACLE\ORADATA\ORA121\REDO\REDO01.LOG CURRENT     100
     1 F:\APP\ORACLE\ORADATA\ORA121\REDO\REDO01.LOG CURRENT     100
     2 E:\APP\ORACLE\ORADATA\ORA121\REDO\REDO02.LOG UNUSED      100
     2 F:\APP\ORACLE\ORADATA\ORA121\REDO\REDO02.LOG UNUSED      100
     3 E:\APP\ORACLE\ORADATA\ORA121\REDO\REDO03.LOG UNUSED      100
     3 F:\APP\ORACLE\ORADATA\ORA121\REDO\REDO03.LOG UNUSED      100

<br/>

    SQL> quit
