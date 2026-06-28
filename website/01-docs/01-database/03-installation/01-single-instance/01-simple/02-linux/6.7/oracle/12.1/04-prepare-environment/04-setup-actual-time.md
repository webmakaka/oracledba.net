---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring Time Synchronization Services
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring Time Synchronization Services
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Configuring Time Synchronization Services
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-actual-time/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Configuring Time Synchronization Services

Specify available ntp servers

    # vi /etc/ntp.conf

For example:

server 0.rhel.pool.ntp.org<br/>
server 1.rhel.pool.ntp.org<br/>
server 2.rhel.pool.ntp.org<br/>

<br/><br/>
You need to make changes to the ntpd parameter file

    # vi /etc/sysconfig/ntpd

replace

    # Drop root to id 'ntp:ntp' by default.
    OPTIONS="-u ntp:ntp -p /var/run/ntpd.pid"

with

    # Drop root to id 'ntp:ntp' by default.
    # OPTIONS="-u ntp:ntp -p /var/run/ntpd.pid"
    OPTIONS="-x -u ntp:ntp -p /var/run/ntpd.pid"

<br/>

    # service ntpd restart
