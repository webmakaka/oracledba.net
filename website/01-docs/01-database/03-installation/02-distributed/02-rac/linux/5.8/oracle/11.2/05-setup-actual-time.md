---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Configuring time synchronization services
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Configuring time synchronization services
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Configuring time synchronization services
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/setup-actual-time/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Configuring time synchronization services

<br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);"><strong>Time settings</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
<tr>
	<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
	<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2, storage</strong></span></td>
</tr>
</table>

Specify available ntp servers

    # vi /etc/ntp.conf

<br/>

    server 0.rhel.pool.ntp.org
    server 1.rhel.pool.ntp.org
    server 2.rhel.pool.ntp.org

<!--
Configure the task scheduler

ru.pool.ntp.org servers are chosen as an example

# crontab -e

# Set the date and time via NTP
*/15 * * * * /usr/sbin/ntpdate 0.ru.pool.ntp.org 1.ru.pool.ntp.org 2.ru.pool.ntp.org 3.ru.pool.ntp.org   > /var/log/time.log


-->

Make changes to the ntpd parameters file

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
