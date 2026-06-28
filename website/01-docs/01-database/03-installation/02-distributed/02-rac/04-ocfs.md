---
layout: page
title: Oracle RAC OCFS2
description: Oracle RAC OCFS2
keywords: database, installation, rac, Oracle RAC OCFS2
permalink: /database/installation/distributed/rac/linux/6.7/ocfs/
---

# [Oracle RAC Installation]: OCFS2

For the ability to simultaneously write to 2 cluster nodes (primary/primary), you should use a cluster file system, for example ocfs2.

OCFS2 is a general-purpose cluster file system developed by Oracle specifically for clustering database files, currently available only for RHEL and OEL. It can be used to store Oracle Clusterware files, Oracle RAC datafiles, Oracle application files, or any other files. The second version of OCFS has significant changes, the innovations relate to configuring the use of datafiles and Oracle Clusterware files.

The ocfs2 file system is designed for shared use by two or more Linux systems, i.e., we have the ability to simultaneously mount partitions in RW mode on multiple nodes.

OCFS2 is freely distributed by Oracle in three RPM packages: kernel module, utility set, and graphical console. For each OS kernel version, the corresponding package should be used.

We return to the step preceding the creation of ASM disks.

<!--

https://oraclelabs.wordpress.com/virtual-oracle-rac-oracle-installation/

-->

<br/>

**Configuration is the same as in the RAC 12 iSCSI + ASM document**

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1, rac2</strong></span></td>
</tr>

</table>

    # yum install -y \
    ocfs2-tools \
    ocfs2-tools-devel

<br/>

If a gui console is needed, you can also install

    # yum install -y \
    ocfs2console

<br/>

    # chkconfig --level 345 o2cb on

<br/>

     # mkfs.ocfs2 /dev/mapper/iscsi-disk1

<br/>

    # mkdir -p /u02
    # mkdir -p /etc/ocfs2/

<br/>

    # vi /etc/ocfs2/cluster.conf

<br/>

    cluster:
        node_count = 2
        name = ocfs2

    node:
        ip_port = 7777
        ip_address = 192.168.3.11
        number = 0
        name = rac1
        cluster = ocfs2

    node:
        ip_port = 7777
        ip_address = 192.168.3.12
        number = 1
        name = rac2
        cluster = ocfs2

<br/>

    # /etc/init.d/o2cb offline ocfs2
    # /etc/init.d/o2cb unload
    # /etc/init.d/o2cb configure

<br/>

// Start on both nodes

    # /etc/init.d/o2cb online ocfs2

To have OCFS2 support module activated at boot, execute on each node:

    # /etc/init.d/o2cb enable

<br/>

    # /etc/init.d/o2cb load

<br/>

    # /etc/init.d/o2cb status

<br/>

### Mounting OCFS2

For a file system containing datafiles and Oracle Clusterware files, the condition must be met that all I/O operations for files use the direct I/O mechanism (O_DIRECT). Therefore, always use the "datavolume" option when mounting the file system. Without this option, a system failure may lead to data loss.

    # mount -t ocfs2 /dev/mapper/iscsi-disk1 -o datavolume /u02

Mount the OCFS2 partition to the remaining nodes.

For the file system to mount every time at boot, add to /etc/fstab on each node:

    # vi /etc/fstab

    /dev/mapper/iscsi-disk1 /u02 ocfs2 _netdev,datavolume,nointr 0 0

To disable periodic file system error checking, run:

    /sbin/tune2fs -i 0 -c 0 /u02

<br/>

### Additional commands

These commands may be needed sometime:

    /etc/init.d/ocfs2 restart
    /etc/init.d/o2cb force-reload
