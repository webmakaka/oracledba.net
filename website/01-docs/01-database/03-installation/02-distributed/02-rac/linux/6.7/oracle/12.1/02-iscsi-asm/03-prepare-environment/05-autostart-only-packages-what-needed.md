---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Selecting packages for autostart
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Selecting packages for autostart
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/autostart-only-packages-what-needed/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Selecting packages for autostart

<br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Selecting packages for autostart:</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2, storage</strong></span></td>
</tr>

</table>

// View which programs currently autostart when the operating system starts.

    # chkconfig --list | grep '3:on\|4:on\|5:on'  |awk '{print $1}' | sort

// Create a backup of the chkconfig --list output

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
    chkconfig  --level 345 auditd on
    chkconfig  --level 345 netfs on
    chkconfig  --level 345 nfs on
    chkconfig  --level 345 nfslock on
    chkconfig  --level 345 rpcgssd on
    chkconfig  --level 345 rpcidmapd on
    chkconfig  --level 345 sysstat on
    chkconfig  --level 345 xinetd on
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
