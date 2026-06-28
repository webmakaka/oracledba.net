---
layout: page
title: Oracle Database startup and shutdown modes
description: Oracle Database startup and shutdown modes
keywords: Oracle Database, start and stop database
permalink: /docs/startup-and-shutdown-oracle-instance/
---

# Oracle Database startup and shutdown modes

## (Somewhat outdated material. Relevant primarily for version 9, needs revision)

<h2>Starting Oracle Database</h2>

<br/><br/>

STARTUP [FORCE][restrict] [MOUNT | OPEN | NOMOUNT]
<br/><br/>

<h3>STARTUP NOMOUNT</h3>

Starting the database instance: NOMOUNT state<br/>
During database instance startup, it is necessary to select the state that the instance will enter as a result.<br/>

Usually the instance is started in NOMOUNT mode only during database creation or to recreate control files, as well as when performing certain backup and recovery scenarios.

---

<br/>
<br/>
Starting the instance involves performing the following tasks:
<br/><br/>
1) Searching the $ORACLE_HOME/dbs directory for the parameter file, carried out in the following order.
<br/><br/>
• It searches for the spfileSID.ora file<br/>
• If not found, then it searches for the spfile.ora file;<br/>
• If not found, then it searches for the SID.ora file.<br/>
The searched file contains the database instance parameters;
<br/>

2. Setting the PFILE parameter in the STARTUP command overrides the default order for selecting the parameter file.<br/>
3. Allocating SGA;<br/>
4. Starting background processes.<br/>
5. Opening the alertSID.log file and trace files. <br/>

<br/>

<h3>STARTUP MOUNT</h3>

Mounting the database includes the following tasks:<br/>
Associating the database with a previously started instance:<br/>
Determining the location of control files specified in the parameter file:<br/>
Reading control files to obtain the names and status of data files and log files. However, at this point the actual existence of data files and log files is not verified.

<br/>

<h3>STARTUP OPEN</h3>

Opening the database involves performing the following tasks:

• Opening online data files;<br/>
• Opening online redo log files.<br/>

<br/>

If any of the data files or redo log files are unavailable at the time of database opening, the Oracle server returns an error.

When performing the final stage of database opening, Oracle checks the availability of all data files and redo log files, and also checks the integrity of the database. If necessary, the background process System Monitor (SMON) initiates instance recovery.

<br/>

<h2>Stopping Oracle Database</h2>

<br/><br/>
SHUTDOWN [NORMAL | TRANSACTIONAL | IMMEDIATE | ABORT]
<br/><br/>

<div align="center">

<img src="https://img.oracledba.net/architecture/shutdown.jpg" border="0" alt="Oracle Instance"><br/>

</div>

<br/><br/>

ABORT – Performs the least number of actions before stopping. After this, upon startup, the system must perform recovery. Therefore, use this mode only when necessary. It is usually used when other shutdown options don't work, when it is caused by problems arising during startup, or when you need to immediately stop the instance before a problematic situation, for example, when receiving a message that the power will be turned off in a few seconds.<br/>

IMMEDIATE – commonly used option. Uncommitted transactions are rolled back.<br/>

TRANSACTIONAL – Allows transactions to complete.<br/>

NORMAL – The instance does not stop until sessions disconnect. <br/>

<br/>
<h3>SHUTDOWN NORMAL</h3>

Normal database shutdown mode, used by default.

• New connections are not allowed.<br/>
• The Oracle server waits for all users to disconnect and only then proceeds with the database shutdown.<br/>
• Buffers from the database and redo log cache are written to disk.<br/>
• Background processes terminate and SGA is removed from memory.<br/>
• Before stopping the instance, Oracle closes and dismounts the database.<br/>
• The next startup will not require instance recovery. <br/>

<br/>

<h3>SHUTDOWN TRANSACTIONAL</h3>

Transactional shutdown ensures the preservation of client data, including the results of current actions. Database shutdown in transactional mode occurs as follows:

• No client can start a new transaction in this instance.<br/>
• The client is forcibly disconnected as soon as the current transaction completes.<br/>
• Once all transactions are complete, shutdown is performed immediately.<br/>
• The next startup will not require instance recovery. <br/>

<br/>

<h3>SHUTDOWN IMMEDIATE</h3>

Immediate database shutdown is performed as follows:

• Processing of SQL commands currently being executed by Oracle is not completed.<br/>
• The Oracle server does not wait for currently connected users to disconnect.<br/>
• Oracle rolls back all active transactions and forcibly disconnects all users.<br/>
• Oracle closes and dismounts the database before stopping the instance.<br/>
• The next startup will not require instance recovery. <br/>

<br/>

### SHUTDOWN ABORT

If normal and immediate shutdown modes don't work, an emergency database shutdown can be performed. Emergency instance shutdown is performed as follows:

All SQL commands being processed by the Oracle server are immediately cancelled.<br/>
The Oracle server does not wait for currently connected users to disconnect.<br/>
Buffers from the database and redo log cache are not written to disk.<br/>
Uncommitted transactions are not rolled back.<br/>
The database is not closed or dismounted.<br/>
The instance is removed without closing files.<br/>
The next startup will require instance recovery, which will occur automatically. <br/>
