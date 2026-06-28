---
layout: page
title: Checking RMAN connection to both Instances
description: Checking RMAN connection to both Instances
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/rman-connection-check/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Checking RMAN connection to both Instances

### Primary

manager - my password created during database installation

<br/>

    $ rman target sys/manager@primary auxiliary sys/manager@standby

    Recovery Manager: Release 12.1.0.2.0 - Production on Thu Aug 13 17:16:07 2015

    Copyright (c) 1982, 2014, Oracle and/or its affiliates.  All rights reserved.

    connected to target database: ORCL12 (DBID=3487298206)
    connected to auxiliary database: ORCL12 (not mounted)

<br/>

### If it didn't work, you can run commands separately on Primary and Standby:

    $ rman target sys/manager@primary

<br/>

    $ rman target sys/manager@standby
