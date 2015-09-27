---
layout: page
title: Oracle DataBase 12c - Linux - Change default datafile location
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-change-default-datafile-location/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Change default datafile location



To create folders for files:

	$ mkdir -p /u02/oracle/oradata/12.1/${ORACLE_SID}/DATAFILE/data
	$ mkdir -p /u02/oracle/oradata/12.1/${ORACLE_SID}/DATAFILE/indexes
	$ mkdir -p /u02/oracle/oradata/12.1/${ORACLE_SID}/DATAFILE/undo
	$ mkdir -p /u02/oracle/oradata/12.1/${ORACLE_SID}/DATAFILE/temp

<br/>

	$ sqlplus / as sysdba

<br/>

	SQL> select name from v$datafile;


<br/>

	NAME
	--------------------------------------------------------------------------------
	/u02/oracle/oradata/12.1/orcl12/system01.dbf
	/u02/oracle/oradata/12.1/orcl12/sysaux01.dbf
	/u02/oracle/oradata/12.1/orcl12/undotbs01.dbf
	/u02/oracle/oradata/12.1/orcl12/users01.dbf


<br/>

	SQL> shutdown immediate;


<br/>

    SQL> startup mount;


<br/>

	SQL> HOST mv /u02/oracle/oradata/12.1/orcl12/system01.dbf /u02/oracle/oradata/12.1/${ORACLE_SID}/DATAFILE/data/system01.dbf
	SQL> HOST mv /u02/oracle/oradata/12.1/orcl12/sysaux01.dbf /u02/oracle/oradata/12.1/${ORACLE_SID}/DATAFILE/data/sysaux01.dbf
	SQL> HOST mv /u02/oracle/oradata/12.1/orcl12/users01.dbf /u02/oracle/oradata/12.1/${ORACLE_SID}/DATAFILE/data/users01.dbf

	SQL> HOST mv /u02/oracle/oradata/12.1/orcl12/undotbs01.dbf /u02/oracle/oradata/12.1/${ORACLE_SID}/DATAFILE/undo/undotbs01.dbf

<br/>

	SQL> select name from v$tempfile;


<br/>

	NAME
	------------------------------------------------
	/u02/oracle/oradata/12.1/orcl12/temp01.dbf


<br/>

	SQL> HOST mv /u02/oracle/oradata/12.1/orcl12/temp01.dbf /u02/oracle/oradata/12.1/${ORACLE_SID}/DATAFILE/temp/temp01.dbf


<br/>


	SQL> ALTER DATABASE RENAME FILE '/u02/oracle/oradata/12.1/orcl12/system01.dbf' TO '/u02/oracle/oradata/12.1/orcl12/DATAFILE/data/system01.dbf';

	SQL> ALTER DATABASE RENAME FILE '/u02/oracle/oradata/12.1/orcl12/sysaux01.dbf' TO '/u02/oracle/oradata/12.1/orcl12/DATAFILE/data/sysaux01.dbf';

	SQL> ALTER DATABASE RENAME FILE '/u02/oracle/oradata/12.1/orcl12/users01.dbf'  TO '/u02/oracle/oradata/12.1/orcl12/DATAFILE/data/users01.dbf';




	SQL> ALTER DATABASE RENAME FILE '/u02/oracle/oradata/12.1/orcl12/undotbs01.dbf' TO '/u02/oracle/oradata/12.1/orcl12/DATAFILE/undo/undotbs01.dbf';

	SQL> ALTER DATABASE RENAME FILE '/u02/oracle/oradata/12.1/orcl12/temp01.dbf' TO '/u02/oracle/oradata/12.1/orcl12/DATAFILE/temptemp01.dbf';


 <br/>

	SQL> alter database open;

<br/>

	SQL> quit
