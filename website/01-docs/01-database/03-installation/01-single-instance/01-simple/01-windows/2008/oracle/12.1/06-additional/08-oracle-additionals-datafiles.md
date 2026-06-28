---
layout: page
title: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Extending Tablespaces (Creating Additional Files for Tablespaces)
description: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Extending Tablespaces (Creating Additional Files for Tablespaces)
keywords: Oracle DataBase, Installation, Windows 2008, Creating Additional Files for Tablespaces
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-additionals-datafiles/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server]</a>: Extending Tablespaces (Creating Additional Files for Tablespaces)

<br/>

    sqlplus / as sysdba

View which data files are used by the database and where they are located:

    SQL> set linesize 200;
    SQL> set pagesize 0;
    SQL> col name format a40;

<br/>

    SQL> SELECT file#, name, status
    FROM v$datafile;

<br/>

    SELECT file#, name, status
    FROM v$tempfile;

<br/>

### Creating a new tablespace for indexes and data:

    SQL> CREATE TABLESPACE "MY_DATA"
    DATAFILE 'E:\app\oracle\oradata\ora121\data\my_data01.dbf' SIZE 2G AUTOEXTEND OFF;

If necessary, you can add additional space for data (when needed) with the following commands:

    SQL> ALTER TABLESPACE "MY_DATA"
    ADD DATAFILE  'E:\app\oracle\oradata\ora121\data\my_data02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> CREATE TABLESPACE "MY_INDEXES"
    DATAFILE 'E:\app\oracle\oradata\ora121\indexes\my_indexes01.dbf' SIZE 2G AUTOEXTEND OFF;

If necessary, you can add additional space for indexes (when needed) with the following commands:

    SQL> ALTER TABLESPACE "MY_INDEXES"
    ADD DATAFILE  'E:\app\oracle\oradata\ora121\indexes\my_indexes02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

### Creating an additional undo tablespace.

    SQL> CREATE undo tablespace "UNDO" datafile 'E:\app\oracle\oradata\ora121\undo\undo01.dbf' size 1G autoextend off;

Set the created tablespace as the default tablespace

    SQL> ALTER SYSTEM SET UNDO_TABLESPACE = "UNDO";

Delete the old tablespace

    SQL> drop tablespace UNDOTBS1;

Delete the old tablespace file (UNDOTBS01.DBF)

<br/>

### Creating a new temporary tablespace.

    SQL> CREATE TEMPORARY TABLESPACE "MY_TEMP" TEMPFILE 'E:\app\oracle\oradata\ora121\temp\my_temp01.dbf' SIZE 2G AUTOEXTEND OFF;

Add an additional file for temporary tablespaces.

    SQL> ALTER TABLESPACE "MY_TEMP" ADD TEMPFILE 'E:\app\oracle\oradata\ora121\temp\my_temp02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> quit
