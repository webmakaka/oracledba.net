---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (SHARED FILE SYSTEM)
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (SHARED FILE SYSTEM)
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, SHARED FILE SYSTEM
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/
---

# Oracle RAC 12.1 SHARED FILE SYSTEM Installation on Oracle Linux 6.7

<br/>

This document describes one of the methods for installing an Oracle database on Oracle Linux in a Real Application Cluster (RAC) configuration.

If you find errors, inaccuracies, typos, or you know better methods, <a href="/chat/">write to the chat or email</a>.

<br/><br/>

## Documentation:

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/docs/">Official Documentation</a></li>
</ul>

<br/><br/>

## Environment description for Oracle RAC installation:

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/environment-description/">Environment description for Oracle RAC installation</a></li>
</ul>

<br/><br/>

<h2>Distributives:</h2>

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/distrib/">Database distributions and additional software</a></li>
</ul>

<br/>

### Virtualbox virtual machine configs:

<ul>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/vm/">Virtualbox virtual machine configs</a></li>

</ul>

<br/>

### Environment preparation for RAC installation:

<ul>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/network-interfaces/">Network interface setup and hosts file</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/setup-os-parameters-before-begin/">Preliminary settings</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/setup-dns-server/">DNS server setup</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/install-mandatory-packages/">Installation of mandatory packages</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/autostart-only-packages-what-needed/">Selecting packages for autostart</a> (Необязательный шаг, можно пропустить)</li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/setup-actual-time/">Setting up time synchronization services</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/users-and-groups-creation/">Creating oracle12 user and administrative groups</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/secure-shell-between-nodes/">Setting up Secure Shell between cluster nodes</a></li>


    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/prepare-storage/">Preparing the storage server (RAID, NFS)</a></li>


    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/prepare-hdd-to-install-oracle/">Preparing local disks on cluster nodes for Oracle Database Software installation</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/mount-raid-on-nodes/">Mounting RAID on cluster nodes</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/configure-kernel-parameters-and-user-environments/">Changing kernel parameters and database administrator account parameters</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/create-folder-structure-and-user-permissions/">Creating directory structure and assigning necessary permissions</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/copy-oracle-distrib-on-server/">Copying database distributions to the server</a></li>


    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/check-environment-before-install/">Checking cluster configuration before RAC installation</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/check-display-manager/">Checking Display Manager operation on the computer with GUI</a></li>

</ul>

<br/><br/>

## RAC installation and database instance creation:

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/grid-installation/">Grid Installation</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/oracle-database-software-installation/">Oracle Database Software Installation</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/oracle-instance-creation/">Creating database instance</a></li>

</ul>

<br/><br/>

## Steps performed after RAC deployment:

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/post-installation-tasks/">Post-installation tasks</a></li>
</ul>
