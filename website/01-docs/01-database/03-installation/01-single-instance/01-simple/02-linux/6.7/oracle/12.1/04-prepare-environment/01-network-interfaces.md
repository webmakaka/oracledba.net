---
layout: page
title: Oracle DataBase 12c - Linux - Setup network interfaces
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/network-interfaces/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Setup network interfaces



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

If you connect to server by RDP, i recommend to restart network service and connect to server by ssh.


    # service network restart



<br/>
Connect to server:
<br/>

    $ ssh root@192.168.1.11


<br/><br/>
<h3>Setup network parameters for server</h3>
<br/>


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



Check results:

    # ping google.com
