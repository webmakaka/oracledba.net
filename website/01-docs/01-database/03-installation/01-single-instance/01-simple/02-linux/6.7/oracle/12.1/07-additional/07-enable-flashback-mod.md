---
layout: page
title: Oracle DataBase 12c - Linux - Enable FLASH BACK mode
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/enable-flashback-mod/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Enable FLASH BACK mode




FlashBack could help if you need to restore changes or look previous values of record in the database.
With this option server needs additional resources, because it should store additional information in the database.

	$ sqlplus / as sysdba

<br/>

	SQL> shutdown immediate;
	SQL> startup mount exclusive;
	SQL> alter database flashback on;
	SQL> alter database open;

<br/>

	SQL> select flashback_on from v$database;

<br/>

	FLASHBACK_ON
	------------------
	YES


UNDO_RETENTION - (when server works in Flash Back mode) this parameter is setup minimum time in seconds what server should store data for undo changes. Data for undo will store in the UNDO_TABLESPACE and you should provide enough space in this tablespace.


<br/>

Setup parameter UNDO_RETENTION equal 30 minutes


	SQL> alter system set UNDO_RETENTION = 1800;
	SQL> alter tablespace UNDO RETENTION GUARANTEE;



<br/>


	SQL> show parameter UNDO_RETENTION



<br/>

	NAME                                 TYPE        VALUE
	------------------------------------ ----------- ------------------------------
	undo_retention                       integer     1800


<br/>

	SQL> quit
