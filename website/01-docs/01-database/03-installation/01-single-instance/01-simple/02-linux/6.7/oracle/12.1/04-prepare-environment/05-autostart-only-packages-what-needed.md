---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Autostart Only Selected Programs
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Autostart Only Selected Programs
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Autostart Only Selected Programs
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/autostart-only-packages-what-needed/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Autostart Only Selected Programs

The following command disables autostart for all packages at once.

    # for i in $(chkconfig --list | grep '3:on\|4:on\|5:on' | awk {'print $1'}); do chkconfig --level 345 $i off; done

See which programs currently autostart when the operating system starts.

    # chkconfig --list | grep '3:on\|4:on\|5:on'  |awk '{print $1}' | sort

After that, enable autostart for the following programs:

    # {
    chkconfig --level 345 network on
    chkconfig --level 345 sshd on
    chkconfig --level 345 ntpd on
    }

<br/>

    # {
    chkconfig --level 345 auditd on
    chkconfig --level 345 netfs on
    chkconfig --level 345 sysstat on
    chkconfig --level 345 crond on
    chkconfig --level 345 xinetd on
    }

Later, the following will also be added:

    # chkconfig --level 345 startupOracleDatabase12R1 on

Make sure that ssh will be started at autostart!

    # chkconfig --list | grep ssh

Next, (however, you can also reboot just before starting the installation) you should reboot the server to make sure everything comes up normally after reboot.

    # reboot
