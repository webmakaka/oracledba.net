---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Preliminary settings
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Preliminary settings
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Preliminary settings
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/setup-os-parameters-before-begin/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Preliminary settings

<br/>

The following commands are executed on all virtual machines

Some comments on the following 2 commands - the first creates a backup of /etc/selinux/config, and the second changes the SELINUX parameter value from enforcing to disabled

    # cp /etc/selinux/config /etc/selinux/config.bkp
    # sed -i.gres "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

The following 2 commands - the first creates a backup of the file, changes the timeout value from 5 to 0

    # cp /etc/grub.conf /etc/grub.conf.bkp
    # sed -i.gres "s/timeout=5/timeout=0/g" /etc/grub.conf

Disabling firewall

    # service iptables stop

Prevent firewall from starting at OS boot

    # chkconfig iptables off
