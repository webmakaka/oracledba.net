---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Extending Tablespaces (Creating Additional Files for Tablespaces)
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Extending Tablespaces (Creating Additional Files for Tablespaces)
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Creating Files for Tablespaces
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-additionals-datafiles/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Extending Tablespaces (Creating Additional Files for Tablespaces)

    $ sqlplus / as sysdba

View which database files are used by the database and where they are located:

    SQL> set linesize 200;
    SQL> set pagesize 0;
    SQL> col name format a40;
    SQL> SELECT file#, name, status
    FROM v$datafile;

<br/>

**1) Creating a new tablespace for indexes and data:**

    SQL> CREATE TABLESPACE "MY_DATA"
    DATAFILE '/u02/oracle/oradata/12.1/orcl12/DATAFILE/data/my_data01.dbf' SIZE 2G AUTOEXTEND OFF;

If necessary, you can add additional space for data (when such a need arises) with the following commands:

    SQL> ALTER TABLESPACE "MY_DATA"
    ADD DATAFILE  '/u02/oracle/oradata/12.1/orcl12/DATAFILE/data/my_data02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> CREATE TABLESPACE "MY_INDEXES"
    DATAFILE '/u02/oracle/oradata/12.1/orcl12/DATAFILE/indexes/my_indexes01.dbf' SIZE 2G AUTOEXTEND OFF;

If necessary, you can add additional space for indexes (when such a need arises) with the following commands:

<br/>

    SQL> ALTER TABLESPACE "MY_INDEXES"
    ADD DATAFILE  '/u02/oracle/oradata/12.1/orcl12/DATAFILE/indexes/my_indexes02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

**2) Sometimes you need to create an additional undo tablespace.**

    SQL> CREATE undo tablespace "UNDO" datafile '/u02/oracle/oradata/12.1/orcl12/DATAFILE/undo/undo01.dbf' size 1G autoextend off;

Set the created tablespace as the default tablespace

    SQL> ALTER SYSTEM SET UNDO_TABLESPACE = "UNDO";

Delete the old tablespace

    SQL> drop tablespace UNDOTBS1;

<br/>

**3) Create a new temporary tablespace.**

    SQL> CREATE TEMPORARY TABLESPACE "MY_TEMP"
    TEMPFILE '/u02/oracle/oradata/12.1/orcl12/DATAFILE/temp/my_temp01.dbf' SIZE 2G AUTOEXTEND OFF;

Add an additional file for temporary tablespaces.

    SQL> ALTER TABLESPACE "MY_TEMP"
    ADD TEMPFILE '/u02/oracle/oradata/12.1/orcl12/DATAFILE/temp/my_temp02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> quit
