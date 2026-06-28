---
layout: page
title: Description of the system to be configured
description: Description of the system to be configured
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/info-about-env/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Description of the system to be configured

<br/>

1. Installing 2 servers as described <a href="/database/installation/single/asm/linux/6.7/oracle/12.1/">here</a>

**On the second (StandBy) server, I do not create an instance. It will be copied from the first**

    Primary:
    Hostname: moscow
    IP: 192.168.1.11
    DB_Name: orcl12
    DB_UNIQUE_NAME: master

<br/>

    StandBy:
    Hostname: piter
    IP: 192.168.1.12
    DB_Name: orcl12
    DB_UNIQUE_NAME: slave

<br/>

DB_UNIQUE_NAME - can be set when creating the instance. When selecting - choose Advanced.

<img src="https://img.oracledba.net/oracle-database-installation/distributed/dataguard/linux/6.7/oracle/12.1/db-unique-name.png" border="0" alt="oracle database software installation"><br/><br/>

Or by manipulating the pfile.
