---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Creating directory structure and assigning necessary permissions
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Creating directory structure and assigning necessary permissions
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Creating directory structure and assigning necessary permissions
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/create-folder-structure-and-user-permissions/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Creating directory structure and assigning necessary permissions

<br/>

Must be performed on each cluster node:

Quite an inconvenient directory layout, due to the fact that different directories require
different permission sets. + when making changes, the installer may complain.

    # mkdir -p /u01/app/oraInventory
    # chown -R oracle11:oinstall /u01/app/oraInventory
    # chmod -R 775 /u01/app/oraInventory

<br/>

    # mkdir -p /u01/app/grid/11.2
    # chown -R oracle11:oinstall /u01/app/grid/11.2
    # chmod -R 775 /u01/app/grid/11.2

<br/>

    # mkdir -p /u01/app/oracle/product/rac/11.2
    # chown -R oracle11:oinstall /u01/app/oracle
    # chmod -R 775 /u01/app/oracle
