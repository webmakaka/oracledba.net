---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Installation
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/
---

<br/>

# [Oracle DataBase 12.2 Installation on Oracle Linux 7.4]

<br/>

### Last installed using this guide for test tasks on 24.11.2017. (Need to fix the material in kernel parameter settings.)

<br/>

This document describes one way to install an Oracle database on the Oracle Linux operating system.

Use it if you are just starting to learn the basics of Oracle database administration. If you need to use it in a production environment, be sure to provide backup, multiplexing of critical database files and properly configure system parameters.

If you find errors, inaccuracies, typos, or know better ways, <a href="/chat/">write to the chat or email address</a>.

<br/>

<strong>Latest versions (at the time of writing):</strong>

<ul>
	<li>Oracle Linux - 7.4</li>
	<li>Oracle DataBase - 12.2</li>
</ul>

<br/>

Installation is performed on a remote server without GUI.

Management of the installation and configuration process is done from a workstation using an SSH client. On Windows it can be Putty, on Linux a standard Terminal.

<br/>

## Distributions:

This time I took the distributions from the official Oracle website. This is the database and Oracle Linux.

Oracle Linux can be downloaded from linux.oracle.com. Please note that you need to click on the "Download" button, not try to log in.
I downloaded the database from oracle.com while logged in as a user. In the new website interface, it's quite difficult to find what you need.

<br/>

## Creating a VirtualBox virtual machine for database installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/oel/7.4/oracle/db/12.2/">Creating a VirtualBox virtual machine for database installation</a><br/></li>
</ul>

<br/>

## Installing Oracle Linux 7.4:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oel-7.4-installation/">Installing Oracle Linux 7.4</a><br/></li>
</ul>

<br/><br/>

## Preparing the Linux operating system for Oracle database installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/network-interfaces/">Configuring network interfaces</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/setup-os-parameters-before-we-start/">Setting OS parameters before starting</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/install-mandatory-packages/">Installing mandatory packages</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/setup-actual-time/">Configuring time synchronization services</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/prepare-hdd-to-install-oracle/">Preparing hard disks for database installation</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/prepare-kernel-parameters-and-user-environments/">Configuring system users, system parameter settings</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/create-folder-structure-and-user-permissions/">Creating directory structure and assigning necessary permissions</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/setup-display-manager/">Configuring Display Manager</a></li>

  <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/copy-oracle-distrib-on-server/">Copying database distributions to the server</a></li>

</ul>

<br/><br/>

## Database installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-database-software-installation/">Installing Oracle DBMS (DataBase Software)</a></li>

    <li><a href="/database/installation/single-instance/linux/7.3/oracle/12.2/oracle-listener-creation/">Creating a remote connection service to the server (Listener)</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-instance-creation/">Creating a database instance</a></li>

</ul>

<br/><br/>

## Post-installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/autorstart-oracle-after-restart/">Configuring Oracle autostart after reboot</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-setup-fast-recovery-area-params/">Setting FAST RECOVERY AREA parameters</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-cold-backup/">Creating a backup of the created database (cold backup)</a></li>

    <li>Updating the database with patches recommended by Oracle (I don't have access to download patches right now. Was demonstrated during Oracle 11 installation)</li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-restrict-root-access/">Restrict remote connection to the database server by root user</a></li>

    <li>Allow remote connection to the server via SSH only from specific IP addresses by creating rules in iptables (possible improvement, not described here)</li>

    <li>Block the ability to connect to the server after entering an incorrect password more than 5 times (Fail2ban) (possible improvement, not described here)</li>

</ul>

<br/><br/>

## Ensuring additional fault tolerance and reliability:

<ul>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-controlfiles-multiplexing/">Multiplexing controlfiles</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-redologs-multiplexing/">Multiplexing redologs</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/enable-archivelog-mod/">Enable ARCHIVELOG mode</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-archivelogs-multiplexing/">Multiplexing archivelog</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-change-default-datafile-location/">Changing data file location</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-additionals-datafiles/">Extending tablespaces (creating additional files for tablespaces)</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/enable-flashback-mod/">Enable FLASH BACK mode</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-final-hot-backup/">Final backup (hot backup)</a></li>

</ul>

<br/><br/>

## Connecting to the database from a client computer:

<ul>

    <li><a href="/client/installation/windows/7/oracle/12.1/">Installing Oracle Client 12C (32 bit) on Windows 7 (64 bit)</a> (PL/SQL Developer and similar programs do not work with a 64-bit client)</li>

</ul>

<br/><br/>

<div style="padding:10px; border:thin solid black;" align="center">

  <h3>If you have suggestions for improvement, write!</h3>

</div>
