---
layout: page
title: Oracle DataBase Server 12.1 installation on Windows 2008 Server - Redologs multiplexing
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-multiplex-redologs/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Windows 2008 Server]</a>: Redologs multiplexing

<br/>


    md e:\app\oracle\oradata\ora121\redo
    md f:\app\oracle\oradata\ora121\redo

<br/>

    sqlplus / as sysdba


Command to present output result in convenient format


    SQL> set linesize 250;
    SQL> set pagesize 0;
    SQL> col  GROUP# format 99;
    SQL> col  MEMBER format a40;
    SQL> col  STATUS format a10;
    SQL> col  MB format 999;



<br/>

    SQL> select a.group#, member, a.status, bytes/1024/1024 as "MB"
    from v$log a, v$logfile b
    where a.group# = b.group#
    order by 1;

<br/>

    1 E:\APP\ORACLE\ORADATA\ORA121\REDO01.LOG  INACTIVE     50
    2 E:\APP\ORACLE\ORADATA\ORA121\REDO02.LOG  INACTIVE     50
    3 E:\APP\ORACLE\ORADATA\ORA121\REDO03.LOG  CURRENT      50


<br/>

You could remove only files in not active group. You could switch groups. We will show how to do it later.

Now we remove files from INACTIVE group

<br/><br/>

1) We should recreate group 1 and files from this group.

Remove files group 1


    SQL> alter database drop logfile group 1;

<br/>

    SQL> quit

<br/>

    del E:\APP\ORACLE\ORADATA\ORA121\REDO01.LOG

<br/>

    $ sqlplus / as sysdba


To add new group with files:


    SQL> alter database add logfile group 1 ('e:\app\oracle\oradata\ora121\redo\redo01.log', 'f:\app\oracle\oradata\ora121\redo\redo01.log') size 100M;

<br/><br/>

2) We should recreate group 2 and files from this group.

Remove files group 2

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

3) We should recreate group 3 and files from this group.

Because this group is active, we should to switch current group to next. Group 3 should be INACTIVE.

For switch execute next command:


<br/>

    SQL> alter system checkpoint;
    SQL> alter system switch logfile;


Remove files group 3

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

    SQL> select a.group#, member, a.status, bytes/1024/1024 as "MB"
    from v$log a, v$logfile b
    where a.group# = b.group#
    order by 1,2;

<br/>


    1 E:\APP\ORACLE\ORADATA\ORA121\REDO\REDO01.LOG CURRENT     100
    1 F:\APP\ORACLE\ORADATA\ORA121\REDO\REDO01.LOG CURRENT     100
    2 E:\APP\ORACLE\ORADATA\ORA121\REDO\REDO02.LOG UNUSED      100
    2 F:\APP\ORACLE\ORADATA\ORA121\REDO\REDO02.LOG UNUSED      100
    3 E:\APP\ORACLE\ORADATA\ORA121\REDO\REDO03.LOG UNUSED      100
    3 F:\APP\ORACLE\ORADATA\ORA121\REDO\REDO03.LOG UNUSED      100

<br/>

    SQL> quit
