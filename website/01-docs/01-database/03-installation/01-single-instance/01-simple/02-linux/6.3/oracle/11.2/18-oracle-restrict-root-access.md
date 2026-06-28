---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Disable Remote Root Login to the Database Server
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Disable Remote Root Login to the Database Server
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Disable Remote Root Login
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-restrict-root-access/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Disable Remote Root Login to the Database Server

<br/>

    # vi /etc/ssh/sshd_config

Change

    #PermitRootLogin yes

<br/>

to

    PermitRootLogin no

<br/>

    # service sshd restart

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
