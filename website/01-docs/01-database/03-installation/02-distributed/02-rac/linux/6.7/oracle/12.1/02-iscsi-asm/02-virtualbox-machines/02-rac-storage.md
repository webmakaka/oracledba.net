---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Virtualbox machine configs for storage
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Virtualbox machine configs for storage
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/vm/storage/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Virtualbox machine configs for storage

    # su - vmadm

<br/>

    $ vm=vm_oel_storage

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

Create 8 disks with 1 command:

    $ for i in $(seq 1 8 )
    do VBoxManage createhd --filename ${vm}_dsk_dsk$i.vdi --size 40960 --format VDI --variant Standard
    done

### Connect disks to the SAS controller:

Connect 8 disks with 1 command:

    $ for i in $(seq 1 8 )
    do let port=$i-1; VBoxManage storageattach ${vm} --storagectl "SAS Controller" --port $port --type hdd --medium ${vm}_dsk_dsk$i.vdi
    done

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

    $ VBoxManage modifyvm ${vm} \
    --nictype2 82540EM \
    --nic2 bridged \
    --bridgeadapter2 eth0

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
