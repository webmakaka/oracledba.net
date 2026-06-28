---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Distributions and Additional Software
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Distributions and Additional Software
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Distributions and Additional Software
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2//distrib/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Distributions and Additional Software

The latest versions of Oracle DB and critical patch updates are available to commercial subscribers with an active technical support contract. If you have a support contract, you can download database distributions directly from support.oracle.com.

If you do not have a contract, simply registering on the Oracle website will not be enough to download the latest versions, even for evaluation.

There are no activation keys. Distributions can be used for free for development, but for their primary purpose (production), a license must be purchased.

<br/><br/>

<strong>VirtualBox:</strong><br/>
hxxp://www.virtualbox.org/wiki/Downloads

<strong>Oracle Linux Server 6 Update 3 (x86_x64) Distributions:</strong><br/>
hxxp://rutracker.org/forum/viewtopic.php?t=4112274

<strong>upd: Oracle Linux Server 6 Update 4 (x86_x64):</strong><br/>
hxxp://rutracker.org/forum/viewtopic.php?t=4407896

<strong>Oracle Database Distributions (11.2.0.3) Linux x64:</strong><br/>
hxxp://rutracker.org/forum/viewtopic.php?t=3749965

<strong>upd: Oracle (11.2.0.4) Linux x64:</strong><br/>
hxxp://rutracker.org/forum/viewtopic.php?t=4522137

<br/><br/>

<strong>Archive Contents:</strong>

<pre>
// Oracle Database (includes Oracle Database and Oracle RAC)
p10098816_112020_Linux-x86-64_1of7.zip
p10098816_112020_Linux-x86-64_2of7.zip

// Oracle Grid Infrastructure (includes Oracle ASM, Oracle Clusterware, and Oracle Restart)
p10098816_112020_Linux-x86-64_3of7.zip

// Oracle Database Client
p10098816_112020_Linux-x86-64_4of7.zip

// Oracle Gateways
p10098816_112020_Linux-x86-64_5of7.zip

// Oracle Examples
p10098816_112020_Linux-x86-64_6of7.zip

// Deinstall
p10098816_112020_Linux-x86-64_7of7.zip
</pre>

For the Oracle installation described in this guide, the first 2 archives are sufficient.

<br/>

<strong>Putty:</strong><br/>
http://www.putty.org/

<strong>winscp:</strong><br/>
http://winscp.net/eng/download.php

<strong>XMing</strong> (you need to install XMing, additional fonts, and I recommend restarting the computer):<br/>
http://sourceforge.net/projects/xming/<br/>
http://sourceforge.net/projects/xming/files/Xming-fonts/

Next, you need to configure access rules.<br/>
The simplest way is to right-click on the xming shortcut, go to properties, and add -ac to the target (i.e., no access control)

<img src="https://img.oracledba.net/img/oracle/database/simple/12.1/XMing.png" border="0" alt="XMing">

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
