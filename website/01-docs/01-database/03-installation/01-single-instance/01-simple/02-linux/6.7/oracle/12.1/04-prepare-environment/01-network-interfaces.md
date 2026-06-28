---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring Network Interfaces
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring Network Interfaces
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Configuring Network Interfaces
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/network-interfaces/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Configuring Network Interfaces

### Configure network interfaces and network service parameters.

<br/>

    # vi /etc/sysconfig/network-scripts/ifcfg-eth0

<br/>

    DEVICE="eth0"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.1.11
    NETMASK=255.255.255.0
    GATEWAY=192.168.1.1

<br/><br/>
If you connected to the server via RDP, I would recommend restarting the network service after entering the network interface settings and connecting to the server via ssh. Then execute further commands using copy + paste.

<br/>

Restart the service responsible for network interface parameters using the command:

    # service network restart

<br/>
Connect to the server with the command
<br/>

    $ ssh root@192.168.1.11

<br/>

### Continue configuring network environment parameters

You need to choose a suitable name for the server that reflects its role and purpose on the network.

To do this, use an editor (e.g., vi) to edit the file /etc/sysconfig/network

<br/><br/>

It is not recommended to use underscore (\_) in hostname. (Enterprise Manager and other web applications will not be able to connect to the database via http/https)

    # vi /etc/sysconfig/network

<br/>

    NETWORKING=yes
    NETWORKING_IPV6=no
    HOSTNAME=oracle12serv.localdomain

<br/>

    # vi /etc/resolv.conf

<br/>

    nameserver 192.168.1.1

<br/>

    # vi /etc/hosts

<br/>

    ## Localdomain and Localhost (hosts file, DNS)
    127.0.0.1 localhost.localdomain localhost

    ## IPs Public Network (hosts file, DNS)
    192.168.1.11 oracle12serv.localdomain oracle12serv

Check if everything works correctly.

    # ping google.com
