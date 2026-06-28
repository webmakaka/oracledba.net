---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Creating a VirtualBox Virtual Machine for Database Installation
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Creating a VirtualBox Virtual Machine for Database Installation
keywords: Oracle DataBase 12c, Oracle Linux 6.7, VirtualBox
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/virtual-machine/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Creating a VirtualBox Virtual Machine for Database Installation

<br/>

About how I installed virtualbox, variables and directories, see  
<a href="//sysadm.ru/server/linux/virtual/virtualbox/">here</a>

<br/>

### Creating a virtual machine:

    # su - vmadm

Set the virtual machine name:

    $ vm=vm_oel6.7_oracle12.1

Create directories for the virtual machine and for snapshots

    $ mkdir -p ${VM_HOME}/${vm}/snapshots

### Creating and registering the virtual machine:

    $ VBoxManage createvm \
    --name ${vm} \
    --ostype RedHat_64 \
    --basefolder ${VM_HOME}/${vm} \
    --register

### Setting the RAM limit:

    $ VBoxManage modifyvm ${vm} --memory 4096

### Connecting a 32 MB video card:

    $ VBoxManage modifyvm ${vm} --vram 32

### Removing sound card, removing floppy drive:

    $ VBoxManage modifyvm ${vm} --floppy disabled --audio none

### Connecting a hard disk controller (SAS):

    $ VBoxManage storagectl ${vm} \
    --add sas \
    --name "SAS Controller"

### Creating and connecting hard disks:

Create virtual hard disks. It is recommended to set the size according to available resources. Otherwise, problems and virtual machine crashes may occur):

    $ cd ${VM_HOME}/${vm}/${vm}

Create 8 disks with 1 command:

    $ for i in $(seq 1 8 )
    do VBoxManage createhd --filename ${vm}_dsk_dsk$i.vdi --size 40960 --format VDI --variant Standard
    done

### Connecting disks to the SAS controller:

Connect 8 disks with 1 command:

    $ for i in $(seq 1 8 )
    do let port=$i-1; VBoxManage storageattach ${vm} --storagectl "SAS Controller" --port $port --type hdd --medium ${vm}_dsk_dsk$i.vdi
    done

### Connecting the IDE controller to which the DVD-ROM will be connected later:

    $ VBoxManage storagectl ${vm} \
    --add ide \
    --name "IDE Controller"

### Connecting the DVD image of the operating system being installed to the IDE controller:

    $ VBoxManage storageattach ${vm} \
    --storagectl "IDE Controller" \
    --port 0 \
    --device 0 \
    --type dvddrive \
    --medium  /mnt/dsk1/oracle/OracleLinux6U7/x64/OracleLinux-R6-U7-Server-x86_64-dvd.iso

### Connecting network interfaces:

Run the command;

    $ VBoxManage list bridgedifs

Pay attention to the value:

Name: eth0

I use eth0 as the main physical interface that virtual machines will use as a bridge.

Connect 2 virtual "Intel 82540EM Gigabit Ethernet Controller" network interfaces to the virtual machine, working as bridged:

    $ VBoxManage modifyvm ${vm} \
    --nictype1 82540EM \
    --nic1 bridged \
    --bridgeadapter1 eth0

    $ VBoxManage modifyvm ${vm} \
    --nictype2 82540EM \
    --nic2 bridged \
    --bridgeadapter2 eth0

<br/>

### Determining the boot order of devices:

    $ VBoxManage modifyvm ${vm} \
    --boot1 disk \
    --boot2 dvd

### Determining the directory for snapshots:

    $ VBoxManage modifyvm ${vm} \
    --snapshotfolder ${VM_HOME}/${vm}/snapshots

### Enabling RDP connection to the machine:

    $ VBoxManage modifyvm ${vm} \
    --vrde on \
    --vrdemulticon on \
    --vrdeauthtype null \
    --vrdeaddress 192.168.1.5 \
    --vrdeport 3389

Here we specify:

--vrdeaddress - ip address of the machine where virtualbox is installed  
--vrdeauthtype null - no authentication required.  
--vrdemulticon on - multiple connections to virtual machines are allowed.  
--vrdeport - port to which you can connect when the virtual machine starts.

### Display the result of the created virtual machine:

    $ VBoxManage showvminfo ${vm}

### Creating a snapshot before OS installation

    $ VBoxManage snapshot ${vm} take before_os_installation

<br/>

## VIRTUAL MACHINE READY FOR OPERATING SYSTEM INSTALLATION

For a more detailed document on creating snapshots and backups of virtual machines, see
<a href="//sysadm.ru/server/linux/virtual/virtualbox/">here</a>

<br/>

### Starting the virtual machine with RDP connection capability:

    $ VBoxHeadless --startvm ${vm}

Connect via RDP to the virtual machine. On Windows, this is the remote desktop connection console mstsc, on Linux remmina or rdesktop.

In the first window, press tab and add linux text so that the installation proceeds in a convenient mode. The operating system should be installed on 1 disk.
