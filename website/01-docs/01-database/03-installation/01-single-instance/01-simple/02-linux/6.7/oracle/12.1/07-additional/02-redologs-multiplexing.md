---
layout: page
title: Oracle DataBase 12c - Linux - Redologs multiplexing
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/redologs-multiplexing/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Redologs multiplexing

<br/>

    $ mkdir -p /u02/oracle/oradata/12.1/${ORACLE_SID}/REDOLOGS
    $ mkdir -p /u03/oracle/oradata/12.1/${ORACLE_SID}/REDOLOGS


<br/>

    $ sqlplus / as sysdba


Command to present output result in convenient format

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

    1 /u02/oracle/oradata/12.1/orcl12/redo01.log	  INACTIVE     50
    2 /u02/oracle/oradata/12.1/orcl12/redo02.log	  INACTIVE     50
    3 /u02/oracle/oradata/12.1/orcl12/redo03.log	  CURRENT      50


You could remove only files in not active group. You could switch groups. We will show how to do it later.

Now we remove files from INACTIVE group

<br/>

1) We should recreate group 1 and files from this group.


Remove files group 1

    SQL> alter database drop logfile group 1;

    SQL> quit

<br/>

    $ rm /u02/oracle/oradata/12.1/orcl12/redo01.log



<br/>

    $ sqlplus / as sysdba


To add new group with files:

    SQL> alter database add logfile group 1 ('/u02/oracle/oradata/12.1/orcl12/REDOLOGS/redo01.log' , '/u03/oracle/oradata/12.1/orcl12/REDOLOGS/redo01.log') size 100M;

<br/>

2) We should recreate group 2 and files from this group.

Remove files group 2


    SQL> alter database drop logfile group 2;

    SQL> quit

<br/>

    $ rm /u02/oracle/oradata/12.1/orcl12/redo02.log



<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> alter database add logfile group 2 ('/u02/oracle/oradata/12.1/orcl12/REDOLOGS/redo02.log' , '/u03/oracle/oradata/12.1/orcl12/REDOLOGS/redo02.log') size 100M;


<br/>

3) We should recreate group 3 and files from this group.

Because this group is active, we should to switch current group to next. Group 3 should be INACTIVE.


For switch execute next command:

    SQL> alter system checkpoint;
    SQL> alter system switch logfile;


Remove files group 3

    SQL> alter database drop logfile group 3;

    SQL> quit

<br/>

    $ rm /u02/oracle/oradata/12.1/orcl12/redo03.log


<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> alter database add logfile group 3 ('/u02/oracle/oradata/12.1/orcl12/REDOLOGS/redo03.log' , '/u03/oracle/oradata/12.1/orcl12/REDOLOGS/redo03.log') size 100M;

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

    1 /u02/oracle/oradata/12.1/orcl12/REDOLOGS/redo01.log     CURRENT	   100
    1 /u03/oracle/oradata/12.1/orcl12/REDOLOGS/redo01.log     CURRENT	   100
    2 /u02/oracle/oradata/12.1/orcl12/REDOLOGS/redo02.log     UNUSED	   100
    2 /u03/oracle/oradata/12.1/orcl12/REDOLOGS/redo02.log     UNUSED	   100
    3 /u02/oracle/oradata/12.1/orcl12/REDOLOGS/redo03.log     UNUSED	   100
    3 /u03/oracle/oradata/12.1/orcl12/REDOLOGS/redo03.log     UNUSED	   100

    6 rows selected.

<br/>

    SQL> quit
