---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Autostart Only Selected Programs
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Autostart Only Selected Programs
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Autostart Only Selected Programs
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/autostart-only-packages-what-needed/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Autostart Only Selected Programs

The following command disables autostart for all packages at once.

    # for i in $(chkconfig --list | grep '3:on\|4:on\|5:on' | awk {'print $1'}); do chkconfig --level 345 $i off; done

View which programs currently autostart at boot.

    # chkconfig --list | grep '3:on\|4:on\|5:on'  |awk '{print $1}' | sort

Then, enable autostart for the following programs:

    # {
    chkconfig --level 345 network on
    chkconfig --level 345 sshd on
    chkconfig --level 345 ntpd on
    }

<br/>

    # {
    chkconfig --level 345 auditd on
    chkconfig --level 345 messagebus on
    chkconfig --level 345 netfs on
    chkconfig --level 345 sysstat on
    chkconfig --level 345 crond on
    chkconfig --level 345 xinetd on
    }

The following will be added later:

    # chkconfig --level 345 startupOracleDatabase11GR2 on

Make sure ssh is enabled for autostart!.

    # chkconfig --list | grep ssh

Next, reboot the server to ensure everything starts up correctly after reboot.

    # reboot

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
