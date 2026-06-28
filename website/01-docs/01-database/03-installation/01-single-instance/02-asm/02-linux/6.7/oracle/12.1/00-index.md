---
layout: page
title: Oracle DataBase Server 12.1 Installation on Centos 6.7 using ASM and GRID
description: Oracle DataBase Server 12.1 Installation on Centos 6.7 using ASM and GRID
keywords: Oracle DataBase 12.1, Centos 6.7, ASM, GRID
permalink: /database/installation/single/asm/linux/6.7/oracle/12.1/
---

# [Oracle DataBase Server 12.1 Installation on Centos 6.7 using ASM and GRID]

<br/>

This document describes one way to install an Oracle database on the Oracle Linux operating system.

Use it if you are just starting to learn the basics of Oracle database administration. If you need to use it in a production environment, be sure to provide backup, multiplexing of critical database files and properly configure system parameters.

If you find errors, inaccuracies, typos, or know better ways, <a href="/chat/">write to the chat or email address</a>.

<br/>

**Previous version of the document:**  
Oracle DataBase 11G R2 x86 64 bit Installation on Oracle Linux 5.7 x86 64 bit (ASM)  
https://docs.google.com/document/d/1iGmRtwwcC9FGESnlR7v5qrcLKOzGIoh1GNeU5N0Q5cQ/edit

<br/>

<strong>Latest versions (at the time of writing):</strong>

<ul>
	<li>Oracle Linux - 6.7</li>
	<li>Oracle DataBase - 12.1</li>
</ul>

<br/><br/>

Installation is performed on a remote server without GUI.

Management of the installation and configuration process is done from a workstation running Linux via SSH.

<br/>

Steps without links assume that the same thing is done as in the <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">instruction without ASM and without GRID</a>. (to avoid writing too much)

<br/>

## Preparing the Linux operating system for Oracle database installation:

<ul>

    <li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/prepare/">Setting hostname and hosts</a></li>


    <li>Setting OS parameters before starting</li>

    <li>Configuring actual time</li>

    <li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/asmlib-installation/">Installing ASMLIB for ASM operation</a></li>

    <li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/prepare-kernel-parameters-and-user-environments/">Configuring system users, system parameter settings</a></li>

    <li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/prepare-asm-disks/">Preparing ASM disks for database installation</a></li>

    <li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/create-folder-structure-and-user-permissions/">Creating directory structure and assigning necessary permissions</a></li>

    <li>Autostart only selected programs</li>

    <li>Configuring Display Manager</li>

    <li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/extract-oracle-distrib-from-archives/">Extracting Oracle database distributions from archives</a></li>

</ul>

<br/><br/>

## Installing GRID:

<ul>
	<li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/grid-installation/">Installing GRID</a></li>

</ul>

<br/><br/>

## Creating ASM disk groups:

<ul>
	<li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/asm-diskgroup-creation/">Creating ASM disk groups</a></li>

</ul>

<br/><br/>

## Installing Oracle DBMS (DataBase Software):

<ul>
    <li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/oracle-database-software-installation/">Installing Oracle DBMS (DataBase Software)</a></li>
</ul>

<br/><br/>

## Creating a database instance:

<ul>
    <li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/oracle-instance-creation/">Creating a database instance</a></li>
</ul>
