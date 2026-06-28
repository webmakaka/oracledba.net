---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64 - Configuring network interfaces and hosts file
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64 - Configuring network interfaces and hosts file
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, network-interfaces
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/network-interfaces/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Configuring network interfaces and hosts file

<br/>

### Configuration on storage, node1, node2:

<br/>

    # vi /etc/hosts

<br/>

```
###############################################
## Localdomain and Localhost (hosts file, DNS)

127.0.0.1 localhost.localdomain localhost
::1            localhost6.localdomain6 localhost6

###############################################
## Virtual VIP IPs Public Network (hosts file, DNS)

192.168.1.21 node1-vip.localdomain node1-vip
192.168.1.22 node2-vip.localdomain node2-vip

###############################################
## eth0 Public Network (hosts file, DNS)

192.168.1.11 node1.localdomain node1
192.168.1.12 node2.localdomain node2
192.168.1.15 storage.localdomain storage

################################################
## eth1 Interconnect Private Network  (hosts file, DNS)

192.168.2.11 node1-priv
192.168.2.12 node2-priv

#################################################
## eth2 Network to nas Private Network (hosts file, DNS)

192.168.3.11 node1-priv-storage
192.168.3.12 node2-priv-storage

#################################################
## SCAN and GNS (DNS, DHCP)

# empty

#################################################
```

<br/>

    # vi /etc/resolv.conf

<br/>

    search localdomain
    nameserver 192.168.1.1
    nameserver 192.168.1.10
    options attempts: 2
    options timeout: 1

<br/>

### Network configuration node 1 (node1):

    # vi /etc/sysconfig/network

<br/>

    NETWORKING=yes
    NETWORKING_IPV6=no
    HOSTNAME=node1.localdomain

<br/>

**(public)**

    # vi /etc/sysconfig/network-scripts/ifcfg-eth0

<br/>

    DEVICE="eth0"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.1.11
    NETMASK=255.255.255.0
    GATEWAY=192.168.1.1

<br/>

**(private-interconnect)**

    # vi /etc/sysconfig/network-scripts/ifcfg-eth1

<br/>

    DEVICE="eth1"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.2.11
    NETMASK=255.255.255.0

<br/>

**(private-storage)**

    # vi /etc/sysconfig/network-scripts/ifcfg-eth2

<br/>

    DEVICE="eth2"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.3.11
    NETMASK=255.255.255.0

<br/>

### Network configuration node 2 (node2):

    # vi /etc/sysconfig/network

<br/>

    NETWORKING=yes
    NETWORKING_IPV6=no
    HOSTNAME=node2.localdomain

<br/>

**(public)**

    # vi /etc/sysconfig/network-scripts/ifcfg-eth0

<br/>

    DEVICE="eth0"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.1.12
    NETMASK=255.255.255.0
    GATEWAY=192.168.1.1

<br/>

**(private-interconnect)**

    # vi /etc/sysconfig/network-scripts/ifcfg-eth1

<br/>

    DEVICE="eth1"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.2.12
    NETMASK=255.255.255.0

<br/>

**(private-storage)**

    # vi /etc/sysconfig/network-scripts/ifcfg-eth2

<br/>

    DEVICE="eth2"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.3.12
    NETMASK=255.255.255.0

<br/>

Restart network interfaces using the following command:

    # service network restart

<br/>

### Network configuration (storage):

    # vi /etc/sysconfig/network

<br/>

    NETWORKING=yes
    NETWORKING_IPV6=no
    HOSTNAME=storage.localdomain

<br/>

**(public)**

    # vi /etc/sysconfig/network-scripts/ifcfg-eth0

<br/>

    DEVICE="eth0"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.1.15
    NETMASK=255.255.255.0
    GATEWAY=192.168.1.1

<br/>

**(private-storage)**

    # vi /etc/sysconfig/network-scripts/ifcfg-eth1

<br/>

    DEVICE="eth1"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.3.15
    NETMASK=255.255.255.0
