---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Installing ISCSI and mounting iscsi disks
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Installing ISCSI and mounting iscsi disks
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Installing ISCSI and mounting iscsi disks
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/prepare-iscsi-discs/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Installing ISCSI and mounting iscsi disks

<br/>

<ul>
	<li>iSCSI target — a program or controller that emulates a disk and processes iSCSI requests.</li>
	<li>iSCSI initiator — a program that provides client access to SCSI.</li>
</ul>

<br/><br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Installing iSCSI target</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
	<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
	<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>storage</strong></span></td>
	</tr>
</table>

================== OFFTOPIC BEGIN =================

ASM does not support devices larger than 2097152 MBs.  
If the device is larger, you can use parted.

    # parted
    select /dev/sdb
    print
    mklabel gpt

<br/>

    mkpart primary 0 1799GB
    mkpart primary 1799GB 100%

<br/>

    parted -l

Why did I write this? Just if you need to split a disk into smaller ones, it's better to think about it in advance.

================== OFFTOPIC END =================

    # yum install -y scsi-target-utils

<br/>

    # ls /dev/sd*

<br/>

    /dev/sda   /dev/sda2  /dev/sdc  /dev/sde  /dev/sdg
    /dev/sda1  /dev/sdb   /dev/sdd  /dev/sdf  /dev/sdh

<br/>

    # fdisk /dev/sdb
    # fdisk /dev/sdc
    # fdisk /dev/sdd
    # fdisk /dev/sde
    # fdisk /dev/sdf
    # fdisk /dev/sdg
    # fdisk /dev/sdh

<br/>

    # ls /dev/sd*

<br/>

    /dev/sda   /dev/sdb   /dev/sdc1  /dev/sde   /dev/sdf1  /dev/sdh
    /dev/sda1  /dev/sdb1  /dev/sdd   /dev/sde1  /dev/sdg   /dev/sdh1
    /dev/sda2  /dev/sdc   /dev/sdd1  /dev/sdf   /dev/sdg1

<br/>

    # vi /etc/tgt/targets.conf

The line must be uncommented:
default-driver iscsi

    <target ru.oracle-dba:disk1>
            backing-store /dev/sdb1
            initiator-address 192.168.3.11
            initiator-address 192.168.3.12
    </target>
    <target ru.oracle-dba:disk2>
            backing-store /dev/sdc1
            initiator-address 192.168.3.11
            initiator-address 192.168.3.12
    </target>
    <target ru.oracle-dba:disk3>
            backing-store /dev/sdd1
            initiator-address 192.168.3.11
            initiator-address 192.168.3.12
    </target>
    <target ru.oracle-dba:disk4>
            backing-store /dev/sde1
            initiator-address 192.168.3.11
            initiator-address 192.168.3.12
    </target>
    <target ru.oracle-dba:disk5>
            backing-store /dev/sdf1
            initiator-address 192.168.3.11
            initiator-address 192.168.3.12
    </target>
    <target ru.oracle-dba:disk6>
            backing-store /dev/sdg1
            initiator-address 192.168.3.11
            initiator-address 192.168.3.12
    </target>
    <target ru.oracle-dba:disk7>
            backing-store /dev/sdh1
            initiator-address 192.168.3.11
            initiator-address 192.168.3.12
    </target>

<br/>

    # service tgtd start

Check the results:

    # tgt-admin --show

