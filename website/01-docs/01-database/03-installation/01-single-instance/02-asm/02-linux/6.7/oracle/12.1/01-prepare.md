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



 Устанавливаю значение hostname для сервера

    # vi /etc/sysconfig/network

<br/>

    NETWORKING=yes
    HOSTNAME=moscow.localdomain


**После переименования, лучше перезагрузить сервер или каким-то способом применить изменения, или иначе в конфигах будет прописано что-то не то и придется их потом еще и править**
