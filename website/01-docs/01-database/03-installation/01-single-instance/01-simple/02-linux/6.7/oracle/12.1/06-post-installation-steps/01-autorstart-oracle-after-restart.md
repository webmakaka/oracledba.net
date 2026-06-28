---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring Oracle Autostart After Reboot
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring Oracle Autostart After Reboot
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Configuring Oracle Autostart
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/autorstart-oracle-after-restart/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Configuring Oracle Autostart After Reboot

    $ vi /etc/oratab

<br/>

    orcl12:/u01/oracle/database/12.1:N

replace with

    # orcl12:/u01/oracle/database/12.1:N
    orcl12:/u01/oracle/database/12.1:Y

<br/>

### Creating a script to start and stop the database at OS boot and shutdown

<!-- The script of the following content will be added to autostart (run the commands after this script):


<script src="http://gist-it.appspot.com/https://github.com/oradev/oracle-dba-scripts/blob/master/oracle_12R1_startup_and_shutdown_script">
</script> -->

    # cd /tmp

    # vi startupOracleDatabase12R1

https://bitbucket.org/oracle-dba/oracle-dba-startup-and-shutdown-scripts/raw/b6be770160490abcc906953237985ddcfa2c7224/oracle_12R1_startup_and_shutdown_script

<!-- # wget -O startupOracleDatabase12R1 https://github.com/oradev/oracle-dba-scripts/raw/master/oracle_12R1_startup_and_shutdown_script -->

    # mv startupOracleDatabase12R1 /etc/rc.d/init.d/
    # chmod +x /etc/rc.d/init.d/startupOracleDatabase12R1
    # chkconfig --add startupOracleDatabase12R1
    # chkconfig --level 345 startupOracleDatabase12R1 on
