---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Configuring ASM on cluster nodes, labeling disks as ASM
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Configuring ASM on cluster nodes, labeling disks as ASM
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/prepare-asm-discs/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Configuring ASM on cluster nodes, labeling disks as ASM

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1, rac2</strong></span></td>
</tr>

</table>

<br/>

    # /etc/init.d/oracleasm configure

<br/>

    Default user to own the driver interface []: oracle12
    Default group to own the driver interface []: asmadmin
    Start Oracle ASM library driver on boot (y/n) [n]: y
    Scan for Oracle ASM disks on boot (y/n) [y]: y
    Writing Oracle ASM library driver configuration: done
    Initializing the Oracle ASMLib driver:                     [  OK  ]
    Scanning the system for Oracle ASMLib disks:               [  OK  ]

Check:

    # /etc/init.d/oracleasm status

    Checking if ASM is loaded: yes
    Checking if /dev/oracleasm is mounted: yes

If using Device Mapper, execute the following step, otherwise an error will occur during installation: <a href="https://oracledba.net/docs/errors/ins-32148/Execution-of-GI-Install-script-failed-on-nodes/">[INS-32148] Execution of 'GI Install' script failed on nodes: [rac2]</a>

    # vi /etc/sysconfig/oracleasm

    ***
    ORACLEASM_SCANORDER="dm"
    ORACLEASM_SCANEXCLUDE="sd"
    ***

Restart the asmlib service:

    # /etc/init.d/oracleasm restart

<br/>

# Label disks as ASM disks:

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
    <tr>
    <td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
    <td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1</strong></span></td>
    </tr>
</table>

<br/>

### Label disks as ASM:

If using Device Mapper:

    # {
        /etc/init.d/oracleasm createdisk ASMDISK1 /dev/mapper/iscsi-disk1
        /etc/init.d/oracleasm createdisk ASMDISK2 /dev/mapper/iscsi-disk2
        /etc/init.d/oracleasm createdisk ASMDISK3 /dev/mapper/iscsi-disk3
        /etc/init.d/oracleasm createdisk ASMDISK4 /dev/mapper/iscsi-disk4
        /etc/init.d/oracleasm createdisk ASMDISK5 /dev/mapper/iscsi-disk5
        /etc/init.d/oracleasm createdisk ASMDISK6 /dev/mapper/iscsi-disk6
        /etc/init.d/oracleasm createdisk ASMDISK7 /dev/mapper/iscsi-disk7
    }

    Marking disk "ASMDISK" as an ASM disk:                        [  OK  ]

View list of disks

    # /etc/init.d/oracleasm listdisks
    ASMDISK1
    ASMDISK2
    ASMDISK3
    ASMDISK4
    ASMDISK5
    ASMDISK6
    ASMDISK7

Or like this

    # ls /dev/oracleasm/disks/
    ASMDISK1  ASMDISK2  ASMDISK3  ASMDISK4  ASMDISK5  ASMDISK6  ASMDISK7

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
	<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
	<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac2</strong></span></td>
</tr>

</table>

You need to make sure that the disks are mounted on all cluster nodes. And when entering the following command, it returns the following data on both nodes.

    # oracleasm listdisks
    ASMDISK1
    ASMDISK2
    ASMDISK3
    ASMDISK4
    ASMDISK5
    ASMDISK6
    ASMDISK7

If using Device Mapper:

    # oracleasm scandisks
    # oracleasm listdisks

---

If using Udev rules, you need to explicitly specify where these disks are located:

    # oracleasm scandisks /dev/mapper/iscsi-disk* --verbose
    # oracleasm listdisks

I have not yet found a way to configure disk scanning without additional parameters. This is most likely explicitly specified in the /etc/sysconfig/oracleasm file. But I have not yet been able to achieve the desired result.

Therefore, I additionally add a cron job that should be executed at reboot.

---

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
	<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
	<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1,rac2</strong></span></td>
</tr>

</table>

    # chkconfig --level 345 crond on
    # service crond restart

    # crontab -e
    @reboot /usr/sbin/oracleasm scandisks /dev/mapper/iscsi-disk*

<br/><br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Checking package startup order correctness</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
	<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
	<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1, rac2</strong></span></td>
</tr>

</table>

    # cd /etc/rc3.d

for example:

    S60iscsi
    S65iscsid
    S80oracleasm

    # mv S13iscsi S60iscsi
    # mv S07iscsid S65iscsid
    # mv S29oracleasm S80oracleasm

<br/>

### Additional information

    # /etc/init.d/oracleasm querydisk -p ASMDISK1
    Disk "ASMDISK1" is a valid ASM disk
    /dev/mapper/asm-disk1: LABEL="ASMDISK1" TYPE="oracleasm"

View config

    # /usr/sbin/oracleasm configure
    ORACLEASM_ENABLED=true
    ORACLEASM_UID=oracle12
    ORACLEASM_GID=asmadmin
    ORACLEASM_SCANBOOT=true
    ORACLEASM_SCANORDER=""
    ORACLEASM_SCANEXCLUDE=""
    ORACLEASM_USE_LOGICAL_BLOCK_SIZE="false"

Config in text format

    # vi /etc/sysconfig/oracleasm

Log file

    # less /var/log/oracleasm

<br/>

    # udevadm info --query=all --name=/dev/iscsi-disk1
    P: /devices/platform/host3/session1/target3:0:0/3:0:0:1/block/sdc/sdc1
    N: iscsi-disk1
    W: 73
    S: block/8:33
    S: disk/by-id/scsi-1IET_00040001-part1
    S: disk/by-path/ip-192.168.3.15:3260-iscsi-ru.oracle-dba:disk4-lun-1-part1
    S: disk/by-label/ASMDISK1
    E: UDEV_LOG=3
    E: DEVPATH=/devices/platform/host3/session1/target3:0:0/3:0:0:1/block/sdc/sdc1
    E: MAJOR=8
    E: MINOR=33
    E: DEVNAME=/dev/iscsi-disk1
    E: DEVTYPE=partition
    E: SUBSYSTEM=block
    E: ID_SCSI=1
    E: ID_VENDOR=IET
    E: ID_VENDOR_ENC=IET\x20\x20\x20\x20\x20
    E: ID_MODEL=VIRTUAL-DISK
    E: ID_MODEL_ENC=VIRTUAL-DISK
    E: ID_REVISION=0001
    E: ID_TYPE=disk
    E: ID_SERIAL_RAW=1IET     00040001
    E: ID_SERIAL=1IET_00040001
    E: ID_SERIAL_SHORT=IET_00040001
    E: ID_SCSI_SERIAL=beaf41
    E: ID_BUS=scsi
    E: ID_PATH=ip-192.168.3.15:3260-iscsi-ru.oracle-dba:disk4-lun-1
    E: ID_PART_TABLE_TYPE=dos
    E: ID_FS_LABEL=ASMDISK1
    E: ID_FS_LABEL_ENC=ASMDISK1
    E: ID_FS_TYPE=oracleasm
    E: ID_FS_USAGE=filesystem
    E: LVM_SBIN_PATH=/sbin
    E: DEVLINKS=/dev/block/8:33 /dev/disk/by-id/scsi-1IET_00040001-part1 /dev/disk/by-path/ip-192.168.3.15:3260-iscsi-ru.oracle-dba:disk4-lun-1-part1 /dev/disk/by-label/ASMDISK1
