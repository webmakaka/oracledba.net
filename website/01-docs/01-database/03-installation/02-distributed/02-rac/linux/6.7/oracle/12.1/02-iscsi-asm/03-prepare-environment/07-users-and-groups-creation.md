---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Creating oracle12 user and administrative groups
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Creating oracle12 user and administrative groups
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/users-and-groups-creation/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Creating oracle12 user and administrative groups

<br/>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1, rac2</strong></span></td>
</tr>

</table>

Create groups:

    # groupadd -g 1000 oinstall
    # groupadd -g 1001 dba
    # groupadd -g 1002 oper

Create groups for working with ASM.

OSASM Group

    # groupadd -g 1003 asmadmin

OSDBA Group

    # groupadd -g 1004 asmdba

OSOPER Group

    # groupadd -g 1005 asmoper

Create the oracle12 user, specify that they will be members of the dba and oinstall groups, and their home directory will be /home/oracle12

    # useradd -g oinstall -G dba,oper,asmadmin,asmdba,asmoper -d /home/oracle12 oracle12

Set the password for the oracle12 user

    # passwd oracle12
