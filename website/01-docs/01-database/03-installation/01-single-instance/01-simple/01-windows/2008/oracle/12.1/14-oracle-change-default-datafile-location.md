---
layout: page
title: Oracle DataBase Server 12.1 installation on Windows 2008 Server - Change default datafile location
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-change-default-datafile-location/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Windows 2008 Server]</a>: Change default datafile location

<br/>


    sqlplus / as sysdba

To create folders for files:

    SQL> HOST md E:\app\oracle\oradata\ora121\data
    SQL> HOST md E:\app\oracle\oradata\ora121\indexes
    SQL> HOST md E:\app\oracle\oradata\ora121\undo
    SQL> HOST md E:\app\oracle\oradata\ora121\temp

<br/>

    SQL> select name from v$datafile;

<br/>

    SQL> shutdown immediate;

<br/>

    SQL> startup mount;

<br/>

    SQL> HOST MOVE E:\app\oracle\oradata\ora121\SYSTEM01.DBF E:\app\oracle\oradata\ora121\data\SYSTEM01.DBF
    SQL> HOST MOVE E:\app\oracle\oradata\ora121\SYSAUX01.DBF E:\app\oracle\oradata\ora121\data\SYSAUX01.DBF
    SQL> HOST MOVE E:\app\oracle\oradata\ora121\USERS01.DBF E:\app\oracle\oradata\ora121\data\USERS01.DBF
    SQL> HOST MOVE E:\app\oracle\oradata\ora121\UNDOTBS01.DBF E:\app\oracle\oradata\ora121\undo\UNDOTBS01.DBF
    SQL> HOST MOVE E:\app\oracle\oradata\ora121\TEMP01.DBF E:\app\oracle\oradata\ora121\temp\TEMP01.DBF

<br/>


    SQL> ALTER DATABASE RENAME FILE 'E:\app\oracle\oradata\ora121\SYSTEM01.DBF'  TO 'E:\app\oracle\oradata\ora121\data\SYSTEM01.DBF';
    SQL> ALTER DATABASE RENAME FILE 'E:\app\oracle\oradata\ora121\SYSAUX01.DBF'  TO 'E:\app\oracle\oradata\ora121\data\SYSAUX01.DBF';
    SQL> ALTER DATABASE RENAME FILE 'E:\app\oracle\oradata\ora121\USERS01.DBF'  TO 'E:\app\oracle\oradata\ora121\data\USERS01.DBF';
    SQL> ALTER DATABASE RENAME FILE 'E:\app\oracle\oradata\ora121\UNDOTBS01.DBF'  TO 'E:\app\oracle\oradata\ora121\undo\UNDOTBS01.DBF';
    SQL> ALTER DATABASE RENAME FILE 'E:\app\oracle\oradata\ora121\TEMP01.DBF'  TO 'E:\app\oracle\oradata\ora121\temp\TEMP01.DBF';


 <br/>

    SQL> alter database open;

<br/>

    SQL> quit
