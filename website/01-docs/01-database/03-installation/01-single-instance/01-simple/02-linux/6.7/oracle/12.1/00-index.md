---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7
description: Oracle DataBase 12c Installation on Oracle Linux 6.7
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Install
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/
---

# [Oracle DataBase 12c Release 1 Server Installation on Oracle Linux 6.7]

<br/>

This document describes one way to install an Oracle database on the Oracle Linux operating system.

Use it if you are just starting to learn the basics of Oracle database administration. If you need to use it in a production environment, be sure to provide backup, multiplexing of critical database files and properly configure system parameters.

If you find errors, inaccuracies, typos, or know better ways, <a href="/chat/">write to the chat or email address</a>.

<br/>

<strong>Latest versions (at the time of writing):</strong>

<ul>
	<li>Oracle Linux - 6.7</li>
	<li>Oracle DataBase - 12.1</li>
</ul>

<br/>

Installation is performed on a remote server without GUI.

Management of the installation and configuration process is done from a workstation using an SSH client. On Windows it can be Putty, on Linux a standard Terminal.

<br/><br/>

## Documentation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/docs/">Official documentation</a><br/></li>
</ul>

## Distributions:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/distrib/">Database distributions and additional software</a><br/></li>
</ul>

## Creating a VirtualBox virtual machine for database installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/virtual-machine/">Creating a VirtualBox virtual machine for database installation</a><br/></li>
</ul>

## Installing Oracle Linux 6.7:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oel67-installation/">Installing Oracle Linux 6.7</a><br/></li>
</ul>

<br/><br/>

## Preparing the Linux operating system for Oracle database installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/network-interfaces/">Configuring network interfaces</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-os-parameters-before-we-start/">Setting OS parameters before starting</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/install-mandatory-packages/">Installing mandatory packages</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-actual-time/">Configuring time synchronization services</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/autostart-only-packages-what-needed/">Autostart only selected programs</a></li>


    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/prepare-hdd-to-install-oracle/">Preparing hard disks for database installation</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/prepare-kernel-parameters-and-user-environments/">Configuring system users, system parameter settings</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/create-folder-structure-and-user-permissions/">Creating directory structure and assigning necessary permissions</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-display-manager/">Configuring Display Manager</a></li>

  <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/copy-oracle-distrib-on-server/">Copying database distributions to the server</a></li>

</ul>

<br/><br/>

## Database installation:

<ul>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-database-software-installation/">Installing Oracle DBMS (DataBase Software)</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-listener-creation/">Creating a remote connection service to the server (Listener)</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-instance-creation/">Creating a database instance</a></li>

</ul>

<br/><br/>

## Post-installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/autorstart-oracle-after-restart/">Configuring Oracle autostart after reboot</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-setup-fast-recovery-area-params/">Setting FAST RECOVERY AREA parameters</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-cold-backup/">Creating a backup of the created database (cold backup)</a></li>


    <li>Updating the database with patches recommended by Oracle (I don't have access to download patches right now. Was demonstrated during Oracle 11 installation)</li>


    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-restrict-root-access/">Restrict remote connection to the database server by root user</a></li>

    <li>Allow remote connection to the server via SSH only from specific IP addresses by creating rules in iptables (possible improvement, not described here)</li>

    <li>Block the ability to connect to the server after entering an incorrect password more than 5 times (Fail2ban) (possible improvement, not described here)</li>

</ul>

<br/><br/>

## Ensuring additional fault tolerance and reliability:

<ul>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-controlfiles-multiplexing/">Multiplexing controlfiles</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-redologs-multiplexing/">Multiplexing redologs</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/enable-archivelog-mod/">Enable ARCHIVELOG mode</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-archivelogs-multiplexing/">Multiplexing archivelog</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-change-default-datafile-location/">Changing data file location</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-additionals-datafiles/">Extending tablespaces (creating additional files for tablespaces)</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/enable-flashback-mod/">Enable FLASH BACK mode</a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-final-hot-backup/">Final backup (hot backup)</a></li>

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
