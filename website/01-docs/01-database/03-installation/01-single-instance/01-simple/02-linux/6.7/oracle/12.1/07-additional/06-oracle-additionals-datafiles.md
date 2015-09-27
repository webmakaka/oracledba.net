---
layout: page
title: Oracle DataBase 12c - Linux - Extending tablespace
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-additionals-datafiles/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Extending tablespace (creating additional datafiles for tablespaceses)


	$ sqlplus / as sysdba


Show location database files on file system:


	SQL> set linesize 200;
	SQL> set pagesize 0;
	SQL> col name format a40;
	SQL> SELECT file#, name, status
	FROM v$datafile;


1) Create new tablespace for data and indexes:


	SQL> CREATE TABLESPACE "MY_DATA"
	DATAFILE '/u02/oracle/oradata/12.1/orcl12/DATAFILE/data/my_data01.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

	SQL> CREATE TABLESPACE "MY_INDEXES"
	DATAFILE '/u02/oracle/oradata/12.1/orcl12/DATAFILE/indexes/my_indexes01.dbf' SIZE 2G AUTOEXTEND OFF;


To add additional space for data you could execute next command:

	SQL> ALTER TABLESPACE “MY_DATA”
	ADD DATAFILE  '/u02/oracle/oradata/12.1/orcl12/DATAFILE/data/my_data02.dbf' SIZE 2G AUTOEXTEND OFF;

<br/>

	SQL> ALTER TABLESPACE “MY_INDEXES”
	ADD DATAFILE  '/u02/oracle/oradata/12.1/orcl12/DATAFILE/indexes/my_indexes02.dbf' SIZE 2G AUTOEXTEND OFF;



2) If you need to create additional tablespace for UNDO:


	SQL> CREATE undo tablespace "UNDO" datafile '/u02/oracle/oradata/12.1/orcl12/DATAFILE/undo/undo01.dbf' size 1G autoextend off;


Setup created tablespace as default tablespace for UNDO.

	SQL> ALTER SYSTEM SET UNDO_TABLESPACE = "UNDO";

Previous tablespace you could delete:

	SQL> drop tablespace UNDOTBS1;


3) Create new temporary tablespace:


	SQL> CREATE TEMPORARY TABLESPACE "MY_TEMP"
	TEMPFILE '/u02/oracle/oradata/12.1/orcl12/DATAFILE/temp/my_temp01.dbf' SIZE 2G AUTOEXTEND OFF;

Add additional datafile for temp tablespace

	SQL> ALTER TABLESPACE “MY_TEMP”
	ADD TEMPFILE '/u02/oracle/oradata/12.1/orcl12/DATAFILE/temp/my_temp02.dbf' SIZE 2G AUTOEXTEND OFF;


<br/>

	SQL> quit
