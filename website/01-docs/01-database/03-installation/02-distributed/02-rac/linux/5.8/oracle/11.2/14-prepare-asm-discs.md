---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Installing asmlib
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Installing asmlib
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Installing asmlib
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/prepare-asm-discs/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Installing asmlib

<br/>

<strong>Need to install 3 packages:</strong><br/>

<ul>
	<li>oracleasm-*.rpm (package must match the kernel)</li>
	<li>oracleasm-support*.rpm</li>
	<li>oracleasmlib*.rpm</li>
</ul>

<br/>

    # yum search oracleasm
    # yum search oracleasmlib
    # yum search oracleasm-support

Packages that cannot be found in the Oracle repository should be downloaded from the official site:<br/>

http://www.oracle.com/technetwork/server-storage/linux/downloads/rhel5-084877.html

(by this link, probably nothing can be downloaded anymore)

<br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Installing ASMlib packages</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2</strong></span></td>
</tr>

</table>

First, determine which linux kernel is supported by the packages being installed.

Check which kernel is used on our virtual machine:

    # uname -rm
    2.6.32-300.10.1.el5uek x86_64

The repository has the latest oracleasm packages for the kernel.
oracleasm-2.6.18-308.el5.x86_64

Need to select the required kernel.

In the grub.conf file, specify which kernel to use and then reboot the node.

    # vi /etc/grub.conf

<br/>

    default=1
    timeout=0
    splashimage=(hd0,0)/boot/grub/splash.xpm.gz
    hiddenmenu
    title Oracle Linux Server (2.6.32-300.10.1.el5uek)
            root (hd0,0)
            kernel /boot/vmlinuz-2.6.32-300.10.1.el5uek ro root=LABEL=/
            initrd /boot/initrd-2.6.32-300.10.1.el5uek.img
    title Oracle Linux Server-base (2.6.18-308.el5)
            root (hd0,0)
            kernel /boot/vmlinuz-2.6.18-308.el5 ro root=LABEL=/
            initrd /boot/initrd-2.6.18-308.el5.img

<br/>

    # reboot

After reboot:

    # uname -rm
    2.6.18-308.el5 x86_64

It is enough to run the following commands for installation:

    # cd /tmp
    # wget http://download.oracle.com/otn_software/asmlib/oracleasmlib-2.0.4-1.el5.x86_64.rpm

<br/>

    # yum install -y \
    oracleasm-2.6.18-308.el5.x86_64 \
    oracleasmlib-2.0.4-1.el5.x86_64.rpm \
    oracleasm-support.x86_64

Make sure the following packages are installed on both cluster nodes

    # rpm -qa | grep oracleasm
    oracleasm-support-2.1.7-1.el5
    oracleasm-2.6.18-308.el5-2.0.5-1.el5
    oracleasmlib-2.0.4-1.el5

<br/><br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Configuring Oracle ASM</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2</strong></span></td>
</tr>

</table>

    # /etc/init.d/oracleasm configure

<br/>

    Default user to own the driver interface []: oracle11
    Default group to own the driver interface []: dba
    Start Oracle ASM library driver on boot (y/n) [n]: y
    Scan for Oracle ASM disks on boot (y/n) [y]: y
    Writing Oracle ASM library driver configuration: done
    Initializing the Oracle ASMLib driver:                 	[  OK  ]
    Scanning the system for Oracle ASMLib disks:           	[  OK  ]

If [FAILED], check the logs

    # less /var/log/oracleasm

The error may occur if incorrect user, group parameters are specified or if the wrong Oracle ASM driver version is selected (the driver must match the kernel).

    # /etc/init.d/oracleasm status
    Checking if ASM is loaded: yes
    Checking if /dev/oracleasm is mounted: yes

<br/><br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Adding disks to ASM pool</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">
	<tr>
	<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
	<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1</strong></span></td>
	</tr>
</table>

    # fdisk /dev/{mounted disk1}

<br/>

    # ls /dev/asm*

Label disks as ASM disks:

    # /etc/init.d/oracleasm createdisk VOL1 /dev/asm-disk1
    # /etc/init.d/oracleasm createdisk VOL2 /dev/asm-disk2
    # /etc/init.d/oracleasm createdisk VOL3 /dev/asm-disk3
    # /etc/init.d/oracleasm createdisk VOL4 /dev/asm-disk4
    # /etc/init.d/oracleasm createdisk VOL5 /dev/asm-disk5
    # /etc/init.d/oracleasm createdisk VOL6 /dev/asm-disk6
    # /etc/init.d/oracleasm createdisk VOL7 /dev/asm-disk7

    Marking disk "VOL1" as an ASM disk:                    	[  OK  ]

<!--
// View disk label

	# oracleasm querydisk /dev/sdi1

-->

// If need to delete

    # /etc/init.d/oracleasm deletedisk VOL1
    # dd if=/dev/zero of=/dev/sdi1

// View list of ASM disks

    # /etc/init.d/oracleasm listdisks

    VOL1
    VOL2
    VOL3
    VOL4
    VOL5
    VOL6
    VOL7

// Or like this

    # ls /dev/oracleasm/disks/
    VOL1  VOL2  VOL3  VOL4  VOL5  VOL6  VOL7

// log file

    # less /var/log/oracleasm

// In some cases, need to restart oracleasm

    # /etc/init.d/oracleasm restart

<br/><br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Checking ASM installation and configuration</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
	<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
	<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2</strong></span></td>
</tr>

</table>

node1:

    # /etc/init.d/oracleasm scandisks

node2:

    # /etc/init.d/oracleasm scandisks

node1:

    # /etc/init.d/oracleasm listdisks

node2:

    # /etc/init.d/oracleasm listdisks

Make sure disks are mounted on both servers.
If not, reboot the nodes (after setting autostart priorities, see below)

<br/><br/>

<span style="font-size: 20px; text-align: left; line-height: 130%; font-family: Arial,Helvetica,sans-serif; color: rgb(153, 0, 0);">
<strong>Checking startup priority of packages</strong></span>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
	<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
	<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>node1, node2</strong></span></td>
</tr>

</table>

    # cd /etc/rc3.d

for example:

    S60iscsi
    S65iscsid
    S80oracleasm
