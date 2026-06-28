---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Restrict Remote Root Login to Database Server
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Restrict Remote Root Login to Database Server
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Restrict Remote Connection to Server
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-restrict-root-access/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Restrict Remote Root Login to Database Server

Restrict root login via SSH

    # vi /etc/ssh/sshd_config

Change

    #PermitRootLogin yes

to

    PermitRootLogin no

<br/>

    # service sshd restart
