---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Post-installation tasks
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Post-installation tasks
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Post-installation tasks
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/post-installation-tasks/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Post-installation tasks

<br/>

1.

node1

    $ vi /etc/oratab

Заменить:

+ASM1:/u01/app/grid/11.2:N
racnode:/u01/app/oracle/product/database/11.2:N

to

+ASM1:/u01/app/grid/11.2:Y
racnode:/u01/app/oracle/product/database/11.2:Y

<br/>

node2

    $ vi /etc/oratab

Заменить:

+ASM2:/u01/app/grid/11.2:N
racnode:/u01/app/oracle/product/database/11.2:N

to

+ASM2:/u01/app/grid/11.2:Y
racnode:/u01/app/oracle/product/database/11.2:Y

2. Make sure you can connect to the cluster nodes with the sqlplus command
   If not,

Shows which processes are running.

    ps -eaf | grep ora*

From this you can figure out what the instance name is.

Correct the

    vi /home/oracle11/.bash_profile

<br/>

    export ORACLE_SID=racnode1
    export ORACLE_UNQNAME=racnode1
