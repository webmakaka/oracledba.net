---
layout: page
title: Oracle RAC 12.1 SHARED FILE SYSTEM - Создание экземпляра (instance) базы данных
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/oracle-instance-creation/
---


# [Инсталляция Oracle RAC 12.1 SHARED FILE SYSTEM]: Создание экземпляра (instance) базы данных


<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1</strong></span></td>
	</tr>
</table>

<br/>

	# mkdir -p /u02/fast_recovery_area
	# chown -R oracle12:dba /u02/fast_recovery_area


	# mkdir -p /u02/oradata
	# chown -R oracle12:dba /u02/oradata

<br/>

	# su - oracle12

<br/>

	$ export DISPLAY=192.168.1.5:0.0

<br/>

	$ dbca


<br/><br/>


<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_01.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_02.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>


<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_03.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_04.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_05.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_06.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_07.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_08.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_09.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_10.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_11.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_12.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_13.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_14.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_15.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_16.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_17.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_18.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_19.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_20.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>



	$ sqlplus / as sysdba

	SQL*Plus: Release 12.1.0.2.0 Production on Tue Aug 25 20:08:26 2015

	Copyright (c) 1982, 2014, Oracle.  All rights reserved.


	Connected to:
	Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
	With the Partitioning, Real Application Clusters, OLAP, Advanced Analytics
	and Real Application Testing options


<br/>

	SQL> select status from v$instance;

	STATUS
	------------
	OPEN


<br/>

	SQL> col INST_NUMBER format 5;
	SQL> col INST_NAME format a30;

<br/>

	SQL> SELECT * FROM v$active_instances;

<br/>

	INST_NUMBER INST_NAME			       CON_ID
	----------- ------------------------------ ----------
		  0 rac1.localdomain:rac121		    0


		  0 rac2.localdomain:rac122		    0



<br/>

	https://192.168.1.11:5500/em/
	https://192.168.1.12:5500/em/

	https://rac12-scan:5500/em/




<br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/01-shared-file-system/03-oracle-instance-creation/oracle-instance-creation_21.png" border="0" alt="Oracle RAC installation Shared File System"><br/><br/>
