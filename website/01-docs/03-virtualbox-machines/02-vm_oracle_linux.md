---
layout: page
title: Creating a VirtualBox virtual machine for installing Oracle database in Linux
description: Creating a VirtualBox virtual machine for installing Oracle database in Linux
keywords: Oracle Database, Preparing the environment for installing Oracle database in Linux, VirtualBox
permalink: /database/installation/virtualbox-machines/oracle-linux/
---

# Creating a VirtualBox virtual machine for installing Oracle database in Linux

Example of creating a VirtualBox virtual machine for installing an Oracle database server<br/>
The virtual machine is created in Ubuntu. <br/>
A virtual machine is created similarly in RedHat distributions.

Set a variable with the name of the virtual machine being created to avoid repeatedly typing this value in commands.

    # su - vmadm
    $ vm=vm_oel6.4_oradb12.1
    $ echo $vm

Create directories for the virtual machine and for snapshots

    $ mkdir -p ${VM_HOME}/${vm}/snapshots

### Creating and registering the virtual machine:

Find out the list of supported operating systems

    $ VBoxManage list ostypes

If creating an Oracle Linux 64 virtual machine:

    $ VBoxManage createvm \
    --name ${vm} \
    --ostype Oracle_64 \
    --basefolder ${VM_HOME}/${vm} \
    --register

You should see the message:<br/>
Virtual machine 'vm_oel6.4_oradb12.1' is created and registered.

<br/>

Selecting a motherboard with a more modern chipset. Default is piix3

    $ VBoxManage modifyvm ${vm}  --chipset piix3

Setting up processors.

    $ VBoxManage modifyvm ${vm}  --cpus 2

Setting the RAM amount

    $ VBoxManage modifyvm ${vm} --memory 4096

Connecting a 32 MB video card

    $ VBoxManage modifyvm ${vm} --vram 32

Removing the sound card, removing the floppy drive

    $ VBoxManage modifyvm ${vm} --floppy disabled --audio none

Connecting the hard disk controller (SAS)

    $ VBoxManage storagectl ${vm} \
    --add sas \
    --name "SAS Controller"

Creating virtual hard disks. Size is recommended to be set according to available resources. Otherwise, problems and virtual machine crash may occur):

    $ cd ${VM_HOME}/${vm}/${vm}

If you don't want to copy-paste the same thing 8 times, you can use just one command:

Create disks with 1 command:

    $ for i in $(seq 1 8 )
    do VBoxManage createhd --filename ${vm}_dsk_dsk$i.vdi --size 40960 --format VDI --variant Standard
    done

Attach disks with 1 command:

    $ for i in $(seq 1 8 )
    do let port=$i-1; VBoxManage storageattach ${vm} --storagectl "SAS Controller" --port $port --type hdd --medium ${vm}_dsk_dsk$i.vdi
    done

<!--
<br/><br/>
Or manually (More reliable):
<br/><br/>

       <div class="linuxCommand">
	$ VBoxManage createhd \<br/>
--filename ${vm}_dsk1.vdi \<br/>
--size 40960 \<br/>
--format VDI \<br/>
--variant Standard<br/>
       </div>


<br/><br/>


       <div class="linuxCommand">
$ VBoxManage createhd \<br/>
--filename ${vm}_dsk2.vdi \<br/>
--size 40960 \<br/>
--format VDI \<br/>
--variant Standard<br/>
       </div>



<br/><br/>


       <div class="linuxCommand">
$ VBoxManage createhd \<br/>
--filename ${vm}_dsk3.vdi \<br/>
--size 40960 \<br/>
--format VDI \<br/>
--variant Standard<br/>
       </div>


<br/><br/>


       <div class="linuxCommand">
$ VBoxManage createhd \<br/>
--filename ${vm}_dsk4.vdi \<br/>
--size 40960 \<br/>
--format VDI \<br/>
--variant Standard<br/>
       </div>



<br/><br/>


       <div class="linuxCommand">
$ VBoxManage createhd \<br/>
--filename ${vm}_dsk5.vdi \<br/>
--size 40960 \<br/>
--format VDI \<br/>
--variant Standard<br/>
       </div>


<br/><br/>


       <div class="linuxCommand">
$ VBoxManage createhd \<br/>
--filename ${vm}_dsk6.vdi \<br/>
--size 40960 \<br/>
--format VDI \<br/>
--variant Standard<br/>
       </div>


<br/><br/>


       <div class="linuxCommand">
$ VBoxManage createhd \<br/>
--filename ${vm}_dsk7.vdi \<br/>
--size 40960 \<br/>
--format VDI \<br/>
--variant Standard<br/>
       </div>

<br/><br/>


       <div class="linuxCommand">
$ VBoxManage createhd \<br/>
--filename ${vm}_dsk8.vdi \<br/>
--size 40960 \<br/>
--format VDI \<br/>
--variant Standard<br/>
       </div>

<br/><br/>
Attaching disks to the SAS controller (max 8):


       <div class="linuxCommand">
$ VBoxManage storageattach ${vm} \<br/>
--storagectl "SAS Controller" \<br/>
--port 0 \<br/>
--type hdd \<br/>
--medium ${vm}_dsk1.vdi<br/>
       </div>

<br/><br/>

       <div class="linuxCommand">
$ VBoxManage storageattach ${vm} \<br/>
--storagectl "SAS Controller" \<br/>
--port 1 \<br/>
--type hdd \<br/>
--medium ${vm}_dsk2.vdi<br/>
       </div>

