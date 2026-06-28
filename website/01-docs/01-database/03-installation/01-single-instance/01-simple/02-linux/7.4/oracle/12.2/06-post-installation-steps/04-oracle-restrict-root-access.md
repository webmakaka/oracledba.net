---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Restrict Remote Root Login to Database Server
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Restrict Remote Root Login to Database Server
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, restrict root
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-restrict-root-access/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Restrict Remote Root Login to Database Server

<br/>

Restrict root login via SSH

    # vi /etc/ssh/sshd_config

Change

    #PermitRootLogin yes

to

    PermitRootLogin no

<br/>

    # /bin/systemctl restart sshd.service
