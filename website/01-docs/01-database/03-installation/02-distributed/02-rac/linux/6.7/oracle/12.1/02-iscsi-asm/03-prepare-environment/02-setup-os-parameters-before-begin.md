---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Pre-configuration settings
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Pre-configuration settings
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/setup-os-parameters-before-begin/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Pre-configuration settings

<br/>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1, rac2, storage, dnsserv</strong></span></td>
</tr>

</table>

<br/>

Some comments on the next 2 commands - the 1st creates a backup of the /etc/selinux/config file, and the 2nd replaces the SELINUX parameter value from enforcing to disabled

    # cp /etc/selinux/config /etc/selinux/config.bkp
    # sed -i.gres "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

The next 2 commands - the 1st creates a backup of the file, changes the timeout value from 5 to 0

    # cp /etc/grub.conf /etc/grub.conf.bkp
    # sed -i.gres "s/timeout=5/timeout=0/g" /etc/grub.conf

Disable firewall

    # service iptables stop

Prevent firewall from starting at OS boot

    # chkconfig iptables off
