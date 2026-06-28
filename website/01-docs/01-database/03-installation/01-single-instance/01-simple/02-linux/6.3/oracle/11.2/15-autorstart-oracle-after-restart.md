---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Configuring Oracle Autostart After Reboot
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Configuring Oracle Autostart After Reboot
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Oracle Autostart
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/autorstart-oracle-after-restart/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Configuring Oracle Autostart After Reboot

<br/>

    $ vi /etc/oratab

<br/>

    ora112:/u01/oracle/database/11.2:N

replace with

    # ora112:/u01/oracle/database/11.2:N
    ora112:/u01/oracle/database/11.2:Y

### Creating a script to start and stop the database at system startup and shutdown:

Create a database startup script with the following content.

    # vi /etc/rc.d/init.d/startupOracleDatabase11GR2

content:

https://bitbucket.org/oracle-dba/oracle-dba-startup-and-shutdown-scripts/raw/b6be770160490abcc906953237985ddcfa2c7224/oracle_11GR2_startup_and_shutdown_script

    # chmod +x /etc/rc.d/init.d/startupOracleDatabase11GR2
    # chkconfig --add startupOracleDatabase11GR2
    # chkconfig --level 345 startupOracleDatabase11GR2 on

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
