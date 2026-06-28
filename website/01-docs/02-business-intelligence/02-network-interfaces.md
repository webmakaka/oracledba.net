---
layout: page
title: Oracle Business Intelligence - Network Interface Configuration
description: Oracle Business Intelligence - Network Interface Configuration
keywords: Oracle Business Intelligence, OBIEE, network interfaces
permalink: /business-intelligence/installation/network-interfaces/
---

# Oracle Business Intelligence - Network Interface Configuration

You need to choose a suitable name for the server that reflects its role and purpose on the network.

To do this, edit the /etc/sysconfig/network file using an editor (e.g., vi)

Set the parameters according to your network characteristics.

It is not recommended to use underscores (\_) in the hostname.
(Enterprise Manager and other web applications will not be able to connect to the database via http/https)

<br/>

    # vi /etc/sysconfig/network

<br/>

    NETWORKING=yes
    NETWORKING_IPV6=no
    HOSTNAME=oraclebi.localdomain

<br/>

    # vi /etc/sysconfig/network-scripts/ifcfg-eth0

<br/>

    DEVICE="eth0"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.1.9
    NETMASK=255.255.255.0
    GATEWAY=192.168.1.1

<br/>

    # vi /etc/resolv.conf

<br/>

    nameserver 192.168.1.1
    nameserver 127.0.0.1
    search localdomain

    options attempts: 2
    options timeout: 1

<br/>

    # vi /etc/hosts

<br/>

    ## Localdomain and Localhost (hosts file, DNS)
    127.0.0.1 localhost.localdomain localhost
    ::1            localhost6.localdomain6 localhost6

    ## IPs Public Network (hosts file, DNS)
    192.168.1.9 oraclebi.localdomain oraclebi
    192.168.1.10 oracle112.localdomain oracle112

You can restart the network interfaces with the following command:

    # service network restart
