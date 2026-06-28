---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Preparing Hard Disks for Database Installation
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Preparing Hard Disks for Database Installation
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Preparing Hard Disks
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/prepare-hdd-to-install-oracle/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Preparing Hard Disks for Database Installation

<br/>

The /u01 directory will store the database software, and the /u02 directory will store the database files.

    # ls /dev/sd*

<br/>

    /dev/sda   /dev/sda2  /dev/sdc  /dev/sde  /dev/sdg
    /dev/sda1  /dev/sdb   /dev/sdd  /dev/sdf  /dev/sdh

Create partitions on the available hard disks.

    # fdisk /dev/sdb

<br/>

    # fdisk /dev/sdb

<br/>

In short, the sequence: [n, p, 1, [Enter], [Enter], w]

<br/>

    Welcome to fdisk (util-linux 2.23.2).

    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.

    Device does not contain a recognized partition table
    Building a new DOS disklabel with disk identifier 0x32ddb4e2.

    Command (m for help): n
    Partition type:
       p   primary (0 primary, 0 extended, 4 free)
       e   extended
    Select (default p): p
    Partition number (1-4, default 1): 1
    First sector (2048-83886079, default 2048):
    Using default value 2048
    Last sector, +sectors or +size{K,M,G} (2048-83886079, default 83886079):
    Using default value 83886079
    Partition 1 of type Linux and of size 40 GiB is set

    Command (m for help): w
    The partition table has been altered!

    Calling ioctl() to re-read partition table.
    Syncing disks.

<br/>

Repeat for:

    # fdisk /dev/sdc
    # fdisk /dev/sdd

<br/>

Create a filesystem on the created partitions.

    # mkfs.ext4 /dev/sdb1
    # mkfs.ext4 /dev/sdc1
    # mkfs.ext4 /dev/sdd1

<br/>

    # mkdir /u01
    # mkdir /u02
    # mkdir /u03

<br/>

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
