---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Creating oracle11 user and groups
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Creating oracle11 user and groups
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Creating oracle11 user and groups
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/users-and-groups-creation/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Creating oracle11 user and groups

<br/>

System parameter configuration (performed on both cluster nodes)

Before making changes to configuration scripts, create their backups:

    # {
    cp /etc/sysctl.conf /etc/sysctl.conf.bkp
    cp /etc/security/limits.conf /etc/security/limits.conf.bkp
    cp /etc/pam.d/login /etc/pam.d/login.bkp
    cp /etc/profile /etc/profile.bkp
    }

Create groups:

    # groupadd -g 1000 oinstall
    # groupadd -g 1001 dba
    # groupadd -g 1002 oper

Create the oracle11 user, specify that he will be a member of dba and oinstall groups and his home directory will be /home/oracle11

    # useradd -g oinstall -G dba -d /home/oracle11 oracle11

Set the password for oracle11 user

    # passwd oracle11
