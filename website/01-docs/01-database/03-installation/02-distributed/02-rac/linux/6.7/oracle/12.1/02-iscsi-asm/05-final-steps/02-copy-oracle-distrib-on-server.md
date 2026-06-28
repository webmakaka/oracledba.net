---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Copying database distributives to the server
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Copying database distributives to the server
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/copy-oracle-distrib-on-server/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Copying database distributives to the server

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1</strong></span></td>
	</tr>
</table>

<br/>

Log in as the user who will perform the database installation.

    # su - oracle12

Copy the Oracle distributives to the temporary directory /tmp/oracle/12.1/

    $ cd /tmp/oracle/12.1/

<br/>

    $ ls
    linuxamd64_12102_database_1of2.zip  linuxamd64_12102_grid_1of2.zip
    linuxamd64_12102_database_2of2.zip  linuxamd64_12102_grid_2of2.zip

Unzip Grid

    $ unzip linuxamd64_12102_grid_1of2.zip; unzip linuxamd64_12102_grid_2of2.zip

Unzip DataBase

    $ unzip linuxamd64_12102_database_1of2.zip; unzip linuxamd64_12102_database_2of2.zip
