---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Configuring Network Interfaces
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Configuring Network Interfaces
keywords: database, installation, Oracle DataBase 11.2, Oracle Linux 6.3, Configuring Network Interfaces
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/network-interface/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Configuring Network Interfaces

It is necessary to choose a suitable name for the server that reflects its role and purpose on the network.

To do this, use an editor (e.g., vi) to edit the /etc/sysconfig/network file

Set the parameters according to the characteristics of your network.

It is not recommended to use underscores (\_) in the hostname. (Enterprise Manager and other web applications will not be able to connect to the database via http/https)

<br/>

    # vi /etc/sysconfig/network

<br/>

    NETWORKING=yes
    NETWORKING_IPV6=no
    HOSTNAME=oracle112.localdomain

<br/>

    # vi /etc/sysconfig/network-scripts/ifcfg-eth0

<br/>

    DEVICE="eth0"
    ONBOOT="yes"
    BOOTPROTO="static"
    IPADDR=192.168.1.10
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

```
## Localdomain and Localhost (hosts file, DNS)
127.0.0.1 localhost.localdomain localhost
::1            localhost6.localdomain6 localhost6

## IPs Public Network (hosts file, DNS)
192.168.1.10 oracle112.localdomain oracle112
```

<br/>

Network interfaces can be restarted with the following command:

<br/>

    # service network restart

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
