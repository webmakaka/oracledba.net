---
layout: page
title: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Distributions
description: Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server - Distributions
keywords: Oracle DataBase, Installation, Windows 2008, Distributions
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/distrib/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Installing Oracle Database 12c Release 1 on Microsoft Windows 2008 Server]</a>: Distributions and Additional Software

<br/>

The latest versions of Oracle DB and critical patch updates are available to commercial subscribers with an active technical support contract. If you have a support contract, you can download database distributions directly from support.oracle.com.

If you do not have a contract, simply registering on the Oracle website will not be enough to download the latest versions, even for evaluation.

There are no activation keys. Distributions can be used for free for development, but for their primary purpose (production), a license must be purchased.

<br/><br/>

<strong>VirtualBox:</strong><br/>
http://www.virtualbox.org/wiki/Downloads

<br/><br/>

<strong>Oracle Database Distributions (12.1) Windows x64:</strong><br/>
http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

<br/><br/>

<strong>Alternative download sources:</strong><br/>
hxxp://rutracker.org/forum/viewtopic.php?p=60527998#60527998
<br/>

For installation, the following are sufficient:<br/>
linuxamd64_12c_database_1of2.zip<br/>
linuxamd64_12c_database_2of2.zip

<br/><br/>

<strong>For managing the installation process on Windows:</strong>

<br/><br/>

<strong>Putty (Management Console, for entering commands):</strong><br/>
http://www.putty.org/

<br/><br/>

<strong>XMing (For displaying graphical windows during installation)</strong> (you need to install XMing, additional fonts, and restart the computer):<br/>
http://sourceforge.net/projects/xming/<br/>
http://sourceforge.net/projects/xming/files/Xming-fonts/

<br/><br/>

<p>Next, you need to configure access rules.<br />
The simplest way is to right-click on the xming shortcut, go to properties, and add -ac to the target (i.e., no access control)</p>

<p><img src="https://img.oracledba.net/img/oracle/database/simple/12.1/XMing.png" border="0" alt="XMing" /></p>

<br/><br/>

<strong>winscp (For copying files to the server):</strong><br/>
http://winscp.net/eng/download.php
