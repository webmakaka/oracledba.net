---
layout: page
title: Configuring Oracle network services for creating a duplicate of primary on standby
description: Configuring Oracle network services for creating a duplicate of primary on standby
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/setup-oracle-network-services/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Configuring Oracle network services for creating a duplicate of primary on standby

<br/>

### Configuring Listener on Primary

<!--

Probably need to create listener on GRID_HOME rather than $ORACLE_HOME

    $ cd $GRID_HOME/network/admin

<br/>

    $ cp listener.ora listener.ora.bkp

-->

    $ cd $ORACLE_HOME/network/admin

<br/>

    $ vi listener.ora

<br/>

```
LISTENER =
(ADDRESS_LIST=
    (ADDRESS=(PROTOCOL=tcp)(HOST=moscow.localdomain)(PORT=1521))
    (ADDRESS=(PROTOCOL=ipc)(KEY=extproc)))

SID_LIST_LISTENER=
      (SID_LIST=
          (SID_DESC=
          (GLOBAL_DBNAME=master)
          (ORACLE_HOME=/u01/oracle/database/12.1)
          (SID_NAME=orcl12)
          )
      )
```

<br/>

### Configuring Listener on Standby

    $ cd $ORACLE_HOME/network/admin

<br/>

    $ vi listener.ora

<br/>

```
LISTENER =
(ADDRESS_LIST=
    (ADDRESS=(PROTOCOL=tcp)(HOST=piter.localdomain)(PORT=1521))
    (ADDRESS=(PROTOCOL=ipc)(KEY=extproc)))

SID_LIST_LISTENER=
      (SID_LIST=
          (SID_DESC=
          (GLOBAL_DBNAME=slave)
          (ORACLE_HOME=/u01/oracle/database/12.1)
          (SID_NAME=orcl12)
          )
      )
```

<br/>

### Configuring tnsnames.ora on Primary and Standby

    $ vi tnsnames.ora

<br/>

```
***

primary =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = moscow.localdomain)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = master)
    )
  )


standby =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = piter.localdomain)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = slave)
    )
  )
```

<br/>

### Checking network services

    $ lsnrctl stop

<br/>

    $ lsnrctl start

<br/>

```
$ lsnrctl status

LSNRCTL for Linux: Version 12.1.0.2.0 - Production on 15-AUG-2015 15:31:07

Copyright (c) 1991, 2014, Oracle.  All rights reserved.

Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=moscow.localdomain)(PORT=1521))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 12.1.0.2.0 - Production
Start Date                15-AUG-2015 15:30:08
Uptime                    0 days 0 hr. 0 min. 59 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /u01/oracle/database/12.1/network/admin/listener.ora
Listener Log File         /u01/oracle/diag/tnslsnr/moscow/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=moscow.localdomain)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=extproc)))
Services Summary...
Service "+ASM" has 1 instance(s).
  Instance "+ASM", status READY, has 1 handler(s) for this service...
Service "master" has 2 instance(s).
  Instance "orcl12", status UNKNOWN, has 1 handler(s) for this service...
  Instance "orcl12", status READY, has 1 handler(s) for this service...
Service "master_DGB" has 1 instance(s).
  Instance "orcl12", status READY, has 1 handler(s) for this service...
Service "orcl12XDB" has 1 instance(s).
  Instance "orcl12", status READY, has 1 handler(s) for this service...
The command completed successfully
```

<br/>

The master and slave services need to come up on each server. They don't start immediately. Sometimes you need to wait about 5 minutes.

<br/>

**tnsping should work from both servers**:

    $ tnsping primary
    $ tnsping standby

Should return OK.
