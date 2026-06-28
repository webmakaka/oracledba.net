---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Creating a VirtualBox Virtual Machine for Database Installation
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Creating a VirtualBox Virtual Machine for Database Installation
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, VirtualBox
permalink: /database/installation/single-instance/simple/oel/7.4/oracle/db/12.2/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Creating a VirtualBox Virtual Machine for Database Installation

<br/>

About how I installed virtualbox, variables and directories, see  
<a href="//sysadm.ru/server/linux/virtual/virtualbox/">here</a>

<br/>

### Creating a virtual machine:

    # su - vmadm

Set the virtual machine name:

    $ vm=vm_oel_7.4_oracle_db_12.2

Create directories for the virtual machine and for snapshots

    $ mkdir -p ${VM_HOME}/${vm}/snapshots

### Creating and registering the virtual machine:

    $ VBoxManage createvm \
    --name ${vm} \
    --ostype Oracle_64 \
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
    --medium  /mnt/dsk1/oracle/OracleLinux/7.4/V921569-01.iso

<br/>

### Connecting network interfaces:

Configuration option when the server will run on my computer and should not be accessible outside of it.

I needed 1 hostonly adapter to connect to the virtual machine via SSH from the host.

    $ VBoxManage modifyvm ${vm} \
    --nictype1 82540EM \
    --nic1 hostonly \
    --hostonlyadapter1 vboxnet0

And 1 NAT adapter so the computer can access the internet.

    $ VBoxManage modifyvm ${vm} \
    --nictype2 82540EM \
    --nic2 nat

<br/>

ifconfig on the host machine should show vboxnet0.  
vboxnet0 - virtual adapter of the host machine.

    $ ifconfig vboxnet0

If the virtual adapter is missing, you need to create it manually.

    $ VBoxManage hostonlyif create

<br/>

    $ vboxmanage list hostonlyifs
    Name:            vboxnet0
    GUID:            786f6276-656e-4074-8000-0a0027000000
    DHCP:            Disabled
    IPAddress:       192.168.56.1
    NetworkMask:     255.255.255.0
    IPV6Address:
    IPV6NetworkMaskPrefixLength: 0
    HardwareAddress: 0a:00:27:00:00:00
    MediumType:      Ethernet
    Status:          Down
    VBoxNetworkName: HostInterfaceNetworking-vboxnet0

Assign an ip if it doesn't have one.

    $ VBoxManage hostonlyif ipconfig vboxnet0 --ip 192.168.56.1

Start if needed

    $ sudo ifconfig vboxnet0 up

<br/>

    $ ifconfig vboxnet0
    vboxnet0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
            inet 192.168.56.1  netmask 255.255.255.0  broadcast 192.168.56.255
            ether 0a:00:27:00:00:00  txqueuelen 1000  (Ethernet)
            RX packets 0  bytes 0 (0.0 B)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 0  bytes 0 (0.0 B)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

<br/>

If something went wrong, you can delete the created interface with the command:

    $ VBoxManage modifyvm ${vm} --nic2 none

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

<br/>

### Connecting via RDP to the virtual machine.

On Windows, this can be the remote desktop connection console (start --> RUN --> mstsc).
On Linux - remmina or rdesktop and many others.

Doing on Ubuntu 12.04

    $ sudo apt-get install -y rdesktop

<br/>

In Oracle Linux, the package is not in the standard repos I have connected.

I did it like this:

    # rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
    # rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
    # yum install rdesktop

<br/>

    $ rdesktop \
    -r sound:local \
    -k common  \
    -g  1600x1024 \
    192.168.1.5:3389

In the first window, press tab and add linux text so that the installation proceeds in a convenient mode. The operating system should be installed on 1 disk.
