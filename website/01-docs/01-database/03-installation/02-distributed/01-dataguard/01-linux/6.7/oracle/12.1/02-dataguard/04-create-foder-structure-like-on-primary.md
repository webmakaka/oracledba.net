---
layout: page
title: Creating directories on standby that exist on primary
description: Creating directories on standby that exist on primary
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/create-foder-structure-like-on-primary/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Creating directories on standby that exist on primary

The point of this step is that if, for example, a directory where files need to be copied is specified but does not exist on the server, the copy procedure will fail.

In my case, it only failed due to the missing directory /u01/oracle/admin/orcl12/adump

### On Primary

    SQL> show parameter audit

    NAME				     TYPE	 VALUE
    ------------------------------------ ----------- ------------------------------
    audit_file_dest 		     string	 /u01/oracle/admin/orcl12/adump
    audit_sys_operations		     boolean	 TRUE
    audit_syslog_level		     string
    audit_trail			     string	 DB
    unified_audit_sga_queue_size	     integer	 1048576

<br/>

### On Standby

    $ mkdir -p /u01/oracle/admin/orcl12/adump
