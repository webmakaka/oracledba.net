---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring Network Interfaces
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring Network Interfaces
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Configuring Network Interfaces
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/network-interfaces/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Configuring Network Interfaces

<br/>

### Configure network interfaces and network service parameters.

<br/>

    # cd /etc/sysconfig/network-scripts/
    # cp ifcfg-enp0s3 ifcfg-enp0s3.orig
    # cp ifcfg-enp0s8 ifcfg-enp0s8.orig

in

    # vi ifcfg-enp0s3
    # vi ifcfg-enp0s8

<br/>

In the last line I replaced

ONBOOT=no

with

ONBOOT="yes"

And restarted the network service

    # service network restart

<br/>

    # ping ya.ru (OK)

<br/>

No network utilities. Installing.

    # yum install -y net-tools

<br/>

    # ifconfig enp0s3
    returns that my IP is 192.168.56.101

<br/>

Now I connect to the server via SSH and work with it remotely:

    $ ssh root@192.168.56.101

<br/>

### Continue configuring network environment parameters

You need to choose a suitable name for the server that reflects its role and purpose on the network.

    # hostnamectl set-hostname oracle12serv.localdomain

Check:

    # hostnamectl

<br/>

    # vi /etc/hosts

<br/>

Add:

    ## IPs Public Network (hosts file, DNS)
    192.168.56.101 oracle12serv.localdomain oracle12serv

<br/>

### Allow connections to ports

    # firewall-cmd --permanent --add-port=1521/tcp
    # firewall-cmd --permanent --add-port=5500/tcp
    # firewall-cmd --reload
