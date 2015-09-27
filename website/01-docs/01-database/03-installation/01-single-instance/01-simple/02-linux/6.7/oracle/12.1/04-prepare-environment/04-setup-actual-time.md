---
layout: page
title: Oracle DataBase 12c - Linux - Setup actual time
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-actual-time/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Setup actual time




In the file you should setup right ntp server


	# vi /etc/ntp.conf


For example:

server 0.rhel.pool.ntp.org<br/>
server 1.rhel.pool.ntp.org<br/>
server 2.rhel.pool.ntp.org<br/>


<br/><br/>

An additional

	# vi /etc/sysconfig/ntpd


replace

	# Drop root to id 'ntp:ntp' by default.
	OPTIONS="-u ntp:ntp -p /var/run/ntpd.pid"


on

	# Drop root to id 'ntp:ntp' by default.
	# OPTIONS="-u ntp:ntp -p /var/run/ntpd.pid"
	OPTIONS="-x -u ntp:ntp -p /var/run/ntpd.pid"



<br/>

	# service ntpd restart
