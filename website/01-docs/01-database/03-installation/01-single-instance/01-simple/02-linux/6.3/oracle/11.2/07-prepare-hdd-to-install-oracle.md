---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Preparing Disks for Database Installation
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Preparing Disks for Database Installation
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Preparing Disks for Database Installation
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/prepare-hdd-to-install-oracle/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Preparing Disks for Database Installation

The /u01 directory will store the database software, and the /u02 directory will store the database files.

    # ls /dev/sd*0

<br/>

    /dev/sda   /dev/sda2  /dev/sdc  /dev/sde  /dev/sdg
    /dev/sda1  /dev/sdb   /dev/sdd  /dev/sdf  /dev/sdh

Create partitions on the available hard drives.

    # fdisk /dev/sdb
    # fdisk /dev/sdc
    # fdisk /dev/sdd

<br/>

    The number of cylinders for this disk is set to 5221.
    There is nothing wrong with that, but this is larger than 1024,
    and could in certain setups cause problems with:
    1) software that runs at boot time (e.g., old versions of LILO)
    2) booting and partitioning software from other OSs
      (e.g., DOS FDISK, OS/2 FDISK)

    Command (m for help): n
    Command action
     e   extended
     p   primary partition (1-4)
    [p]
    Partition number (1-4): [1]
    First cylinder (1-5221, default 1): [Enter]
    Using default value 1
    Last cylinder or +size or +sizeM or +sizeK (1-5221, default 5221): [Enter]
    Using default value 5221

    Command (m for help): [w]
    The partition table has been altered!

    Calling ioctl() to re-read partition table.
    Syncing disks.

Create a file system on the created partitions.

    # mkfs.ext4 /dev/sdb1
    # mkfs.ext4 /dev/sdc1
    # mkfs.ext4 /dev/sdd1

<br/>

    # mkdir /u01
    # mkdir /u02
    # mkdir /u03

Write information about where partitions should be mounted at boot.

    # cp /etc/fstab /etc/fstab.bkp
    # echo "/dev/sdb1 /u01 ext4 defaults 1 2" >> /etc/fstab
    # echo "/dev/sdc1 /u02 ext4 defaults 1 2" >> /etc/fstab
    # echo "/dev/sdd1 /u03 ext4 defaults 1 2" >> /etc/fstab

<br/>

    # mount /u01
    # mount /u02
    # mount /u03

<br/>

Verification

    # mount | grep sdb1
    # mount | grep sdc1
    # mount | grep sdd1

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
