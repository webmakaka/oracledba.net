---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Distributions and Additional Software
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Distributions and Additional Software
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Distributions and Additional Software
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/distrib/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Distributions and Additional Software

The latest versions of Oracle DB and critical patch updates are available to commercial subscribers with an active technical support contract. If you have a support contract, you can download database distributions directly from support.oracle.com.

If you don't have a contract, simply registering on the Oracle website will not be enough to download the latest versions, even for study purposes.

There are no activation keys required. For development, distributions can be used for free, but for their intended use (production), a license must be purchased.

<br/>

### Software:

<strong>VirtualBox:</strong><br/>
http://www.virtualbox.org/wiki/Downloads

<br/>

<strong>Oracle Linux Server 6 Update 7 (x86_x64) distributions:</strong><br/>
http://linux.oracle.com

<strong>Backup download sources:</strong><br/>
hxxp://rutracker.org/forum/viewtopic.php?t=4603407

<br/>

<strong>Oracle Database (12.1) Linux x64 distributions:</strong><br/>
http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

<strong>Backup download sources:</strong><br/>
hxxp://rutracker.org/forum/viewtopic.php?p=65149195#65149195

For installation, the following are sufficient:<br/>

linuxamd64_12c_database_1of2.zip<br/>
linuxamd64_12c_database_2of2.zip

<br/>

### If the computer from which the installation is managed runs Windows:

<strong>Putty (SSH Client):</strong><br/>
http://www.putty.org/

<br/>

<strong>XMing (For displaying graphical windows during installation)</strong> (need to install XMing, additional fonts, and restart the computer):<br/>
http://sourceforge.net/projects/xming/<br/>
http://sourceforge.net/projects/xming/files/Xming-fonts/

<br/><br/>

<p>Next, configure access rules.<br />
In the simplest case, right-click on the xming shortcut. Go to properties and add -ac to the target (i.e., no access control)</p>

<p><img src="https://img.oracledba.net/img/oracle/database/simple/12.1/XMing.png" border="0" alt="XMing" /></p>

<br/><br/>

<strong>winscp (For copying files to the server):</strong><br/>
http://winscp.net/eng/download.php

<br/>

### If the computer from which the installation is managed runs Linux:

Everything is already there
