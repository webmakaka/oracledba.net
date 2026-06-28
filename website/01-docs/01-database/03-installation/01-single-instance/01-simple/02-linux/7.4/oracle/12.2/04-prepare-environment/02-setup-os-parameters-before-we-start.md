---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Setting OS Parameters Before Starting
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Setting OS Parameters Before Starting
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Operating System Configuration
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/setup-os-parameters-before-we-start/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Setting OS Parameters Before Starting

<br/>

Some comments on the following command. I create a backup of the /etc/selinux/config file, and change the SELINUX parameter value from enforcing to disabled

    # sed -i.bkp.$(date +%Y-%m-%d) -e "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

<!-- Next, I make a backup and change the timeout value from 5 to 0, so that the operating system does not wait an extra 5 seconds at startup.

    # sed -i.bkp.$(date +%Y-%m-%d) -e "s/timeout=5/timeout=0/g" /boot/grub/grub.conf -->

<!-- Turn off firewall (by default)

    # service iptables stop


Prevent firewall from starting at OS boot

    # chkconfig iptables off -->
