---
layout: page
title: Oracle DataBase 12c - Linux - Setup OS parameters before we start
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-os-parameters-before-we-start/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Setup OS parameters before we start


Changing SELINUX parameters from enforcing to disabled


    # sed -i.bkp.$(date +%Y-%m-%d) -e "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config


Decrease delay after restart server. Server will not wait answer on question about kernel for starting and etc...


    # sed -i.bkp.$(date +%Y-%m-%d) -e "s/timeout=5/timeout=0/g" /boot/grub/grub.conf


Disable firewall

    # service iptables stop


Not allow to restart firewall service after restart server

    # chkconfig iptables off
