---
layout: page
title: Oracle DataBase Server 12.1 installation on Windows 2008 Server - Setup FAST RECOVERY AREA Parameters
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-setup-fast-recovery-area-params/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Windows 2008 Server]</a>: Setup FAST RECOVERY AREA Parameters

<br/>

<!--
Fast Recovery Area (FRA) - это пространство для резервных копий базы данных и файлов архивных журналов (если включен рехим создания архивов redoжурналов). Необходимо следить за тем, чтобы у базы данных оставалось место для записи в него своих данных. При необходимости, его можно увеличивать и/или очищать от устаревших данных. Чистить можно только средствами RMAN.

-->

    sqlplus / as sysdba

<br/>

    SQL> show parameter db_recovery;

<br/>

    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- -----------
    db_recovery_file_dest                string
    db_recovery_file_dest_size           big integer 0



<br/>

    SQL> alter system set db_recovery_file_dest_size="20G";

<br/>

    SQL> alter system set db_recovery_file_dest="f:\app\oracle\oradata\ora121\backups";

<br/>

    SQL> show parameter db_recovery;

<br/>

    NAME                                 TYPE        VALUE
    ------------------------------------ ----------- ------------------------------
    db_recovery_file_dest                string      f:\app\oracle\oradata\ora121\backups
    db_recovery_file_dest_size           big integer 20G
