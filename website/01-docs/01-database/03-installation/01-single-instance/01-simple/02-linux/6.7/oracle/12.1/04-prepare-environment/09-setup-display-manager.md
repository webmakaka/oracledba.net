---
layout: page
title: Oracle DataBase 12c - Linux - Setup Display Manger
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-display-manager/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Setup Display Manger



192.168.1.5 -  ip address of my desktop<br/>
192.168.1.11 - ip address of server<br/>


<br/>

# If you install Oracle from Windows machine


Install XMing and additional fonts:<br/>
http://sourceforge.net/projects/xming/<br/>
http://sourceforge.net/projects/xming/files/Xming-fonts/

I strongly recommend to reboop computer. Without reboot there was a problem from some oracle installation forms (At least when i installed RAC 10).

Next we should setup connection rights.<br/>

Simplest way to do it is - right click on xming shortcut. In properties in target field add -ac (without access control)


<img src="https://img.oracledba.net/img/oracle/database/simple/12.1/XMing.png" border="0" alt="XMing">



<br/>

# If you install Oracle from Linux machine

### On Client:

	$ sudo apt-get install -y gdm


<br/><img src="https://img.oracledba.net/img/oracle/database/simple/11.2/gdm.png" border="0" alt="Oracle installation"><br/>


### If chosen gdm

	# vi /etc/gdm/custom.conf

<br/>

	###########################
	[xdmcp]

	[chooser]

	[security]
	DisallowTCP=false

	[debug]
	###########################



### If chosen lightgdm


	# vi /etc/lightdm/lightdm.conf

<br/>

	###########################

	[SeatDefaults]
	user-session=ubuntu
	greeter-session=unity-greeter
	xserver-allow-tcp=true

	###########################

<br/>

	# reboot

<br/>

### Commands for checks


	$ sudo apt-get install -y nmap nc

<br/>

	$ netstat -an | grep -F 6000

<br/>

	tcp        0      0 0.0.0.0:6000            0.0.0.0:*               LISTEN
	tcp6       0      0 :::6000                 :::*                    LISTEN


<br/>

	# nmap -p 6000 192.168.1.5

<br/>

	Starting Nmap 5.21 ( http://nmap.org ) at 2013-08-18 04:13 MSK
	Nmap scan report for 192.168.1.5
	Host is up (0.000044s latency).
	PORT     STATE SERVICE
	6000/tcp open  X11


<br/>

	$ nc -vv 192.168.1.5 6000
	Connection to 192.168.1.200 6000 port [tcp/x11] succeeded!=


<br/>

	$ xhost +192.168.1.10




<br/>

## On Server:

To check you could install xterm or xclock

<br/>


If you don't install earlier package xdpyinfo, do it. It needs to show oracle forms on remote host.


	# yum install -y xdpyinfo

<br/>

	# yum install -y xclock

<br/>

	$ export DISPLAY=192.168.1.5:0.0

<br/>

	$ xclock

Or you may execute next command:

	$ xclock -display 192.168.1.5:0

<br/><br/>

<br/><img src="https://img.oracledba.net/img/oracle/database/simple/11.2/xclock.png" border="0" alt="Oracle installation">