<br/><br/>

       <div class="linuxCommand">
$ VBoxManage storageattach ${vm} \<br/>
--storagectl "SAS Controller" \<br/>
--port 2 \<br/>
--type hdd \<br/>
--medium ${vm}_dsk3.vdi<br/>
       </div>

<br/><br/>

       <div class="linuxCommand">
$ VBoxManage storageattach ${vm} \<br/>
--storagectl "SAS Controller" \<br/>
--port 3 \<br/>
--type hdd \<br/>
--medium ${vm}_dsk4.vdi<br/>
       </div>

<br/><br/>

       <div class="linuxCommand">
$ VBoxManage storageattach ${vm} \<br/>
--storagectl "SAS Controller" \<br/>
--port 4 \<br/>
--type hdd \<br/>
--medium ${vm}_dsk5.vdi<br/>
       </div>

<br/><br/>

<div class="linuxCommand">
$ VBoxManage storageattach ${vm} \<br/>
--storagectl "SAS Controller" \<br/>
--port 5 \<br/>
--type hdd \<br/>
--medium ${vm}_dsk6.vdi<br/>
</div>

<br/><br/>

<div class="linuxCommand">
$ VBoxManage storageattach ${vm} \<br/>
--storagectl "SAS Controller" \<br/>
--port 6 \<br/>
--type hdd \<br/>
--medium ${vm}_dsk7.vdi<br/>
</div>

<br/><br/>

<div class="linuxCommand">
$ VBoxManage storageattach ${vm} \<br/>
--storagectl "SAS Controller" \<br/>
--port 7 \<br/>
--type hdd \<br/>
--medium ${vm}_dsk8.vdi<br/>
</div>

-->

Connect the IDE controller to which the DVD-ROM will later be connected:

    $ VBoxManage storagectl ${vm} \
    --add ide \
    --name "IDE Controller"

Connect the DVD image of the operating system being installed to the IDE controller:

    $ VBoxManage storageattach ${vm} \
    --storagectl "IDE Controller" \
    --port 0 \
    --device 0 \
    --type dvddrive \
    --medium /mnt/dsk2/_ISO/_OEL/OracleLinux-R6-U4-Server-x86_64-dvd.iso

### Connecting network interfaces:

(My computer is connected to a router (a regular home router). Data exchange between my computer and the virtual machine will go through it. If you are not using a router or switch, you need to create network interfaces with the parameter set to internal connection instead of bridged.)

Run the command;

    $ VBoxManage list bridgedifs

Pay attention to the value:

    Name:            eth0

I use eth0 as the main physical interface that virtual machines will use as a bridge.

Connecting 2 virtual network interfaces "Intel® 82540EM Gigabit Ethernet Controller" to the virtual machine, operating as bridged:

    $ VBoxManage modifyvm ${vm} \
    --nictype1 82540EM \
    --nic1 bridged \
    --bridgeadapter1 eth0

Connect the DVD image of the operating system being installed to the IDE controller:

    $ VBoxManage modifyvm ${vm} \
    --nictype2 82540EM
    --nic2 bridged \
    --bridgeadapter2 eth0

(If you plan to install RAC, it is recommended to set up a 3rd interface)

    $ VBoxManage modifyvm ${vm} \
    --nictype3 82540EM \
    --nic3 bridged \
    --bridgeadapter3 eth0

Determining the boot order of devices

    $ VBoxManage modifyvm ${vm} \
    --boot1 disk \
    --boot2 dvd

Setting the snapshot directory

    $ VBoxManage modifyvm ${vm} \
    --snapshotfolder ${VM_HOME}/${vm}/snapshots

Enable RDP connection to the machine:

$ VBoxManage modifyvm ${vm} \
--vrde on \
--vrdemulticon on \
--vrdeauthtype null \
--vrdeaddress 192.168.1.5 \
--vrdeport 3389

Here we specify:

--vrdeaddress - IP address of the machine where VirtualBox is installed.  
--vrdeauthtype null - no authentication required.  
--vrdemulticon on - multiple connections to virtual machines are allowed.  
--vrdeport - port to which you can connect when the virtual machine starts.

Creating a snapshot before OS installation

    $ VBoxManage snapshot ${vm} take before_os_installation

VIRTUAL MACHINE IS READY FOR OPERATING SYSTEM INSTALLATION

Show the result of the created virtual machine:

    $ VBoxManage showvminfo ${vm}  | less

Start the virtual machine with RDP connection capability

    $ VBoxHeadless --startvm ${vm}

View running virtual machines with the command

    $ vboxmanage list runningvms

If you work in Linux, you can connect to the virtual machine using rdesktop

    $ rdesktop \
    -r sound:local \
    -k common  \
    -g  1600x1024 \
    192.168.1.5:3389

If you need to connect with a specific "geometry", use the parameter -g 1600x1024

If you need to work in full-screen mode, remove the -g flag and replace it with -f

To exit full-screen mode - CTRL+ALT+ENTER

rdesktop - all available options:  
http://manpages.ubuntu.com/manpages/lucid/man1/rdesktop.1.html

In Windows, Remote Desktop Connection (mstsc.exe) is suitable for this. In Linux, there is a similar program for connecting to remote desktops - Remmina.

A more detailed document on creating snapshots and backups of virtual machines:<br/>
https://docs.google.com/document/d/1ZU6Hk5DYitFYwlRFqN2qmJr6maPpvgsVc6ZTiZ1kYVA/edit