<br/>

    Target 1: ru.oracle-dba:disk1
        System information:
            Driver: iscsi
            State: ready
        I_T nexus information:
        LUN information:
            LUN: 0
                Type: controller
                SCSI ID: IET     00010000
                SCSI SN: beaf10
                Size: 0 MB, Block size: 1
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: null
                Backing store path: None
                Backing store flags:
            LUN: 1
                Type: disk
                SCSI ID: IET     00010001
                SCSI SN: beaf11
                Size: 42944 MB, Block size: 512
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: rdwr
                Backing store path: /dev/sdb1
                Backing store flags:
        Account information:
        ACL information:
            192.168.3.11
            192.168.3.12
    Target 2: ru.oracle-dba:disk2
        System information:
            Driver: iscsi
            State: ready
        I_T nexus information:
        LUN information:
            LUN: 0
                Type: controller
                SCSI ID: IET     00020000
                SCSI SN: beaf20
                Size: 0 MB, Block size: 1
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: null
                Backing store path: None
                Backing store flags:
            LUN: 1
                Type: disk
                SCSI ID: IET     00020001
                SCSI SN: beaf21
                Size: 42944 MB, Block size: 512
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: rdwr
                Backing store path: /dev/sdc1
                Backing store flags:
        Account information:
        ACL information:
            192.168.3.11
            192.168.3.12
    Target 3: ru.oracle-dba:disk3
        System information:
            Driver: iscsi
            State: ready
        I_T nexus information:
        LUN information:
            LUN: 0
                Type: controller
                SCSI ID: IET     00030000
                SCSI SN: beaf30
                Size: 0 MB, Block size: 1
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: null
                Backing store path: None
                Backing store flags:
            LUN: 1
                Type: disk
                SCSI ID: IET     00030001
                SCSI SN: beaf31
                Size: 42944 MB, Block size: 512
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: rdwr
                Backing store path: /dev/sdd1
                Backing store flags:
        Account information:
        ACL information:
            192.168.3.11
            192.168.3.12
    Target 4: ru.oracle-dba:disk4
        System information:
            Driver: iscsi
            State: ready
        I_T nexus information:
        LUN information:
            LUN: 0
                Type: controller
                SCSI ID: IET     00040000
                SCSI SN: beaf40
                Size: 0 MB, Block size: 1
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: null
                Backing store path: None
                Backing store flags:
            LUN: 1
                Type: disk
                SCSI ID: IET     00040001
                SCSI SN: beaf41
                Size: 42944 MB, Block size: 512
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: rdwr
                Backing store path: /dev/sde1
                Backing store flags:
        Account information:
        ACL information:
            192.168.3.11
            192.168.3.12
    Target 5: ru.oracle-dba:disk5
        System information:
            Driver: iscsi
            State: ready
        I_T nexus information:
        LUN information:
            LUN: 0
                Type: controller
                SCSI ID: IET     00050000
                SCSI SN: beaf50
                Size: 0 MB, Block size: 1
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: null
                Backing store path: None
                Backing store flags:
            LUN: 1
                Type: disk
                SCSI ID: IET     00050001
                SCSI SN: beaf51
                Size: 42944 MB, Block size: 512
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: rdwr
                Backing store path: /dev/sdf1
                Backing store flags:
        Account information:
        ACL information:
            192.168.3.11
            192.168.3.12
    Target 6: ru.oracle-dba:disk6
        System information:
            Driver: iscsi
            State: ready
        I_T nexus information:
        LUN information:
            LUN: 0
                Type: controller
                SCSI ID: IET     00060000
                SCSI SN: beaf60
                Size: 0 MB, Block size: 1
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: null
                Backing store path: None
                Backing store flags:
            LUN: 1
                Type: disk
                SCSI ID: IET     00060001
                SCSI SN: beaf61
                Size: 42944 MB, Block size: 512
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: rdwr
                Backing store path: /dev/sdg1
                Backing store flags:
        Account information:
        ACL information:
            192.168.3.11
            192.168.3.12
    Target 7: ru.oracle-dba:disk7
        System information:
            Driver: iscsi
            State: ready
        I_T nexus information:
        LUN information:
            LUN: 0
                Type: controller
                SCSI ID: IET     00070000
                SCSI SN: beaf70
                Size: 0 MB, Block size: 1
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: null
                Backing store path: None
                Backing store flags:
            LUN: 1
                Type: disk
                SCSI ID: IET     00070001
                SCSI SN: beaf71
                Size: 42944 MB, Block size: 512
                Online: Yes
                Removable media: No
                Readonly: No
                Backing store type: rdwr
                Backing store path: /dev/sdh1
                Backing store flags:
        Account information:
        ACL information:
            192.168.3.11
            192.168.3.12

<br/>

    # chkconfig --level 345 tgtd on

<br/><br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Configuring UDEV rules for naming imported disks.</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2</strong></span></td>
</tr>

</table>

When setting names, an error sometimes occurred.

    oracleasm-read-label: Unable to open device "/dev/sdb": No such file or directory

Try to configure the rules similarly to the instructions for Oracle 12C.
https://oracledba.net/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/mount-iscsi-on-nodes/

<br/><br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);"><strong>Connecting exported disks to cluster nodes</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
		<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
		<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2</strong></span></td>
	</tr>
</table>

    # yum install -y iscsi-initiator-utils.x86_64

<br/>

    # service iscsid start

<br/>

// Get list of exported disks from storage:

    # iscsiadm -m discovery -t sendtargets -p 192.168.3.15:3260

<br/>

    # service iscsi restart

<br/>

    # chkconfig --level 345 iscsi on
    # chkconfig --level 345 iscsid on

<br/><br/>

Check before using:<br/>
http://www.oracle-base.com/articles/linux/udev-scsi-rules-configuration-in-oracle-linux-5-and-6.php
