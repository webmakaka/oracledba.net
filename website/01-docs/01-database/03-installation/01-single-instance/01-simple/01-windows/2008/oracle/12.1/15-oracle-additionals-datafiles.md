---
layout: page
title: Oracle DataBase Server 12.1 installation on Windows 2008 Server - Extending tablespace (creating additional datafiles for tablespaceses)
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-additionals-datafiles/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Windows 2008 Server]</a>: Extending tablespace (creating additional datafiles for tablespaceses)

<br/>

    sqlplus / as sysdba


Show location database files on file system:

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



1) Create new tablespace for data and indexes:

    SQL> CREATE TABLESPACE "MY_DATA"
    DATAFILE 'E:\app\oracle\oradata\ora121\data\my_data01.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> CREATE TABLESPACE "MY_INDEXES"
    DATAFILE 'E:\app\oracle\oradata\ora121\indexes\my_indexes01.dbf' SIZE 2G AUTOEXTEND OFF;


To add additional space for data you could execute next command:

    SQL> ALTER TABLESPACE “MY_DATA”
    ADD DATAFILE  'E:\app\oracle\oradata\ora121\data\my_data02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> ALTER TABLESPACE “MY_INDEXES”
    ADD DATAFILE  'E:\app\oracle\oradata\ora121\indexes\my_indexes02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

2) If you need to create additional tablespace for UNDO:


    SQL> CREATE undo tablespace "UNDO" datafile 'E:\app\oracle\oradata\ora121\undo\undo01.dbf' size 1G autoextend off;


Setup created tablespace as default tablespace for UNDO.

    SQL> ALTER SYSTEM SET UNDO_TABLESPACE = "UNDO";


Previous tablespace you could delete:

    SQL> drop tablespace UNDOTBS1;


Remove old file if it not needed mote (UNDOTBS01.DBF)

<br/>

3) Create new temporary tablespace:


    SQL> CREATE TEMPORARY TABLESPACE "MY_TEMP" TEMPFILE 'E:\app\oracle\oradata\ora121\temp\my_temp01.dbf' SIZE 2G AUTOEXTEND OFF;


Add additional datafile for temp tablespace


    SQL> ALTER TABLESPACE “MY_TEMP” ADD TEMPFILE 'E:\app\oracle\oradata\ora121\temp\my_temp02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> quit
