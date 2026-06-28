---
layout: page
title: Oracle DataBase Installation
description: Instructions for installing Oracle databases
keywords: Oracle, linux, installation, asm, standby, rac
permalink: /database/installation/
---

# Oracle DataBase Installation

A pre-configured VirtualBox virtual machine from Oracle engineers can be downloaded from the following URL:

https://www.oracle.com/database/technologies/databaseappdev-vm.html

<br/>

P.S.

Colleagues have posted a video on how to deploy a database using Vagrant + SSH scripts. It uses Oracle Linux 8 and an Oracle 19C database. To install, copy the distribution to the required directory and run vagrant. The scripts will handle everything else.

https://www.youtube.com/watch?v=0ogLoZfYOYs&t=0s

https://github.com/oraclebase/vagrant/tree/master/database/ol8_19

<br/>

## For information:

<br/>

If there is no need to install Oracle on a specific operating system and the primary goal is to learn Oracle, I recommend installing the database on Oracle Linux. Oracle took the RedHat source code and built its own distribution. The Oracle Linux public repository contains packages that can greatly simplify database installation and additional packages that extend standard capabilities. In addition to all of the above, you can use the customized UEK kernel, which in some cases has some advantages over the standard one. But you need to test your specific application. Links to the Oracle Linux distribution are in the installation topic.

<br/>

## Preparation for Oracle Database Installation:

<br/>

(Use if the document itself lacks information on how to do this)

<ul>
	<li>
		<a href="//sysadm.ru/server/linux/virtual/virtualbox/setup/centos/6/">Installing VirtualBox on Centos 6.4 Server without GUI</a>
	</li>
	<li>
		<a href="//gitops.ru/tools/virtual/virtualbox/setup/ubuntu/">Installing VirtualBox on Ubuntu in the Console</a>
	</li>
  <li><a href="/database/installation/virtualbox-machines/windows/2008/">Creating a VirtualBox Virtual Machine for Installing Oracle Database on Windows</a></li>

  <li><a href="/database/installation/virtualbox-machines/oracle-linux/">Creating a VirtualBox Virtual Machine for Installing Oracle Database on Linux</a></li>

  <li><a href="/database/installation/oracle-linux-installation/6.x/">Installing Oracle Linux 6.7 x86 64 bit</a></li>

  <li><a href="https://docs.google.com/document/d/1awpSIKnu2akCwEh7fbe4bY_W9G3VIr1t5Ps4hg2q2gs/edit">Installing Oracle Linux 5.8 x86 64 bit</a></li>

</ul>

<br/><br/>

# Single-Instance Architecture

<br/>

## Installing Oracle Database on Microsoft Windows:

<br/>

<ul>
	<li><a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/"><strong>Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server</strong></a> (might have made some mistakes at the beginning)</li>
</ul>

<br/>

<!-- <li><a href="http://odba.ru/showthread.php?t=294"><strong>Инсталляция Oracle Database 11g Release 2 в операционной системе Microsoft Windows 2003 Server</strong></a></li>

    <li><a href="http://odba.ru/showthread.php?t=297"><strong>Инсталляция Oracle Database 10g Release 2 в операционной системе Microsoft Windows 2003 Server</strong></a> </li> -->

<br/>

### May also be useful:

<!-- <li><a href="http://odba.ru/showthread.php?t=331"><strong>Команды редактора VI</strong></a></li> -->

<br/>

## Installing Oracle Database on Oracle Linux:

<br/>

<ul>
	
    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/"><strong>Installing Oracle DataBase Server 12.2 on Oracle Linux 7.4</strong></a> (the version 6.7 guide is preferred!)</li>

    <li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/"><strong>Installing Oracle DataBase Server (12.1.0.1) on Oracle Linux 6.7</strong></a></li>

    <li><a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/"><strong>Installing Oracle DataBase Server (11.2.0.3) on Oracle Linux (6.3 x86_64)</strong></a> (Server Linux -- Windows workstation)</li>

</ul>

<br/>
<br/>

<strong>Installation using ASM:</strong>
<br/><br/>

<ul>

<!-- <li><a href="http://odba.ru/showthread.php?t=60">Информация о ASM (Automatic Storage Management) </a></li> -->

<li><a href="/database/installation/single/asm/linux/6.7/oracle/12.1/">Installing Oracle DataBase Server 12.1 on Centos 6.7 using ASM and GRID</a></li>

</ul>

<br/>

ASM is a more "correct" way to prepare the Oracle environment.
The idea is that data is stored not on a file system (e.g., ext\*) designed for regular operating system operations, but on a file system developed by Oracle specialists for data storage.

