---
layout: page
title: Starting switchover on Primary
description: Starting switchover on Primary
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/broker/switchover/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Starting switchover on Primary

<br/>

    $ dgmgrl

<br/>

    DGMGRL> connect /

<br/>

    DGMGRL> SHOW DATABASE VERBOSE MASTER

    Database - master

      Role:               PRIMARY
      Intended State:     TRANSPORT-ON
      Instance(s):
        orcl12

      Properties:
        DGConnectIdentifier             = 'primary'
        ObserverConnectIdentifier       = ''
        LogXptMode                      = 'ASYNC'
        RedoRoutes                      = ''
        DelayMins                       = '0'
        Binding                         = 'optional'
        MaxFailure                      = '0'
        MaxConnections                  = '1'
        ReopenSecs                      = '300'
        NetTimeout                      = '30'
        RedoCompression                 = 'DISABLE'
        LogShipping                     = 'ON'
        PreferredApplyInstance          = ''
        ApplyInstanceTimeout            = '0'
        ApplyLagThreshold               = '0'
        TransportLagThreshold           = '0'
        TransportDisconnectedThreshold  = '30'
        ApplyParallel                   = 'AUTO'
        StandbyFileManagement           = 'AUTO'
        ArchiveLagTarget                = '0'
        LogArchiveMaxProcesses          = '4'
        LogArchiveMinSucceedDest        = '1'
        DbFileNameConvert               = ''
        LogFileNameConvert              = ''
        FastStartFailoverTarget         = ''
        InconsistentProperties          = '(monitor)'
        InconsistentLogXptProps         = '(monitor)'
        SendQEntries                    = '(monitor)'
        LogXptStatus                    = '(monitor)'
        RecvQEntries                    = '(monitor)'
        StaticConnectIdentifier         = '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=moscow.localdomain)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=master_DGMGRL)(INSTANCE_NAME=orcl12)(SERVER=DEDICATED)))'
        StandbyArchiveLocation          = 'USE_DB_RECOVERY_FILE_DEST'
        AlternateLocation               = ''
        LogArchiveTrace                 = '0'
        LogArchiveFormat                = '%t_%s_%r.dbf'
        TopWaitEvents                   = '(monitor)'

    Database Status:
    SUCCESS

<br/>

**1. Ensure standby redologs are configured on all databases.**

    SQL> SELECT TYPE, MEMBER FROM V$LOGFILE;

<br/>

**2. Ensure the LogXptMode Property is set to SYNC.**

    DGMGRL> EDIT DATABASE master SET PROPERTY 'LogXptMode'='SYNC';
    DGMGRL> EDIT DATABASE slave SET PROPERTY 'LogXptMode'='SYNC';

<br/>

**3.Specify the FastStartFailoverTarget property**

    DGMGRL> EDIT DATABASE master SET PROPERTY FastStartFailoverTarget='slave';
    DGMGRL> EDIT DATABASE slave SET PROPERTY FastStartFailoverTarget='master';

<br/>

**4.Upgrade the protection mode to MAXAVAILABILITY, if necessary.**

    DGMGRL> EDIT CONFIGURATION SET PROTECTION MODE AS MAXAVAILABILITY;

<br/>

**5. Enable Flashback Database on the Primary and Standby Databases.**

<br/>

**Primary**

    SQL> ALTER SYSTEM SET UNDO_RETENTION=3600 SCOPE=SPFILE;

    SQL> ALTER SYSTEM SET UNDO_MANAGEMENT='AUTO' SCOPE=SPFILE;

    SQL> ALTER DATABASE FLASHBACK ON;

<br/>

**Standby**

    SQL> alter database recover managed standby database cancel;

    SQL> ALTER SYSTEM SET UNDO_RETENTION=3600 SCOPE=SPFILE;

    SQL> ALTER SYSTEM SET UNDO_MANAGEMENT='AUTO' SCOPE=SPFILE;

    SQL> ALTER DATABASE FLASHBACK ON;

    SQL> alter database recover managed standby database using current logfile disconnect;

<br/>

**Primary**

    DGMGRL> ENABLE FAST_START FAILOVER;
    Enabled.

<br/>

    DGMGRL> show database master

    Database - master

      Role:               PRIMARY
      Intended State:     TRANSPORT-ON
      Instance(s):
        orcl12

      Database Warning(s):
        ORA-16819: fast-start failover observer not started

    Database Status:
    WARNING

<br/>

    DGMGRL> START OBSERVER;
    [P001 08/15 18:00:40.19] Authentication failed.
    DGM-16979: Unable to log on to the primary or standby database as SYSDBA
    Failed.

<br/>

    $ dgmgrl

    DGMGRL> connect sys/manager@primary
    Connected as SYSDBA.

    DGMGRL> START OBSERVER;
    Observer started

No need to start OBSERVER on the second server.

<br/>

    DGMGRL> show database master

    Database - master

      Role:               PRIMARY
      Intended State:     TRANSPORT-ON
      Instance(s):
        orcl12

    Database Status:
    SUCCESS

