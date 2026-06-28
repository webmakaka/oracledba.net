---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Setting Up Accurate Time
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Setting Up Accurate Time
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Setting Up Accurate Time
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/setup-actual-time/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Setting Up Accurate Time

Specify available ntp servers

    # vi /etc/ntp.conf

For example:

    server 0.rhel.pool.ntp.org
    server 1.rhel.pool.ntp.org
    server 2.rhel.pool.ntp.org

Make changes to the ntpd parameter file

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

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
