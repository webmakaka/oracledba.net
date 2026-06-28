---
layout: page
title: Oracle Database Scheduler
description: Oracle Database Scheduler
keywords: Oracle Database, Scheduler
permalink: /docs/architecture/other/sheduler/
---

# Oracle Database Scheduler

Scheduler - helps automate tasks inside the Oracle database. Consists of
five basic components:

<ul>
    <li>jobs</li>
    <li>schedules</li>
    <li>programs</li>
    <li>events</li>
    <li>chains</li>
</ul>

```sql
SQL> set pagesize 0;
SQL> SELECT owner, job_name, job_type FROM dba_scheduler_jobs;
```

<br/>

```
SYS                            XMLDB_NFS_CLEANUP_JOB          STORED_PROCEDURE
SYS                            SM$CLEAN_AUTO_SPLIT_MERGE      PLSQL_BLOCK
SYS                            RSE$CLEAN_RECOVERABLE_SCRIPT   PLSQL_BLOCK
SYS                            FGR$AUTOPURGE_JOB              PLSQL_BLOCK
SYS                            BSLN_MAINTAIN_STATS_JOB
SYS                            DRA_REEVALUATE_OPEN_FAILURES   STORED_PROCEDURE
SYS                            HM_CREATE_OFFLINE_DICTIONARY   STORED_PROCEDURE
SYS                            ORA$AUTOTASK_CLEAN
SYS                            FILE_WATCHER
SYS                            PURGE_LOG
ORACLE_OCM                     MGMT_STATS_CONFIG_JOB          STORED_PROCEDURE
ORACLE_OCM                     MGMT_CONFIG_JOB                STORED_PROCEDURE
EXFSYS                         RLM$SCHDNEGACTION              PLSQL_BLOCK
EXFSYS                         RLM$EVTCLEANUP                 PLSQL_BLOCK

14 rows selected.
```
