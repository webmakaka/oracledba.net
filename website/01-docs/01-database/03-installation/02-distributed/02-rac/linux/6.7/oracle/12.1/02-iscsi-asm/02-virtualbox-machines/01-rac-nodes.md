---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Virtualbox machine configs for cluster nodes
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Virtualbox machine configs for cluster nodes
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/vm/rac-nodes/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Virtualbox machine configs for cluster nodes installation

    # su - vmadm

<br/>

    $ vm=vm_oel_rac1

Create directories for the virtual machine and for snapshots

    $ mkdir -p ${VM_HOME}/${vm}/snapshots

### Creating and registering the virtual machine:

    $ VBoxManage createvm \
    --name ${vm} \
    --ostype RedHat_64 \
    --basefolder ${VM_HOME}/${vm} \
    --register

### Setting the RAM limit:

    $ VBoxManage modifyvm ${vm} --memory 4608

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

    $ VBoxManage createhd \
    --filename ${vm}_dsk1.vdi \
    --size 40960 \
    --format VDI \
    --variant Standard

    $ VBoxManage createhd \
    --filename ${vm}_dsk2.vdi \
    --size 40960 \
    --format VDI \
    --variant Standard

### Connect disks to the SAS controller:

    $ VBoxManage storageattach ${vm} \
    --storagectl "SAS Controller" \
    --port 0 \
    --type hdd \
    --medium ${vm}_dsk1.vdi

    $ VBoxManage storageattach ${vm} \
    --storagectl "SAS Controller" \
    --port 1 \
    --type hdd \
    --medium ${vm}_dsk2.vdi

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

Run the command;

    $ VBoxManage list bridgedifs

Pay attention to the value:

Name: eth0

I use eth0 as the main physical interface that the virtual machines will use as a bridge.

Connect 3 virtual network "Intel® 82540EM Gigabit Ethernet Controller" interfaces to the virtual machine, operating as bridged (3 adapters are needed for RAC installation):

    $ VBoxManage modifyvm ${vm} \
    --nictype1 82540EM \
    --nic1 bridged \
    --bridgeadapter1 eth0

    $ VBoxManage modifyvm ${vm} \
    --nictype2 82540EM \
    --nic2 bridged \
    --bridgeadapter2 eth0

    $ VBoxManage modifyvm ${vm} \
    --nictype3 82540EM \
    --nic3 bridged \
    --bridgeadapter3 eth0

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

Here we specify:

--vrdeaddress - ip address of the machine where virtualbox is installed  
--vrdeauthtype null - authentication not required.  
--vrdemulticon on - multiple connections to virtual machines allowed.  
--vrdeport the port that can be connected to when the virtual machine starts.

### Show the created virtual machine result:

    $ VBoxManage showvminfo ${vm}

<br/>

## VIRTUAL MACHINE IS READY FOR OPERATING SYSTEM INSTALLATION

<br/>

### Start the virtual machine with RDP connection capability:

    $ VBoxHeadless --startvm ${vm}

I connect via RDP to the virtual machine. In Windows, this is the remote desktop connection console (mstsc I think), in linux remmina or rdesktop.

In the first window, I press tab and add linux text so that the installation proceeds in a convenient mode. The operating system should be installed on the 1st disk. The second will be for Oracle.

There should be 2 such virtual machines. After installation, I suggest cloning.

    $ vboxmanage clonevm vm_oel_rac1 --name vm_oel_rac2 --register
    $ vm=vm_oel_rac2
    $ VBoxHeadless --startvm ${vm}

<!--

Need to change the mac addresses of the virtual machines

    $ vboxmanage modifyvm ${vm} --macaddress1 auto
    $ vboxmanage modifyvm ${vm} --macaddress2 auto
    $ vboxmanage modifyvm ${vm} --macaddress3 auto


-->

You need to edit or delete the file contents that explicitly specifies which mac address corresponds to which interface.

     # cat /dev/null > /etc/udev/rules.d/70-persistent-net.rules

And reboot.
