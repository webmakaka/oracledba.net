---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Checking cluster configuration before RAC installation
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Checking cluster configuration before RAC installation
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Checking cluster configuration before RAC installation
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/check-environment-before-install/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Checking cluster configuration before RAC installation

<br/>

Download the latest version of "Oracle Cluster Verification Utility" from the oracle website  
http://www.oracle.com/technetwork/products/clustering/downloads/cvu-download-homepage-099973.html

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Installing cvuqdisk-1.0.9-1.rpm</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1,node2</strong></span></td>
	</tr>
</table>

The cvuqdisk-1.0.9-1.rpm package must be installed on all cluster nodes

Earlier, I copied this package to one of the linux servers.

Retrieve it with the following command:

    # scp marley@192.168.1.5:/mnt/dsk2/_ISO/oracle/linux/cvupack_Linux_x86_64.zip /tmp/

<br/>

    # cd /tmp

<br/>

    # mkdir cvupack
    # mv cvupack_Linux_x86_64.zip ./cvupack
    # cd /tmp/cvupack
    # unzip cvupack_Linux_x86_64.zip

<br/>

    # rpm -Uvh /tmp/cvupack/rpm/cvuqdisk-1.0.9-1.rpm

<br/>

    # chown -R oracle11:oinstall /tmp/cvupack

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Checking the correctness of the prepared cluster nodes configuration</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1</strong></span></td>
	</tr>
</table>

    # su - oracle11

<br/>

    $ cd /tmp/cvupack/bin

<br/>

    $ ./cluvfy stage -pre crsinst -n node1,node2

If errors occur, you can get a log with a more detailed report of the issues:

    $ ./cluvfy stage -pre crsinst -n node1,node2 -r 11gR2  -verbose > /tmp/log.log

<br/>

    ***

    Check: Membership of user "oracle11" in group "oinstall" [as Primary]
      Node Name         User Exists   Group Exists  User in Group  Primary       Status
      ----------------  ------------  ------------  ------------  ------------  ------------
      devsp038          yes           yes           yes           no            failed
      devsp037          yes           yes           yes           no            failed
    Result: Membership check for user "oracle11" in group "oinstall" [as Primary] failed

    ***

<br/>

    $ id
    uid=502(oracle11) gid=500(dba) groups=500(dba),1003(oinstall)

<br/>

    # usermod -g oinstall oracle11
    # usermod -G dba oracle11

<br/>

    # su - oracle11
    $ id
    uid=502(oracle11) gid=1003(oinstall) groups=500(dba),1003(oinstall)

The check result should be the following message.
Pre-check for cluster services setup was successful.

Interestingly, in the console itself, the primary group must be dba.

Therefore:

    # usermod -g dba oracle11
    # usermod -G oinstall oracle11
