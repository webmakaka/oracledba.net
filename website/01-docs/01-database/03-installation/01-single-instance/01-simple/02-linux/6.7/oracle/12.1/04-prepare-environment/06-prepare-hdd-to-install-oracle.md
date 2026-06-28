---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Preparing Hard Disks for Database Installation
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Preparing Hard Disks for Database Installation
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Preparing Hard Disks for Database Installation
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/prepare-hdd-to-install-oracle/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Preparing Hard Disks for Database Installation

The /u01 directory will store the database software, and the /u02 directory will store the database files.

    # ls /dev/sd*

<br/>

    /dev/sda   /dev/sda2  /dev/sdc  /dev/sde  /dev/sdg
    /dev/sda1  /dev/sdb   /dev/sdd  /dev/sdf  /dev/sdh

Create partitions on the available hard disks.

    # fdisk /dev/sdb
    # fdisk /dev/sdc
    # fdisk /dev/sdd

<br/>

    WARNING: DOS-compatible mode is deprecated. It's strongly recommended to
             switch off the mode (command 'c') and change display units to
             sectors (command 'u').

    Command (m for help): c
    DOS Compatibility flag is not set

    Command (m for help): u
    Changing display/entry units to sectors

    Command (m for help): n
    Command action
       e   extended
       p   primary partition (1-4)
    p
    Partition number (1-4): 1
    First sector (2048-83886079, default 2048):
    Using default value 2048
    Last sector, +sectors or +size{K,M,G} (2048-83886079, default 83886079):
    Using default value 83886079

    Command (m for help): w
    The partition table has been altered!

    Calling ioctl() to re-read partition table.
    Syncing disks.

Create a filesystem on the created partitions.

    # mkfs.ext4 /dev/sdb1
    # mkfs.ext4 /dev/sdc1
    # mkfs.ext4 /dev/sdd1

<br/>

    # mkdir /u01
    # mkdir /u02
    # mkdir /u03

Write information about where to mount partitions when the operating system boots.

    # cp /etc/fstab /etc/fstab.bkp.$(date +%Y-%m-%d)
    # echo "/dev/sdb1 /u01 ext4 defaults 1 2" >> /etc/fstab
    # echo "/dev/sdc1 /u02 ext4 defaults 1 2" >> /etc/fstab
    # echo "/dev/sdd1 /u03 ext4 defaults 1 2" >> /etc/fstab

<br/>

    # mount /u01
    # mount /u02
    # mount /u03

Verification

    # mount | grep sdb1
    # mount | grep sdc1
    # mount | grep sdd1
