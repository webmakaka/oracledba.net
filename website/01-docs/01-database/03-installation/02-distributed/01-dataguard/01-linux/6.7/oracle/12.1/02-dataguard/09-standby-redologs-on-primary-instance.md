---
layout: page
title: Creating standby redologs on primary
description: Creating standby redologs on primary
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/standby-redologs-on-primary-instance/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Creating standby redologs on primary

<br/>

A standby redo log is required for the maximum protection and maximum availability modes and the LGWR ASYNC transport mode is recommended for all databases. Data Guard can recover and apply more redo data from a standby redo log than from archived redo log files alone.

Written in an article on habrahabr

> Standby redo logs are only needed on the standby database for writing data stored in redo logs on the primary database. On the primary database, they are needed if we switch it to standby mode and use real-time apply redo. Standby redo log files must be the same size as online redo logs.

However, instructions usually create them on the primary, and then when creating the duplicate, they are also created on the Standby instance. Apparently, so that you can switch from one database to another without unnecessary manipulation.

<br/>

### On Primary

```
SQL> select max (bytes), count (1) from v$log;

MAX(BYTES)   COUNT(1)
---------- ----------
    52428800	    3
```

<br/>

```
$ cd ~
$ . asm.sh
```

<br/>

```
$ asmcmd
ASMCMD> mkdir +DATA/MASTER/STANDBYLOGS/
ASMCMD> mkdir +ARCH/MASTER/STANDBYLOGS/
ASMCMD> exit
```

<br/>

```
$ source ~/.bash_profile
```

<br/>

```
$ sqlplus / as sysdba
```

<br/>

```
$ alter system set standby_file_management=manual scope=both;
```

<br/>

The quantity should be 1 more than the number of regular redo log groups on primary (see first query).
Don't know why, will look into it later, though probably won't.

<!--

	SQL>
	ALTER DATABASE ADD STANDBY LOGFILE GROUP 4 '+DATA/MASTER/STANDBYLOG/stby_4.log' SIZE 52428800;
	ALTER DATABASE ADD STANDBY LOGFILE GROUP 5 '+DATA/MASTER/STANDBYLOG/stby_5.log' SIZE 52428800;
	ALTER DATABASE ADD STANDBY LOGFILE GROUP 6 '+DATA/MASTER/STANDBYLOG/stby_6.log' SIZE 52428800;
	ALTER DATABASE ADD STANDBY LOGFILE GROUP 7 '+DATA/MASTER/STANDBYLOG/stby_7.log' SIZE 52428800;

-->

```
SQL>
ALTER DATABASE ADD STANDBY LOGFILE GROUP 4 ('+ARCH/MASTER/STANDBYLOGS/stby_4.log', '+DATA/MASTER/STANDBYLOG/stby_4.log') SIZE 52428800;
ALTER DATABASE ADD STANDBY LOGFILE GROUP 5 ('+ARCH/MASTER/STANDBYLOGS/stby_5.log', '+DATA/MASTER/STANDBYLOG/stby_5.log') SIZE 52428800;
ALTER DATABASE ADD STANDBY LOGFILE GROUP 6 ('+ARCH/MASTER/STANDBYLOGS/stby_6.log', '+DATA/MASTER/STANDBYLOG/stby_6.log') SIZE 52428800;
ALTER DATABASE ADD STANDBY LOGFILE GROUP 7 ('+ARCH/MASTER/STANDBYLOGS/stby_7.log', '+DATA/MASTER/STANDBYLOG/stby_7.log') SIZE 52428800;
```

<br/>

```
SQL> alter system set standby_file_management=auto scope=both;
```

<br/>

// Some useful information can be viewed in v\$standby_log view.

```
show parameter standby_file_management

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
standby_file_management 	     string	 AUTO
```

<br/>

```
SQL> select group#,status,bytes/1024/1024 mb from v$standby_log;

    GROUP# STATUS	      MB
---------- ---------- ----------
        4 UNASSIGNED	      50
        5 UNASSIGNED	      50
        6 UNASSIGNED	      50
        7 UNASSIGNED	      50

SQL> select TYPE, MEMBER from v$logfile where TYPE='STANDBY';
```
