---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Extending Tablespaces (Creating Additional Files for Tablespaces)
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Extending Tablespaces (Creating Additional Files for Tablespaces)
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Creating Files for Tablespaces
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-additionals-datafiles/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Extending Tablespaces (Creating Additional Files for Tablespaces)

<br/>

    $ sqlplus / as sysdba

View which data files are used by the database and where they are located:

    SQL> set linesize 200;
    SQL> set pagesize 0;
    SQL> col name format a40;
    SQL> SELECT file#, name, status
    FROM v$datafile;

1. Creating a new tablespace for indexes and data:


    SQL> CREATE TABLESPACE "MY_DATA"
    DATAFILE '/u02/oradata/ora112/my_data01.dbf' SIZE 2G AUTOEXTEND OFF;

If necessary, you can add additional space for data (when needed) with the following commands:

    SQL> ALTER TABLESPACE "MY_DATA"
    ADD DATAFILE  '/u02/oradata/ora112/my_data02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> CREATE TABLESPACE "MY_INDEXES"
    DATAFILE '/u02/oradata/ora112/my_indexes01.dbf' SIZE 2G AUTOEXTEND OFF;

If necessary, you can add additional space for indexes (when needed) with the following commands:

<br/>

    SQL> ALTER TABLESPACE "MY_INDEXES"
    ADD DATAFILE  '/u02/oradata/ora112/my_indexes02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/><br/>

<hr/>
<br/><br/>

2. Sometimes you need to create an additional undo tablespace.


    SQL> CREATE undo tablespace "UNDO" datafile '/u02/oradata/ora112/undo01.dbf' size 1G autoextend off;

Set the created tablespace as the default tablespace

    SQL> ALTER SYSTEM SET UNDO_TABLESPACE = "UNDO";

Delete the old tablespace

    SQL> drop tablespace UNDOTBS1;

<br/><br/>

<hr/>
<br/><br/>

3. Creating a new temporary tablespace.


    SQL> CREATE TEMPORARY TABLESPACE "MY_TEMP"
    TEMPFILE '/u02/oradata/ora112/my_temp01.dbf' SIZE 2G AUTOEXTEND OFF;

Add an additional file for temporary tablespaces.

    SQL> ALTER TABLESPACE "MY_TEMP"
    ADD TEMPFILE '/u02/oradata/ora112/my_temp02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> quit

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
