---
layout: page
title: Repository Creation Utility (RCU)
description: Repository Creation Utility (RCU)
keywords: Oracle, Repository Creation Utility, RCU
permalink: /middleware/rcu/
---

# Repository Creation Utility (RCU)

<br/>

**Installing on 27.11.2017**

<br/>

Previously, the database was installed according to this document:

<ul>
    <li><a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">Installation of Oracle Database 12.2 on Oracle Linux 7.4</a></li>
</ul>

<br/>
<br/>

Download from here:  
http://www.oracle.com/technetwork/middleware/data-integrator/downloads/index.html

Repository Creation Utility (RCU) (11.1.1.9.0) for Linux (x64)

<br/>

Copied ofm_rcu_linux_11.1.1.9.0_64_disk1_1of1.zip to the server.

    $ ssh oracle12@192.168.56.101
    $ cd "distrib_folder"
    $ unzip ofm_rcu_linux_11.1.1.9.0_64_disk1_1of1.zip

<br/>

To avoid the error "ORA-28040: No matching authentication protocol"

I do the following:

    $ cd /u01/oracle/database/12.2/network/admin/sqlnet.ora


    -- created the file and added the following lines
    $ vi sqlnet.ora

{% highlight shell %}

SQLNET.ALLOWED_LOGON_VERSION_CLIENT=8
SQLNET.ALLOWED_LOGON_VERSION_SERVER=8

{% endhighlight %}

<br/>

### Let's start installing

    -- 192.168.1.5 - host machine
    $ xclock -display 192.168.1.5:0


    $ export DISPLAY=192.168.1.5:0.0

    $ cd /tmp/rcuHome/bin
    $ ./rcu

<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic01.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic02.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic03.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic04.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic05.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic06.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic07.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic08.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic09.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic10.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic11.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic12.png" border="0" alt="RCU Installation">
<br/><br/><img src="https://img.oracledba.net/03-middleware/rcu/pic13.png" border="0" alt="RCU Installation">

<br/>
<br/>

**Might be useful:**

<br/>

<ul>
    <li><a href="/business-intelligence/repository-creation-utility/">Creating a database schema for the OBIEE application using Repository Creation Utility (RCU)</a></li>
</ul>
