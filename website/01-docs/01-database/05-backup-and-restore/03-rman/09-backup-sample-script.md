---
layout: page
title: Example shell script for creating an Oracle database backup
description: Example shell script for creating an Oracle database backup
keywords: Oracle Database, RMAN, script for creating backup
permalink: /database/backup-and-restore/rman/backup-sample-script/
---

# Example shell script for creating an Oracle database backup

I haven't done this myself.
Just writing it down for reference.

The contents of the file have not been checked for correctness and accuracy!

<br/>

```shell
#!/bin/bash
. /home/oracle/.bash_profile

export ORACLE_SID=kabultest
export ORACLE_HOME=/u01/app/oracle/product/11.2.0.4/db_1

export SS=$(date +%y-%m-%d_%H%M%S)
test -d /bckp/FULL/$SS || mkdir /bckp/FULL/$SS
rman target / log=/u01/rman/kabul_${SS}.log << EOF
RUN {
   SQL 'alter system archive log current';
 backup as copy current controlfile format '/bckp/FULL/${SS}/kabul_CNT_%U_%T.ctl';
 backup  database include current controlfile format '/bckp/FULL/${SS}/kabul_DATA_%U_%T.bkp' ;
 backup  archivelog all delete input format '/bckp/FULL/${SS}/kabul_ARLG_%U_%T.arc';
 backup spfile format '/bckp/FULL/${SS}/kabul_SPFL.ora';
 }
EOF
```

<br/>

https://t.me/oracledba_net/7326
