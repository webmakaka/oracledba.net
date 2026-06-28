---
layout: page
title: Oracle RAC 12.1 SHARED FILE SYSTEM - Virtual machine configs for cluster nodes
description: Oracle RAC 12.1 SHARED FILE SYSTEM - Virtual machine configs for cluster nodes
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, SHARED FILE SYSTEM
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/vm/rac-nodes/
---

# [Oracle RAC 12.1 SHARED FILE SYSTEM Installation]: Virtual machine configs for cluster node installation

    # su - vmadm

<br/>

    $ vm=vm_oel_rac1

Creating directories for the virtual machine and for snapshots

    $ mkdir -p ${VM_HOME}/${vm}/snapshots

### Creating and registering the virtual machine:

    $ VBoxManage createvm \
    --name ${vm} \
    --ostype RedHat_64 \
    --basefolder ${VM_HOME}/${vm} \
    --register

### Setting the RAM limit:

    $ VBoxManage modifyvm ${vm} --memory 4608

### Connecting a video card with 32 MB:

    $ VBoxManage modifyvm ${vm} --vram 32

### Removing sound card, removing floppy drive:

    $ VBoxManage modifyvm ${vm} --floppy disabled --audio none

### Connecting a hard disk controller (SAS):

    $ VBoxManage storagectl ${vm} \
    --add sas \
    --name "SAS Controller"

### Creating and connecting hard disks:

I create virtual hard disks. The size is recommended to be set according to available resources. Otherwise, problems and virtual machine crashes may occur):

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

### Connecting disks to SAS controller:

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

Run the command;

    $ VBoxManage list bridgedifs

Pay attention to the value:

Name: eth0

Я использую eth0 как основной физический интерфейс, который будут использовать виртуальные машины в качестве моста.

Подключаю к виртуальной машине 3 виртуальных сетевых “Intel® 82540EM Gigabit Ethernet Controller”, работающих как bridget (3 адаптера нужные в случае необходимости установить RAC):

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

Here we specify:

--vrdeaddress - ip address of the machine on which virtualbox is installed  
--vrdeauthtype null - authentication is not required.  
--vrdemulticon on - multiple connections to virtual machines are allowed.  
--vrdeport port to which you can connect when the virtual machine starts.

### Show the result of the created virtual machine:

    $ VBoxManage showvminfo ${vm}

<br/>

## THE VIRTUAL MACHINE IS READY FOR OPERATING SYSTEM INSTALLATION

<br/>

### Start the virtual machine with the ability to connect via RDP:

    $ VBoxHeadless --startvm ${vm}

I connect via RDP to the virtual machine. In Windows it's the remote desktop console (mstsc I think), in linux remmina or rdesktop.

In the first window I press tab and add linux text so that the installation proceeds in a convenient mode for me. The operating system should be installed on 1 disk. The second will be for Oracle.

There should be 2 such virtual machines. After installation, I suggest cloning.

    $ vboxmanage clonevm vm_oel_rac1 --name vm_oel_rac2 --register
    $ vm=vm_oel_rac2
    $ VBoxHeadless --startvm ${vm}

<!--

Нужно поменять mac адреса вирту

    $ vboxmanage modifyvm ${vm} --macaddress1 auto
    $ vboxmanage modifyvm ${vm} --macaddress2 auto
    $ vboxmanage modifyvm ${vm} --macaddress3 auto


-->

Need to edit or delete the contents of the file that explicitly specifies which interface corresponds to which mac address.

     # cat /dev/null > /etc/udev/rules.d/70-persistent-net.rules

И перезагрузиться.
