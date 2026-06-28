---
layout: page
title: Starting instance on standby
description: Starting instance on standby
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/startup-instance-on-standby/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Starting instance on standby

### Standby

    $ cd $ORACLE_HOME/dbs

Creating a pfile with a single parameter - the database name

    $ echo DB_NAME=${ORACLE_SID} > init${ORACLE_SID}.ora

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> startup nomount pfile=$ORACLE_HOME/dbs/init${ORACLE_SID}.ora

<br/>

    SQL> select status from v$instance;

    STATUS
    ------------------------------------
    STARTED
