---
layout: page
title: Oracle DataBase 12c - Linux - Restrict remote access by user root
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-restrict-root-access/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Restrict remote access by user root


	# vi /etc/ssh/sshd_config

Replace


	#PermitRootLogin yes

on

	PermitRootLogin no


<br/>

	# service sshd restart
