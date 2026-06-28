---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Install
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/
---

# Installing Oracle DataBase Server 11.2.0.3.2 on Oracle Linux 6.3 x86_64

<div style="padding:10px; border:thin solid black;">

<strong>Warning</strong> Due to the time change by our "Government". The time on the server may still use the old rules. In some cases, Enterprise Manager does not work correctly because of this. This is fixed by patches that can be downloaded by those with access to Oracle support. I currently do not have this capability. If someone provides them, I will attach the patches to the topic. At the time of writing the article, there was no such problem, and I had access to Oracle support. The problem is fixed by the patch with the code name DST v23.

</div>

<br/>

This document describes one of the ways to install an Oracle database on Oracle Linux.

It should be used if you are just starting to learn the basics of Oracle database administration. If you need to use it in a production environment, you must ensure backup, multiplexing of critical database files, and properly configure system parameters.

If you find errors, inaccuracies, typos, or know better methods, <a href="/chat/">write to the chat or email</a>.

<strong>Latest versions (at the time of writing):</strong>

<ul>
	<li>Oracle Linux - 6.3 (better install 6.7)</li>
	<li>Oracle DataBase - 11.2.0.3 (better install 11.2.0.4)</li>
</ul>

<br/>

Installation is performed on a remote server without GUI.

The installation and configuration process is managed from a Windows workstation with putty and xming installed.

Commands are executed on the server via the putty console. Xming is needed to display graphical images.

<br/><br/>

<h2>Documentation:</h2>

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/docs/">Official Documentation</a><br/></li>
</ul>

<br/><br/>

<h2>Distributions:</h2>

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/distrib/">Database Distributions and Additional Software</a><br/></li>
</ul>

<br/><br/>

<h2>Preparing the Linux Operating System for Oracle Database Installation:</h2>

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/setup-os-parameters-before-we-start/">Setting Some Operating System Parameters</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/network-interface/">Configuring Network Interfaces</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/install-mandatory-packages/">Installing Mandatory Packages</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/setup-actual-time/">Setting Up Accurate Time</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/prepare-hdd-to-install-oracle/">Preparing Disks for Database Installation</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/prepare-kernel-parameters-and-user-environments/">Configuring System Users and System Parameters</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/autostart-only-packages-what-needed/">Autostart Only Selected Programs</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/create-folder-structure-and-user-permissions/">Creating Directory Structure and Setting Necessary Permissions</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/copy-oracle-distrib-on-server/">Copying Database Distributions to the Server</a></li>
</ul>

<br/><br/>

<h2>Database Installation:</h2>
<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-database-software-installation/">Installing Oracle DBMS (DataBase SoftWare)</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-listener-creation/">Creating Remote Server Connection Service (Listener)</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-instance-creation/">Creating a Database Instance</a></li>
</ul>

<br/><br/>

## After Installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/autorstart-oracle-after-restart/">Configuring Oracle Autostart After Reboot</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-cold-backup/">Creating a Backup of the Created Database (Cold Backup)</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-psu-update/">Updating the Database with Oracle Recommended Patches</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-restrict-root-access/">Disable Remote Root Login to the Database Server</a></li>
</ul>

<br/><br/>

## Ensuring Additional Fault Tolerance and Reliability:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-multiplex-controlfiles/">Multiplexing Controlfiles</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-multiplex-redologs/">Multiplexing Redologs</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/enable-archivelog-mod/">Enable ARCHIVELOG Mode</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-multiplex-archivelogs/">Multiplexing Archivelogs</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-additionals-datafiles/">Extending Tablespaces (Creating Additional Files for Tablespaces)</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/enable-flashback-mod/">Enable FLASH BACK Mode</a></li>
	<li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-final-hot-backup/">Final Backup (Hot Backup)</a></li>
</ul>

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
