---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - DNS server setup
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - DNS server setup
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/setup-dns-server/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: DNS server setup

<br/>

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>dnsserv</strong></span></td>
</tr>

</table>

<br/>

The DNS server is configured only for the purpose of making RAC work. If you need a properly working DNS server, you should refer to specialized DNS server setup guides.

<br/>

### Installing the DNS server:

If there are no files with Oracle Linux repository descriptions in the /etc/yum.repos.d directory.

    # vi /etc/yum.repos.d/OracleLinuxRepo.repo

<br/>

    [OEL6]
    name=Oracle Enterprise Linux $releasever - $basearch
    baseurl=http://public-yum.oracle.com/repo/OracleLinux/OL6/latest/$basearch/
    gpgkey=http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol6
    gpgcheck=1
    enabled=1

<br/>

    # yum install -y \
    bind \
    bind-utils

<br/>

### Configuring DNS server configuration files:

    # vi /etc/named.conf

<br/>

    options
    {
        directory "/var/named";
    };


    // ## Localdomain with domain prefix

            zone "localdomain" IN  {
                     type master;
                     file "localdomain.zone";
                     allow-update {none;};
            };


    // ## zone ARPA

            zone "1.168.192.in-addr.arpa" IN  {
                    type master;
                    file "192.168.1.in-addr.arpa";
            };


            zone "2.168.192.in-addr.arpa" IN  {
                    type master;
                    file "192.168.2.in-addr.arpa";
            };


               zone "3.168.192.in-addr.arpa" IN  {
                    type master;
                    file "192.168.3.in-addr.arpa";
            };

<br/>

    # vi /var/named/localdomain.zone

<br/>

    $TTL 86400
    @                   	IN SOA              	ns1.localdomain. root.localhost (
                                                                 	2010063000 ; serial
                                                                 	28800 ; refresh
                                                                 	14400 ; retry
                                                                 	3600000 ; expiry
                                                                 	86400 ) ; minimum
    @                   	IN                  	NS          	ns1.localdomain.
    localhost           	IN                  	A           	127.0.0.1
    ns1                 	IN                  	A           	192.168.1.10

    rac12-scan             	IN                  	A           	192.168.1.31
    rac12-scan             	IN                  	A           	192.168.1.32
    rac12-scan             	IN                  	A           	192.168.1.33


    rac1-vip            	IN                  	A           	192.168.1.21
    rac2-vip            	IN                  	A           	192.168.1.22


    rac1                	IN                  	A           	192.168.1.11
    rac2                	IN                  	A           	192.168.1.12
    storage             	IN                  	A           	192.168.1.15


    rac1-priv-interconnect  IN                  	A           	192.168.2.11
    rac2-priv-interconnect  IN                  	A           	192.168.2.12


    rac1-priv-storage     	IN                  	A           	192.168.3.11
    rac2-priv-storage      	IN                  	A           	192.168.3.12

<br/>

    # vi /var/named/192.168.1.in-addr.arpa

<br/>

    $TTL   	86400
    @      	IN   	SOA   	ns1.localdomain. postmaster.localhost. (
                        	2010063000 ; serial
                        	28800 ; refresh
                        	14400 ; retry
                        	3600000 ; expiry
                        	86400 ) ; minimum
    @      	IN   	NS   	ns1.localdomain.

    31     	IN   	PTR  	rac12-scan.localdomain.
    32     	IN   	PTR  	rac12-scan.localdomain.
    33     	IN   	PTR  	rac12-scan.localdomain.

    21     	IN   	PTR  	rac1-vip.localdomain.
    22     	IN   	PTR  	rac2-vip.localdomain.

    11     	IN   	PTR  	rac1.localdomain.
    12     	IN   	PTR  	rac2.localdomain.
    13     	IN   	PTR  	storage.localdomain.

<br/>

    # vi /var/named/192.168.2.in-addr.arpa

<br/>

    $TTL   	86400
    @      	IN   	SOA   	ns1.localdomain. postmaster.localhost. (
                        	2010063000 ; serial
                        	28800 ; refresh
                        	14400 ; retry
                        	3600000 ; expiry
                        	86400 ) ; minimum
    @      	IN   	NS   	ns1.localdomain.

    11     	IN   	PTR  	rac1-priv-interconnect.localdomain.
    12     	IN   	PTR  	rac2-priv-interconnect.localdomain.

<br/>

    # vi /var/named/192.168.3.in-addr.arpa

<br/>

    $TTL   	86400
    @      	IN   	SOA   	ns1.localdomain. postmaster.localhost. (
                        	2010063000 ; serial
                        	28800 ; refresh
                        	14400 ; retry
                        	3600000 ; expiry
                        	86400 ) ; minimum
    @      	IN   	NS   	ns1.localdomain.

    11     	IN   	PTR  	rac1-priv-storage.localdomain.
    12     	IN   	PTR  	rac2-priv-storage.localdomain.

Add to autostart:

    # chkconfig --level 345 named on

Restart

    # service named restart

Status:

    rndc status

Check on clients:

    nslookup rac1
    nslookup rac2.localdomain
    nslookup 192.168.1.11
