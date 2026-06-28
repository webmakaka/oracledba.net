---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - ASMLIB installation on cluster nodes
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - ASMLIB installation on cluster nodes
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM), ASMLIB
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/asmlib-installation/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: ASMLIB installation on cluster nodes

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1, rac2</strong></span></td>
</tr>

</table>

In Oracle Linux 6, the oracleasm kernel driver is built into the UEK kernel and therefore does not require installation.

It is necessary from the Oracle website:

http://www.oracle.com/technetwork/server-storage/linux/asmlib/rhel6-1940776.html

Download: oracleasmlib-\*.x86_64.rpm

    # cd /tmp
    # wget http://download.oracle.com/otn_software/asmlib/oracleasmlib-2.0.4-1.el6.x86_64.rpm

<br/>

    # yum install -y \
    oracleasm \
    oracleasm-support \
    oracleasmlib-2.0.4-1.el6.x86_64.rpm

<br/>

Check installed packages:

    # rpm -qa | grep oracleasm
    oracleasm-support-2.1.8-1.el6.x86_64
    oracleasmlib-2.0.4-1.el6.x86_64

If using Centos, RedHat and not OEL, you also need to install:.

    # yum install -y \
    kmod-oracleasm.x86_64
