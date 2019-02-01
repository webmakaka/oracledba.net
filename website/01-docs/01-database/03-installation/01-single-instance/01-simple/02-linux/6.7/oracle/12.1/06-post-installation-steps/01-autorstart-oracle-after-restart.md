---
layout: page
title: Oracle DataBase 12c - Linux - Setup autostart Oracle after reboot
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/autorstart-oracle-after-restart/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Setup autostart Oracle after reboot

    $ vi /etc/oratab

replace

    orcl12:/u01/oracle/database/12.1:N

on

    # orcl12:/u01/oracle/database/12.1:N
    orcl12:/u01/oracle/database/12.1:Y

<br/>

### Creating script for autostart Oracle after reboot

Next script we add to autostart (execute next commnds after this script):

    # cd /tmp

    # vi startupOracleDatabase12R1

    	https://bitbucket.org/oracle-dba/oracle-dba-startup-and-shutdown-scripts/raw/14797e3bf31c47d9b70b98539e8f248650666a97/oracle_12R1_startup_and_shutdown_script

<br/><br/>

    # mv startupOracleDatabase12R1 /etc/rc.d/init.d/
    # chmod +x /etc/rc.d/init.d/startupOracleDatabase12R1
    # chkconfig --add startupOracleDatabase12R1
    # chkconfig --level 345 startupOracleDatabase12R1 on
