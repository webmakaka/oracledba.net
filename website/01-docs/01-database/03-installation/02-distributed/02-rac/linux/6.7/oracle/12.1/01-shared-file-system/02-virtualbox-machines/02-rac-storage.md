---
layout: page
title: Oracle RAC 12.1 SHARED FILE SYSTEM - Virtual machine configs for storage
description: Oracle RAC 12.1 SHARED FILE SYSTEM - Virtual machine configs for storage
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, SHARED FILE SYSTEM
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/vm/storage/
---

# [Oracle RAC 12.1 SHARED FILE SYSTEM Installation]: Virtual machine configs for storage

    # su - vmadm

<br/>

    $ vm=vm_oel_storage

Creating directories for the virtual machine and for snapshots

    $ mkdir -p ${VM_HOME}/${vm}/snapshots

### Creating and registering the virtual machine:

    $ VBoxManage createvm \
    --name ${vm} \
    --ostype RedHat_64 \
    --basefolder ${VM_HOME}/${vm} \
    --register

### Setting the RAM limit:

    $ VBoxManage modifyvm ${vm} --memory 512

### Connecting a video card with 32 MB:

    $ VBoxManage modifyvm ${vm} --vram 32

### Removing sound card, removing floppy drive:

    $ VBoxManage modifyvm ${vm} --floppy disabled --audio none

### Connecting a hard disk controller (SAS):

    $ VBoxManage storagectl ${vm} \
    --add sas \
    --name "SAS Controller"

### Создание и подключение жестких дисков:

I create virtual hard disks. The size is recommended to be set according to available resources. Otherwise, problems and virtual machine crashes may occur):

    $ cd ${VM_HOME}/${vm}/${vm}

Create 8 disks with 1 command:

    $ for i in $(seq 1 8 )
    do VBoxManage createhd --filename ${vm}_dsk_dsk$i.vdi --size 40960 --format VDI --variant Standard
    done

### Connecting disks to SAS controller:

Connect 8 disks with 1 command:

    $ for i in $(seq 1 8 )
    do let port=$i-1; VBoxManage storageattach ${vm} --storagectl "SAS Controller" --port $port --type hdd --medium ${vm}_dsk_dsk$i.vdi
    done

### Connecting an IDE controller to which a DVD-ROM will be later connected:

    $ VBoxManage storagectl ${vm} \
    --add ide \
    --name "IDE Controller"

### Connecting a DVD image of the operating system to the IDE controller:

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

### Determine the order of devices from which the system will attempt to boot:

    $ VBoxManage modifyvm ${vm} \
    --boot1 disk \
    --boot2 dvd

### Define the directory for snapshots:

    $ VBoxManage modifyvm ${vm} \
    --snapshotfolder ${VM_HOME}/${vm}/snapshots

### Provide the ability to connect to the machine via RDP:

    $ VBoxManage modifyvm ${vm} \
    --vrde on \
    --vrdemulticon on \
    --vrdeauthtype null \
    --vrdeaddress 192.168.1.5 \
    --vrdeport 3389

### Show the result of the created virtual machine:

    $ VBoxManage showvminfo ${vm}

<br/>

## THE VIRTUAL MACHINE IS READY FOR OPERATING SYSTEM INSTALLATION

<br/>

### Start the virtual machine with the ability to connect via RDP:

    $ VBoxHeadless --startvm ${vm}

The operating system should be installed on 1 disk.
