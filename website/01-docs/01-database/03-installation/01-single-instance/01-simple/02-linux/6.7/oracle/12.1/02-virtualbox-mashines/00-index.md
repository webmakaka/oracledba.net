---
layout: page
title: Oracle DataBase 12c - Linux 6.7 - Creating virtual machine for Oracle Database
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/virtual-machine/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Creating virtual machine for Oracle Database

I installed virtualbox like here:  
https://sysadm.ru/linux/virtual/virtualbox/

<br/>

### Virtual machine Creating:

    # su - vmadm

Setup vm name:

    $ vm=vm_oel6.7_oracle12.1

To create folder for vm and snapshots

    $ mkdir -p ${VM_HOME}/${vm}/snapshots

### To create and register vm:

    $ VBoxManage createvm \
    --name ${vm} \
    --ostype RedHat_64 \
    --basefolder ${VM_HOME}/${vm} \
    --register

### Setup RAM:

    $ VBoxManage modifyvm ${vm} --memory 4096

### Setup videocard:

    $ VBoxManage modifyvm ${vm} --vram 32

### Disable sound card and floppy:

    $ VBoxManage modifyvm ${vm} --floppy disabled --audio none

### Connect SAS Controller:

    $ VBoxManage storagectl ${vm} \
    --add sas \
    --name "SAS Controller"

### Create Virtual Hard Disks:

    $ cd ${VM_HOME}/${vm}/${vm}

Creating 8 disks with 1 command:

    $ for i in $(seq 1 8 )
    do VBoxManage createhd --filename ${vm}_dsk_dsk$i.vdi --size 40960 --format VDI --variant Standard
    done

### Connect disks to SAS Controller:

To do this with 1 command:

    $ for i in $(seq 1 8 )
    do let port=$i-1; VBoxManage storageattach ${vm} --storagectl "SAS Controller" --port $port --type hdd --medium ${vm}_dsk_dsk$i.vdi
    done

### Connect IDE conroller for ISO:

    $ VBoxManage storagectl ${vm} \
    --add ide \
    --name "IDE Controller"

### Connect to IDE controller ISO with Oracle Linux:

    $ VBoxManage storageattach ${vm} \
    --storagectl "IDE Controller" \
    --port 0 \
    --device 0 \
    --type dvddrive \
    --medium  /mnt/dsk1/oracle/OracleLinux6U7/x64/OracleLinux-R6-U7-Server-x86_64-dvd.iso

### Connect network interfaces:

Execute;

    $ VBoxManage list bridgedifs

Look to name:

Name: eth0

    $ VBoxManage modifyvm ${vm} \
    --nictype1 82540EM \
    --nic1 bridged \
    --bridgeadapter1 eth0

    $ VBoxManage modifyvm ${vm} \
    --nictype2 82540EM \
    --nic2 bridged \
    --bridgeadapter2 eth0

<br/>

### Setup boot order priority:

    $ VBoxManage modifyvm ${vm} \
    --boot1 disk \
    --boot2 dvd

### Setup catalog for snapshots:

    $ VBoxManage modifyvm ${vm} \
    --snapshotfolder ${VM_HOME}/${vm}/snapshots

### To connect virtual machine by RDP:

    $ VBoxManage modifyvm ${vm} \
    --vrde on \
    --vrdemulticon on \
    --vrdeauthtype null \
    --vrdeaddress 192.168.1.5 \
    --vrdeport 3389

Here we setup:

--vrdeaddress - hostmachine ip  
--vrdeauthtype null - no authentication  
--vrdemulticon on - apply multi access to virtual machine
--vrdeport - port to connect by RDP when vm start.

### Show results:

    $ VBoxManage showvminfo ${vm}

<br/>

## Virtual machine Ready

<br/>

### Start VM:

    $ VBoxHeadless --startvm ${vm}

To connect on Windows to VM use mstsc.  
In linux use remmina or rdesktop.

After VM start. Connect to it remotely.
Press tab and write linux text to start installation Oracle Linux without GUI.
