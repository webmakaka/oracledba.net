---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Setting OS Parameters Before Starting
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Setting OS Parameters Before Starting
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Setting OS Parameters Before Starting
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-os-parameters-before-we-start/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Setting OS Parameters Before Starting

Some comments on the following command. I create a backup of the /etc/selinux/config file, and change the SELINUX parameter value from enforcing to disabled

    # sed -i.bkp.$(date +%Y-%m-%d) -e "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

Next, I make a backup and change the timeout value from 5 to 0, so that the operating system does not wait an extra 5 seconds at startup.

    # sed -i.bkp.$(date +%Y-%m-%d) -e "s/timeout=5/timeout=0/g" /boot/grub/grub.conf

Turn off firewall

    # service iptables stop

Prevent firewall from starting at OS boot

    # chkconfig iptables off
