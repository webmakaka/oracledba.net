---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Multiplexing Redologs
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Multiplexing Redologs
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Multiplexing Redologs
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-multiplex-redologs/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Multiplexing Redologs

<br/>

    $ mkdir -p /u02/oradata/${ORACLE_SID}/redologs
    $ mkdir -p /u03/oradata/${ORACLE_SID}/redologs

<br/>

    $ sqlplus / as sysdba

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

    1 /u02/oradata/ora112/redo01.log           INACTIVE                         50
    2 /u02/oradata/ora112/redo02.log           INACTIVE                         50
    3 /u02/oradata/ora112/redo03.log           CURRENT                         50

Only inactive group files can be deleted. Groups can be switched, as shown below.

Delete files of groups in INACTIVE state

1. Need to recreate group 1 and its files.

Delete files of group 1

    SQL> alter database drop logfile group 1;

<br/>

    SQL> quit

<br/>

    $ rm /u02/oradata/ora112/redo01.log

<br/>

    $ sqlplus / as sysdba

Add a new group, list the files of the new group and define their size.

<br/>

```sql
SQL> alter database add logfile group 1 ('/u02/oradata/ora112/redologs/redo01.log' , '/u03/oradata/ora112/redologs/redo01.log') size 100M;
```

<br/>

2. Need to recreate group 2 and its files.

Delete files of group 2

    SQL> alter database drop logfile group 2;

<br/>

    SQL> quit

<br/>

    $ rm /u02/oradata/ora112/redo02.log

<br/>

    $ sqlplus / as sysdba

<br/>

```sql
SQL> alter database add logfile group 2 ('/u02/oradata/ora112/redologs/redo02.log' , '/u03/oradata/ora112/redologs/redo02.log ') size 100M;
```

<br/>

3. Need to recreate group 3 and its files.

Since the group is active, you need to switch to the next file group, making group 2 INACTIVE.

To switch, execute the following commands:

    SQL> alter system checkpoint;
    SQL> alter system switch logfile;

Delete files of group 3

    SQL> alter database drop logfile group 3;

<br/>

    SQL> quit

<br/>

    $ rm /u02/oradata/ora112/redo03.log

<br/>

    $ sqlplus / as sysdba

<br/>

```sql
SQL> alter database add logfile group 3 ('/u02/oradata/ora112/redologs/redo03.log', '/u03/oradata/ora112/redologs/redo03.log ') size 100M;
```

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

     1 /u02/oradata/ora112/redologs/redo01.log  CURRENT     100
     1 /u03/oradata/ora112/redologs/redo01.log  CURRENT     100
     2 /u02/oradata/ora112/redologs/redo02.log  UNUSED      100
     2 /u03/oradata/ora112/redologs/redo02.log  UNUSED      100
     3 /u02/oradata/ora112/redologs/redo03.log  UNUSED      100
     3 /u03/oradata/ora112/redologs/redo03.log  UNUSED      100

<br/>

    SQL> quit

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
