---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Setting OS Parameters
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Setting OS Parameters
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Setting OS Parameters
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/setup-os-parameters-before-we-start/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Setting OS Parameters Before Starting

Some comments on the following command. Create a backup of the /etc/selinux/config file, and change the SELINUX parameter value from enforcing to disabled

    # sed -i.bkp -e "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

Here, we create a backup and change the timeout value from 5 to 0

    # sed -i.bkp -e "s/timeout=5/timeout=0/g" /boot/grub/grub.conf

Turn off firewall

    # service iptables stop

Disable firewall from starting at boot

    # chkconfig iptables off

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
