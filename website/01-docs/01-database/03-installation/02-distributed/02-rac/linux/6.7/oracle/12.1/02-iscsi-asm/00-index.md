---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 x86_64 (ISCSI + ASM)
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 x86_64 (ISCSI + ASM)
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/
---

# Oracle RAC 12.1 Installation on Oracle Linux 6.7 x86_64 (ISCSI + ASM)

This document describes one of the methods for installing an Oracle database on Oracle Linux in a Real Application Cluster (RAC) configuration.

If I understood correctly. OCR and Voting Disk now need to be stored on ASM disks either local or from storage. I.e., OCFS2 file systems no longer need to be configured for storing this data.

If you find errors, inaccuracies, typos, or you know better methods, <a href="/chat/">write to the chat or email</a>.

<br/><br/>

## Documentation:

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/docs/">Official documentation</a></li>
</ul>

<br/><br/>

## Environment description for Oracle RAC installation:

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/environment-description/">Environment description for Oracle RAC installation</a></li>
</ul>

<br/><br/>

<h2>Distributives:</h2>

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/distrib/">Database distributives and additional software</a></li>
</ul>

<br/>

### Virtualbox machine configs:

<ul>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/vm/">Virtualbox machine configs</a></li>

</ul>

<br/>

### Environment preparation for RAC installation:

<ul>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/network-interfaces/">Network interface configuration and hosts file</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/setup-os-parameters-before-begin/">Pre-configuration settings</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/setup-dns-server/">DNS server setup</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/install-mandatory-packages/">Installation of mandatory packages</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/autostart-only-packages-what-needed/">Selecting packages for autostart</a> (Optional step, can be skipped)</li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/setup-actual-time/">Configuration of time synchronization services</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/users-and-groups-creation/">Creating oracle12 user and administrative groups</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/secure-shell-between-nodes/">Secure Shell configuration between cluster nodes</a></li>

</ul>

<br/>

### Preparing disk subsystem for the RAC being created:

<ul>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/asmlib-installation/">ASMLIB installation on cluster nodes</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/prepare-storage/">Storage server preparation (ISCSI)</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/prepare-hdd-to-install-oracle/">Preparing local disks on cluster nodes for Oracle Database Software installation</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/mount-iscsi-on-nodes/">Mounting SCSI disks on cluster nodes</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/setup-mounting-rules-by-device-mapper/">[Option 1] Configuring SCSI disk mounting rules on cluster nodes using Device Mapper</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/setup-mounting-rules-by-uder-rules/">[Option 2] Configuring SCSI disk mounting rules on cluster nodes using Udev rules</a> (If the previous step was completed, this one is not needed)</li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/prepare-asm-discs/">Configuring ASM on cluster nodes, labeling disks as ASM</a></li>

</ul>

<br/>

### Final configuration steps and checking prepared environment readiness for RAC installation:

<ul>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/create-folder-structure-and-user-permissions/">Creating directory structure and assigning necessary permissions</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/copy-oracle-distrib-on-server/">Copying database distributives to the server</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/configure-kernel-parameters-and-user-environments/">Modifying kernel parameters and database administrator account parameters</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/check-environment-before-install/">Checking cluster configuration before RAC installation</a></li>


    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/check-display-manager/">Checking Display Manager operation on the GUI computer</a></li>

</ul>

<br/><br/>

## RAC installation and database instance creation:

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/grid-installation/">Grid installation</a></li>

    <li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/asm-disk-groups-creation/">Creating ASM disk groups</a></li>


    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/oracle-database-software-installation/">Oracle Database Software installation</a></li>

    <li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/oracle-instance-creation/">Creating a database instance</a></li>

</ul>

<br/><br/>

## Steps performed after RAC deployment:

<ul>
	<li><a href="/database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/post-installation-tasks/">Post-installation tasks</a></li>
</ul>
