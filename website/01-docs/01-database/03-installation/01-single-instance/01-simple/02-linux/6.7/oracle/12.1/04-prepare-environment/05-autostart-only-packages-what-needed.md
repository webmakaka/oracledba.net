---
layout: page
title: Oracle DataBase 12c - Linux - Autostart only packages what nedeed
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/autostart-only-packages-what-needed/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Autostart only packages what nedeed



Next command will disable autostart all packages.


	# for i in $(chkconfig --list | grep '3:on\|4:on\|5:on' | awk {'print $1'}); do chkconfig --level 345 $i off; done


Check what packages will start after reboot automatically

	# chkconfig --list | grep '3:on\|4:on\|5:on'  |awk '{print $1}' | sort


After that, we will start only packages what we really needs:

	# {
	chkconfig --level 345 network on
	chkconfig --level 345 sshd on
	chkconfig --level 345 ntpd on
	}

<br/>

	# {
	chkconfig --level 345 auditd on
	chkconfig --level 345 messagebus on
	chkconfig --level 345 netfs on
	chkconfig --level 345 sysstat on
	chkconfig --level 345 crond on
	chkconfig --level 345 xinetd on
	}


Later we will add:

	# chkconfig --level 345 startupOracleDatabase12R1 on

Check what ssh package will run after reboot

	# chkconfig --list | grep ssh

Try to reboot server to check what all correct.

	# reboot
