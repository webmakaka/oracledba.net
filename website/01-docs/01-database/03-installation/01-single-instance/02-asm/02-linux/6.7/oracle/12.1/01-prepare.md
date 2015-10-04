---
layout: page
title: Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID - Setup hostname and hosts
permalink: /database/installation/single/asm/linux/6.7/oracle/12.1/prepare/
---

# <a href="/database/installation/single/asm/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID]</a>: Setup hostname and hosts

<br/>

	# vi /etc/hosts

<br/>

	## Localdomain and Localhost

	127.0.0.1 localhost.localdomain localhost


	## DataBases

	192.168.1.11 moscow.localdomain moscow



Setup hostname for server

    # vi /etc/sysconfig/network

<br/>

    NETWORKING=yes
    HOSTNAME=moscow.localdomain


**After this steps i recommend to reboot server**
