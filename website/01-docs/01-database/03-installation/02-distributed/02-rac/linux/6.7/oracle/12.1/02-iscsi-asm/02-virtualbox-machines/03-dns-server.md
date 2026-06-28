---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Virtualbox machine configs for DNS server
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Virtualbox machine configs for DNS server
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/vm/dns-server/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Virtualbox machine configs for DNS server

    # su - vmadm

<br/>

    $ vm=vm_oel_dns

Create directories for the virtual machine and for snapshots

    $ mkdir -p ${VM_HOME}/${vm}/snapshots

### Creating and registering the virtual machine:

    $ VBoxManage createvm \
    --name ${vm} \
    --ostype RedHat_64 \
    --basefolder ${VM_HOME}/${vm} \
    --register

### Setting the RAM limit:

    $ VBoxManage modifyvm ${vm} --memory 512

### Connect video card with 32 MB:

    $ VBoxManage modifyvm ${vm} --vram 32

### Remove sound card, remove floppy drive:

    $ VBoxManage modifyvm ${vm} --floppy disabled --audio none

### Connect hard disk controller (SAS):

    $ VBoxManage storagectl ${vm} \
    --add sas \
    --name "SAS Controller"

### Creating and connecting hard disks:

Create virtual hard disks. The size is recommended to be set according to available resources. Otherwise, problems and virtual machine crashes may occur):

    $ cd ${VM_HOME}/${vm}/${vm}

<br/>

    $ VBoxManage createhd \
    --filename ${vm}_dsk1.vdi \
    --size 40960 \
    --format VDI \
    --variant Standard

### Connect disks to the SAS controller:

    $ VBoxManage storageattach ${vm} \
    --storagectl "SAS Controller" \
    --port 0 \
    --type hdd \
    --medium ${vm}_dsk1.vdi

### Connect the IDE controller to which the DVD-ROM will later be connected:

    $ VBoxManage storagectl ${vm} \
    --add ide \
    --name "IDE Controller"

### Connect the DVD image of the operating system being installed to the IDE controller:

    $ VBoxManage storageattach ${vm} \
    --storagectl "IDE Controller" \
    --port 0 \
    --device 0 \
    --type dvddrive \
    --medium  /home/marley/Downloads/OracleLinux6U7/x64/OracleLinux-R6-U7-Server-x86_64-dvd.iso

### Connecting network interfaces:

    $ VBoxManage modifyvm ${vm} \
    --nictype1 82540EM \
    --nic1 bridged \
    --bridgeadapter1 eth0

<br/>

### Determine the boot device order:

    $ VBoxManage modifyvm ${vm} \
    --boot1 disk \
    --boot2 dvd

### Determine the snapshot directory:

    $ VBoxManage modifyvm ${vm} \
    --snapshotfolder ${VM_HOME}/${vm}/snapshots

### Allow RDP connection to the machine:

    $ VBoxManage modifyvm ${vm} \
    --vrde on \
    --vrdemulticon on \
    --vrdeauthtype null \
    --vrdeaddress 192.168.1.5 \
    --vrdeport 3389

### Show the created virtual machine result:

    $ VBoxManage showvminfo ${vm}

<br/>

## VIRTUAL MACHINE IS READY FOR OPERATING SYSTEM INSTALLATION

<br/>

### Start the virtual machine with RDP connection capability:

    $ VBoxHeadless --startvm ${vm}

Install the operating system on 1 disk.