<br/>

    DGMGRL> show database slave

    Database - slave

      Role:               PHYSICAL STANDBY
      Intended State:     APPLY-ON
      Transport Lag:      0 seconds (computed 1 second ago)
      Apply Lag:          0 seconds (computed 1 second ago)
      Average Apply Rate: 60.00 KByte/s
      Real Time Query:    ON
      Instance(s):
        orcl12

    Database Status:
    SUCCESS

<br/>

    DGMGRL> show configuration verbose

    Configuration - DG_ORCL12

      Protection Mode: MaxAvailability
      Members:
      master - Primary database
        slave  - (*) Physical standby database

      (*) Fast-Start Failover target

      Properties:
        FastStartFailoverThreshold      = '30'
        OperationTimeout                = '30'
        TraceLevel                      = 'USER'
        FastStartFailoverLagLimit       = '30'
        CommunicationTimeout            = '180'
        ObserverReconnect               = '0'
        FastStartFailoverAutoReinstate  = 'TRUE'
        FastStartFailoverPmyShutdown    = 'TRUE'
        BystandersFollowRoleChange      = 'ALL'
        ObserverOverride                = 'FALSE'
        ExternalDestination1            = ''
        ExternalDestination2            = ''
        PrimaryLostWriteAction          = 'CONTINUE'

    Fast-Start Failover: ENABLED

      Threshold:          30 seconds
      Target:             slave
      Observer:           moscow.localdomain
      Lag Limit:          30 seconds (not in use)
      Shutdown Primary:   TRUE
      Auto-reinstate:     TRUE
      Observer Reconnect: (none)
      Observer Override:  FALSE

    Configuration Status:
    SUCCESS

<br/>

    DGMGRL> switchover to slave;
    Performing switchover NOW, please wait...
    Operation requires a connection to instance "orcl12" on database "slave"
    Connecting to instance "orcl12"...
    ORA-01017: invalid username/password; logon denied

    Warning: You are no longer connected to ORACLE.

    	connect to instance "orcl12" of database "slave"

<br/>

### Let's go

        DGMGRL> connect sys/manager@primary
        Connected as SYSDBA.

<br/>

        DGMGRL> switchover to slave;
        Performing switchover NOW, please wait...
        Operation requires a connection to instance "orcl12" on database "slave"
        Connecting to instance "orcl12"...
        Connected as SYSDBA.
        New primary database "slave" is opening...
        Oracle Clusterware is restarting database "master" ...
        Switchover succeeded, new primary is "slave"

<br/>

## Checking the results

    DGMGRL> show configuration

    Configuration - DG_ORCL12

      Protection Mode: MaxAvailability
      Members:
      slave  - Primary database
        master - (*) Physical standby database

    Fast-Start Failover: ENABLED

    Configuration Status:
    SUCCESS   (status updated 50 seconds ago)

<br/>

**On the former primary (master)**

    SQL> select open_mode, database_role from v$database;

    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ ONLY WITH APPLY PHYSICAL STANDBY

**On the former standby (slave)**

    SQL> select open_mode, database_role from v$database;

    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ WRITE	     PRIMARY

<br/>

Let's switch logs

    SQL> alter system switch logfile;

Both instances have the same number of archive logs.

    SQL> select max(sequence#) from v$archived_log;

    MAX(SEQUENCE#)
    --------------
     	    66

If not, you can enable on the former primary (master)

    SQL> alter databaser recover manager current logfile disconnect

<br/>

**Try creating a tablespace on the former standby (slave)**

    SQL> create tablespace test datafile '+DATA' size 10M autoextend off;

<br/>

**Check the result on the former primary (master)**

    SQL> select name from v$tablespace;

    NAME
    ------------------------------
    SYSTEM
    SYSAUX
    UNDOTBS1
    TEMP
    USERS
    TEST

    6 rows selected.

<br/>

### Switchover back to work as before

    $ dgmgrl

    DGMGRL> connect sys/manager@primary
    DGMGRL> switchover to master;

During switchover, one of the instances went down. I had to manually bring it up and restart the listener. I initially thought I would have to perform the operation again, but it wasn't necessary.

    DGMGRL> show configuration

    Configuration - DG_ORCL12

      Protection Mode: MaxAvailability
      Members:
      master - Primary database
        slave  - (*) Physical standby database

    Fast-Start Failover: ENABLED

    Configuration Status:
    SUCCESS   (status updated 13 seconds ago)

<br/>

    DGMGRL> show database master

    Database - master

      Role:               PRIMARY
      Intended State:     TRANSPORT-ON
      Instance(s):
        orcl12

    Database Status:
    SUCCESS

<br/>

    DGMGRL> show database slave

    Database - slave

      Role:               PHYSICAL STANDBY
      Intended State:     APPLY-ON
      Transport Lag:      0 seconds (computed 1 second ago)
      Apply Lag:          0 seconds (computed 1 second ago)
      Average Apply Rate: 3.00 KByte/s
      Real Time Query:    ON
      Instance(s):
        orcl12

    Database Status:
    SUCCESS

<br/><br/>

An article helped:  
http://oracleinstance.blogspot.ru/2010/01/configuration-of-10g-data-guard-broker.html

What is an OBSERVER and why it is needed, I don't know yet.  
Can it be done simpler? I don't know that either.
