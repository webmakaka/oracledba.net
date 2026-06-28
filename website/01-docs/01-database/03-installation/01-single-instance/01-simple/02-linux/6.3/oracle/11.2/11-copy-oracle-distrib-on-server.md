---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Copying Distributions to the Server
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Copying Distributions to the Server
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Copying Distributions to the Server
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/copy-oracle-distrib-on-server/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Copying Database Distributions to the Server (to the /tmp directory)

The following archives need to be copied to the /tmp directory on the server:

    p10404530_112030_Linux-x86-64_1of7.zip
    p10404530_112030_Linux-x86-64_2of7.zip

Only the first 2 archives out of 7 are needed for database installation.

If the archives are on a Linux server, you can use the scp utility.

For example, the following command can fetch the database distributions from another Linux server and place them in the /tmp directory:

    # scp marley@192.168.1.5:/oracle/p10404530_112030_Linux-x86-64_{1..2}of7.zip /tmp/

If you are using Windows, the easiest way is to use winscp.

Next, set the owner of the downloaded archives to oracle11

    # chown -R oracle11:oinstall /tmp/p10404530_112030_Linux-x86-64_*

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
