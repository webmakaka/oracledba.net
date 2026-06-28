---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Setting FAST RECOVERY AREA Parameters
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Setting FAST RECOVERY AREA Parameters
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, fast recovery area, FRA
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-setup-fast-recovery-area-params/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Setting FAST RECOVERY AREA Parameters

<br/>

Fast Recovery Area (FRA) is space for database backups and archive log files (if redo log archiving mode is enabled). It is necessary to ensure that the database has enough space to write its data. If necessary, it can be increased and/or cleaned of outdated data. Cleaning can only be done using RMAN.

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> alter system set db_recovery_file_dest_size="20G";

<br/>

    SQL> alter system set db_recovery_file_dest="/u03/oracle/oradata/12.2/orcl12/backups";

<br/>

    SQL> show parameter db_recovery;

<br/>

    SQL> show parameter db_recovery;

    NAME				     TYPE	 VALUE
    ------------------------------------ ----------- ------------------------------
    db_recovery_file_dest		     string	 /u03/oracle/oradata/12.2/orcl12/backups
    db_recovery_file_dest_size	     big integer 20G

<br/>

    SQL> exit