"Raw" hard disks without a file system are combined into pools using Oracle tools, which allows them to be organized logically and have (some) advantages over the operating system file system.

This creates an additional Oracle instance, installs GRID,
and provides (some) additional capabilities. Administration becomes somewhat more complex.

Personally, I have not had extensive experience working with environments where ASM was used
(so I might not know some things), but I have installed (installed, handed over, and forgot)
and configured ASM in a RAC environment.

If I understood something incorrectly, please correct me.

<br/>

## Installing Oracle Client:

Oracle Client is needed to connect to the database using a wide range of database management tools, such as PL/SQL Developer, SQL Navigator, TOAD.

Oracle's SQL Developer can connect without installing Oracle Client.

<ul>
	<li><a href="/client/installation/windows/7/oracle/12.1/">Installing Oracle Client 12C (32 bit) on Windows 7 (64 bit)</a> (64-bit client does not work with programs like PL/SQL Developer)</li>

    <li><a href="https://docs.google.com/document/d/1VTV0bBZff-lyXmRTXE67tuZjXcHAlWTrq4g_c2mfoJI/edit">Installing Oracle Client 11G R2 32 bit on Windows XP 32 bit</a></li>

    <li><a href="/database/installation/oracle-client-installation/linux/6.3/oracle/11.2/">Installing Oracle Instantclient on OEL 6.3 x86-64</a></li>

</ul>

<br/>

**Instantclient** - an alternative to the standard Oracle Client. Simpler to install on Linux (if you need to install a client on Ubuntu, it's better to use this one). It is a minimal set of libraries for remote connection to the database server. In addition, I usually install the SQLPlus command-line utility. That's all you really need for normal operation.

<!-- <br/>

## Installing Oracle Database on other operating systems:

<ul>
	<li><a href="http://odba.ru/showthread.php?t=303"><strong>Инсталляция Oracle Database 11g Release 2 в Oracle Solaris 10</strong></a> (Необходимо переделать!)</li>
</ul> -->

<br/>

## Installing Free Oracle Database Editions:

<ul>
    <li><a href="https://www.youtube.com/watch?v=kiuIwHxFvpg"><strong>[YouTube] Oracle Database 21c Express Edition (XE) Installation (Linux)</strong></a></li>
    <li><a href="/database/installation/single-instance/centos/7/oracle/xe/18c/"><strong>Installing the free but resource-limited Oracle 18c XE database on Centos 7 Server</strong></a></li>
	<!-- <li><a href="http://odba.ru/showthread.php?t=742"><strong>Инструкция по инсталляции базы данных Oracle 11g XE на сервер Oracle Enterprise Linux 5.8</strong></a></li>
	<li><a href="http://odba.ru/showthread.php?t=400"><strong>Инструкция по инсталляции базы данных Oracle 10g XE на сервер Oracle Enterprise Linux 4.8</strong></a></li>
	<li><a href="http://odba.ru/showthread.php?t=296"><strong>Инсталляция Oracle Database 10g Express Edition в ОС Windows 2003 Server </strong></a></li> -->
</ul>

<br/>

# Distributed System Architectures:

<br/>

### DataGuard (Standby)

<ul>
    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/">Oracle Active Data Guard (Beta version of the document)</a></li>
    <!-- <li><a href="http://odba.ru/showthread.php?t=469">Oracle Data Guard: Развертывание физического Standby средствами Oracle Database</a></li> -->
</ul>

<br/>

### Real Application Cluster (RAC)

<ul>
    <li>
        <a href="/database/installation/distributed/rac/">Installing Real Application Cluster (RAC)</a>
    </li>
    <li>
        <a href="https://www.youtube.com/watch?v=Tmm9o5MusA8">[YouTube] Vagrant Oracle Real Application Clusters (RAC) Build
        </a>
    </li>
</ul>

<br/>

### Configs for Oracle autostart using systemd

<ul>
    <li>
        <a href="/database/installation/autostart/systemd/">here</a>
    </li>
</ul>

<br/>
<br/>

## Streams, GoldenGate

Oracle had a data replication solution between databases called Streams. The big corporation bought a competitor to this technology, one of the leaders in this class of tasks - Golden Gate. I haven't worked with Streams, but I have configured Golden Gate.

<ul>
<!-- <li><a href="http://odba.ru/forumdisplay.php?f=116">GoldenGate</a></li> -->
<li>[HabraHabr] <a href="https://habr.com/ru/post/238521/" rel="nofollow">Configuring bidirectional Oracle Database synchronization (Oracle Streams)</a></li>
</ul>
