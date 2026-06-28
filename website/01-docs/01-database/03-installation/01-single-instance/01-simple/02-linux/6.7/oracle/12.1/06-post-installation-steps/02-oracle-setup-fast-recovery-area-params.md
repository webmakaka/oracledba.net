---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Setting FAST RECOVERY AREA Parameters
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Setting FAST RECOVERY AREA Parameters
keywords: Oracle DataBase 12c, Oracle Linux 6.7, FAST RECOVERY AREA, FRA
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-setup-fast-recovery-area-params/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Setting FAST RECOVERY AREA Parameters

<br/>

Fast Recovery Area (FRA) is space for database backups and archive log files (if redo log archiving mode is enabled). It is necessary to ensure that the database has enough space to write its data. If necessary, it can be increased and/or cleaned of outdated data. Cleaning can only be done using RMAN.

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> alter system set db_recovery_file_dest_size="20G";

<br/>

    SQL> alter system set db_recovery_file_dest="/u03/oracle/oradata/12.1/orcl12/backups";

<br/>

    SQL> show parameter db_recovery;

<br/>

    SQL> show parameter db_recovery;

    NAME				     TYPE	 VALUE
    ------------------------------------ ----------- ------------------------------
    db_recovery_file_dest		     string	 /u03/oracle/oradata/12.1/orcl12/backups
    db_recovery_file_dest_size	     big integer 20G
