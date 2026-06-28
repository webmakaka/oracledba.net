---
layout: page
title: Extending Tablespaces (creating additional files for tablespaces)
description: Extending Tablespaces (creating additional files for tablespaces)
keywords: Oracle Database, Additional files for tablespaces
permalink: /docs/architecture/tablespaces/additional-tablespace/
---

# Extending Tablespaces (creating additional files for tablespaces)

<br/>

    $ sqlplus / as sysdba

View which data files are used by the database and where they are located:

    SQL> set linesize 200;
    SQL> set pagesize 0;
    SQL> col name format a40;

<br/>

    SQL> SELECT file#, name, status
    FROM v$datafile;

Creating a new tablespace for indexes and data:

    SQL> CREATE TABLESPACE "MY_DATA"
    DATAFILE '/u02/oradata/ora112/my_data01.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

    SQL> CREATE TABLESPACE "MY_INDEXES"
    DATAFILE '/u02/oradata/ora112/my_indexes01.dbf' SIZE 2G AUTOEXTEND OFF;

If necessary, you can add additional space for data (when such a need arises) with the following commands:

    SQL> ALTER TABLESPACE "MY_DATA"
    ADD DATAFILE  '/u02/oradata/ora112/my_data02.dbf' SIZE 2G AUTOEXTEND OFF;

For indexes:

    SQL> ALTER TABLESPACE "MY_INDEXES"
    ADD DATAFILE  '/u02/oradata/ora112/my_indexes02.dbf' SIZE 2G AUTOEXTEND OFF;

Sometimes, you need to create an additional tablespace for undo.

    SQL> create undo tablespace "UNDOTBS_01" datafile '/u02/oradata/ora112/undo01.dbf' size 1G autoextend off;
    SQL> ALTER SYSTEM SET UNDO_TABLESPACE = "undotbs_01";
    SQL> drop tablespace UNDOTBS1;

<br/>

    ALTER TABLESPACE "UNDOTBS_01" ADD DATAFILE '/u02/oradata/SID/undotbs02.dbf' SIZE 2G AUTOEXTEND OFF;

UNDO_RETENTION - (when FLASHBACK is enabled) determines the minimum time in seconds for which a change in the database can be undone (viewed). The data will be stored in UNDO_TABLESPACE (sufficient tablespace size must be ensured) and will be overwritten as needed, ensuring the minimum value specified in UNDO_RETENTION. Not supported for LOB.

Setting the UNDO_RETENTION parameter to 30 minutes

    SQL> alter system set UNDO_RETENTION = 1800;
    SQL> alter tablespace UNDOTBS_01 RETENTION GUARANTEE;

<br/>

    SQL> show parameter UNDO_RETENTION

<br/>

    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    undo_retention                       integer     1800

Create a new tablespace for temporary data.

    SQL>  CREATE TEMPORARY TABLESPACE "MY_TEMP"
    TEMPFILE '/u02/oradata/ora112/my_temp01.dbf' SIZE 2G AUTOEXTEND OFF;

Add an additional file for temporary tablespaces.

    SQL> ALTER TABLESPACE "MY_TEMP"
    ADD TEMPFILE '/u02/oradata/ora112/my_temp02.dbf' SIZE 2G AUTOEXTEND OFF;
