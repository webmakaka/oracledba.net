---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Selecting packages for autostart
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Selecting packages for autostart
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Selecting packages for autostart
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/autostart-only-packages-what-needed/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Selecting packages for autostart

<br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Selecting packages for autostart:</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2, storage</strong></span></td>
</tr>

</table>

// View which programs currently autostart at system boot.

    # chkconfig --list | grep '3:on\|4:on\|5:on'  |awk '{print $1}' | sort

// Create a backup of the output from chkconfig --list

    # chkconfig --list > /tmp/chkconfig.backup

// The following command disables autostart for all packages at once.

    # for i in $(chkconfig --list | grep '3:on\|4:on\|5:on' | awk {'print $1'}); do chkconfig --level 345 $i off; done

After that, enable the packages we need:

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;">
		<strong>All</strong>
		</span>
		</td>
	</tr>
</table>

    # {
    chkconfig --level 345 network on
    chkconfig --level 345 sshd on
    chkconfig --level 345 crond on
    chkconfig --level 345 ntpd on
    }

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;">
		<strong>All</strong>
		</span>
		</td>
	</tr>
</table>

    # {
    chkconfig  --level 345 acpid on
    chkconfig  --level 345 atd on
    chkconfig  --level 345 auditd on
    chkconfig  --level 345 autofs on
    chkconfig  --level 345 haldaemon on
    chkconfig  --level 345 irqbalance on
    chkconfig  --level 345 messagebus on
    chkconfig  --level 345 netfs on
    chkconfig  --level 345 nfs on
    chkconfig  --level 345 nfslock on
    chkconfig  --level 345 portmap on
    chkconfig  --level 345 rpcgssd on
    chkconfig  --level 345 rpcidmapd on
    chkconfig  --level 345 sendmail on
    chkconfig  --level 345 syslog on
    chkconfig  --level 345 sysstat on
    chkconfig  --level 345 xinetd on
    chkconfig  --level 345 readahead_early on
    chkconfig  --level 345 readahead_later on
    chkconfig  --level 345 snmpd on
    }

<br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Will be added later:</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2</strong></span></td>
</tr>

</table>

    # chkconfig --level 345 iscsi on
    # chkconfig --level 345 iscsid on
    # chkconfig --level 345 oracleasm on

<br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Will be added later:</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>storage</strong></span></td>
</tr>

</table>

    # chkconfig --level 345 tgtd on
