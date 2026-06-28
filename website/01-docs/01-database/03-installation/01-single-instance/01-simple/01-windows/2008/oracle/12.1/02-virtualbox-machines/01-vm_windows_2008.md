---
layout: page
title: Creating a VirtualBox Virtual Machine for Installing Oracle Database on Windows 2008 Server
description: Creating a VirtualBox Virtual Machine for Installing Oracle Database on Windows 2008 Server
keywords: Oracle DataBase, Installation, Windows 2008, VirtualBox
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/virtualbox-machines/windows/2008/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server]</a>: Creating a VirtualBox Virtual Machine for Installing Oracle Database on Windows 2008 Server

<br/>

For information on how I installed virtualbox, variables, and directories, see  
<a href="//sysadm.ru/server/linux/virtual/virtualbox/">here</a>

Set a variable with the name of the virtual machine being created to avoid having to substitute this value in commands later.

    # su - vmadm
    $ vm=vm_win2k8_oradb12.1
    $ echo $vm

Create directories for the virtual machine and for snapshots

    $ mkdir -p ${VM_HOME}/${vm}/snapshots

<br/>

### Creating and registering a virtual machine:

List supported operating systems

    $ VBoxManage list ostypes

For a Windows 2k8 virtual machine

    $ VBoxManage createvm \
    --name ${vm} \
    --ostype Windows2008_64  \
    --basefolder ${VM_HOME}/${vm} \
    --register

I choose a motherboard with a more modern chipset. Default is piix3

    $ VBoxManage modifyvm ${vm}  --chipset piix3

Setting up processors.

    $ VBoxManage modifyvm ${vm}  --cpus 2

Setting the amount of RAM

    $ VBoxManage modifyvm ${vm} --memory 4096

Connecting a 32 MB video card

    $ VBoxManage modifyvm ${vm} --vram 32

Remove sound card, remove floppy drive

    $ VBoxManage modifyvm ${vm} --floppy disabled --audio none

I connect the hard disk controller (SATA). (With the SAS controller connected, Windows does not see hard drives)

    $ VBoxManage storagectl ${vm} \
    --add sata \
    --name "SATA Controller"

Create virtual hard disks. Size is recommended to be set according to available resources. Otherwise, problems and virtual machine crashes may occur:

    $ cd ${VM_HOME}/${vm}/${vm}

If you do not want to copy-paste the same thing 8 times, you can use just one command:

Create disks with 1 command:

    $ for i in $(seq 1 8 )
    do VBoxManage createhd --filename ${vm}_dsk_dsk$i.vdi --size 40960 --format VDI --variant Standard
    done

Attach disks with 1 command:

    $ for i in $(seq 1 8 )
    do VBoxManage storageattach ${vm} --storagectl "SATA Controller" --device 0 --port $i --type hdd --medium ${vm}_dsk_dsk$i.vdi
    done

Connect the IDE controller to which the DVD-ROM will be attached later:

    $ VBoxManage storagectl ${vm} \
    --add ide \
    --name "IDE Controller"

Connect the DVD image of the operating system being installed to the IDE controller:

    $ VBoxManage storageattach ${vm} \
    --storagectl "IDE Controller" \
    --port 0 \
    --device 0 \
    --type dvddrive \
    --medium /mnt/dsk2/_ISO/_Microsoft/win2k8/x64/en_windows_server_2008_with_sp2_x64_dvd_342336.iso

### Connecting network interfaces:

(My computer is connected to a router (a regular home router). Data exchange between my computer and the virtual machine will pass through it. If you are not using a router or switch, you need to create network interfaces with the parameter bridget replaced by internal connection.)

Run the command:

    $ VBoxManage list bridgedifs

Pay attention to the value:

    Name:            eth0

I use eth0 as the main physical interface that the virtual machines will use as a bridge.

I connect 2 virtual network interfaces "Intel® 82540EM Gigabit Ethernet Controller" working as bridged to the virtual machine:

    $ VBoxManage modifyvm ${vm} \
    --nictype1 82540EM \
    --nic1 bridged \
    --bridgeadapter1 eth0

Connect the DVD image of the operating system being installed to the IDE controller:

    $ VBoxManage modifyvm ${vm} \
    --nictype2 82540EM \
    --nic2 bridged \
    --bridgeadapter2 eth0

Define the boot order of devices

    $ VBoxManage modifyvm ${vm} \
    --boot1 disk \
    --boot2 dvd

Define the snapshot directory

    $ VBoxManage modifyvm ${vm} \
    --snapshotfolder ${VM_HOME}/${vm}/snapshots

<br/>

Allow RDP connection to the machine:

    $ VBoxManage modifyvm ${vm} \
    --vrde on \
    --vrdemulticon on \
    --vrdeauthtype null \
    --vrdeaddress 192.168.1.5 \
    --vrdeport 3389

Here we specify:

--vrdeaddress - ip address of the machine where virtualbox is installed.  
--vrdeauthtype null - no authentication required.  
--vrdemulticon on - multiple connections to virtual machines are allowed.  
--vrdeport port that can be connected to when the virtual machine starts.

Show the result of the created virtual machine:

    $ VBoxManage showvminfo ${vm}  | less

Create a snapshot before OS installation

    $ VBoxManage snapshot ${vm} take before_os_installation

## VIRTUAL MACHINE IS READY FOR OPERATING SYSTEM INSTALLATION

Start the virtual machine with RDP connection capability

    $ VBoxHeadless --startvm ${vm}

You can check running virtual machines with the command

\$ vboxmanage list runningvms

If you work on linux, you can connect to the virtual machine using rdesktop

    $ rdesktop \
    -r sound:local \
    -k common  \
    -g  1600x1024 \
    192.168.1.5:3389

If you need to connect with a specific "geometry", use the parameter  
-g 1600x1024

If you need to work in full screen mode, remove the -g key and replace it with -f

To exit full screen mode - CTRL+ALT+ENTER

rdesktop - all available keys:<br/>
http://manpages.ubuntu.com/manpages/lucid/man1/rdesktop.1.html<br/>

In Windows, Remote Desktop Connection (mstsc.exe) is suitable for this. In Linux, there is a similar program for connecting to remote desktops - Remmina.

For more detailed documentation on creating snapshots and backups of virtual machines, see
<a href="//sysadm.ru/server/linux/virtual/virtualbox/">here</a>

For normal operation in Windows, you will also need to install VirtualBox Guest Additions  
http://download.virtualbox.org/virtualbox/4.3.30/
