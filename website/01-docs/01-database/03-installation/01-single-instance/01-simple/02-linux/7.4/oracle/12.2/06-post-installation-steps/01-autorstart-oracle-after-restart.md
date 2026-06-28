---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring Oracle Autostart After Reboot
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring Oracle Autostart After Reboot
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Oracle autostart
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/autorstart-oracle-after-restart/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Configuring Oracle Autostart After Reboot

<br/>

    $ vi /etc/oratab

<br/>

    orcl12:/u01/oracle/database/12.2:N

replace with

    # orcl12:/u01/oracle/database/12.2:N
    orcl12:/u01/oracle/database/12.2:Y

<br/>

### Creating a script to start and stop the database at OS boot and shutdown

<!-- The script of the following content will be added to autostart (run the commands after this script):


<script src="http://gist-it.appspot.com/https://github.com/oradev/oracle-dba-scripts/blob/master/oracle_12R1_startup_and_shutdown_script">
</script> -->

    # cd /tmp

    # vi oracle_12.2_startup_and_shutdown_script

https://bitbucket.org/oracle-dba/oracle-dba-startup-and-shutdown-scripts/src/14797e3bf31c47d9b70b98539e8f248650666a97/oracle_12.2_startup_and_shutdown_script?at=master&fileviewer=file-view-default

<!-- # wget -O startupOracleDatabase12R1 https://github.com/oradev/oracle-dba-scripts/raw/master/oracle_12R1_startup_and_shutdown_script -->

    # mv oracle_12.2_startup_and_shutdown_script /etc/rc.d/init.d/
    # chmod +x /etc/rc.d/init.d/oracle_12.2_startup_and_shutdown_script
    # chkconfig --add oracle_12.2_startup_and_shutdown_script
    # chkconfig --level 345 oracle_12.2_startup_and_shutdown_script on
