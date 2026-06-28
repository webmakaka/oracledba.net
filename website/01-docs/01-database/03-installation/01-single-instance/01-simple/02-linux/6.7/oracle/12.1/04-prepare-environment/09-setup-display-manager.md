---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring Display Manager
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Configuring Display Manager
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Display Manager
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-display-manager/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Configuring Display Manager

### Preparation and verification

192.168.1.5 - ip address of the computer from which the installation process is managed.<br/>
192.168.1.11 - ip address of the server<br/>

<br/>

## If installing from a Windows machine

Install XMing and additional fonts. :<br/>
http://sourceforge.net/projects/xming/<br/>
http://sourceforge.net/projects/xming/files/Xming-fonts/

Reboot. If you don't reboot, during installation of version 10 RAC, problems occurred (buttons were not displayed on the last installation step).

Next, configure access rules.<br/>
In the simplest case, right-click on the xming shortcut. Go to properties and add -ac to the target (i.e., no access control)

<br/>

<div align="center">
    <img src="https://img.oracledba.net/img/oracle/database/simple/12.1/XMing.png" border="0" alt="XMing">
</div>

<br/>

<br/>

## If installing from a Linux machine

### On the client:

    $ sudo apt-get install -y gdm

<br/>

<div align="center">
    <img src="https://img.oracledba.net/img/oracle/database/simple/11.2/gdm.png" border="0" alt="Oracle installation">
</div>

<br/>
<br/>

I think it's better to choose lightdm (gdm last time didn't want to work for me). More precisely, I configured gdm as described here, then spent god knows how much time troubleshooting and then decided to try lightdm. After reboot, the service started listening on port 6000).

<br/>

If needed, you can switch later with commands:

<br/>

    # dpkg-reconfigure gdm
    # dpkg-reconfigure lightdm

<br/>

### If lightdm is chosen

    # vi /etc/lightdm/lightdm.conf

<br/>

    ###########################

    [SeatDefaults]
    user-session=ubuntu
    greeter-session=unity-greeter
    xserver-allow-tcp=true

    ###########################

<br/>

### If gdm is chosen

    # vi /etc/gdm/custom.conf

<br/>

Add to the blocks:

    [security]
    DisallowTCP=false

    [xdmcp]
    Enable=true

<!-- <br/>

	###########################
	[xdmcp]
    Enable=true

	[chooser]

	[security]
	DisallowTCP=false

	[debug]
	########################### -->

<!--
<br/>

Perhaps it's enough to restart services with commands:

    # service gdm status

    # service gdm restart (or even # service gdm3 restart)

<br/>

If lightdm is chosen

    # service gdm lightgdm

If that doesn't help, then: -->

<br/>

    # sudo restart lightdm

or

    # service gdm restart

<br/>

### Verification commands

    $ ps ax | grep dm
    $ ps lf -C Xorg

There should be a line "listen tcp"

<br/>

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

    $ xhost +192.168.1.11

<br/>

## On the server:

You can check the operation by installing xterm or xclock

<br/>

-- if not installed earlier, install the xdpyinfo package. It is needed for displaying windows on the client machine.

<br/>

    # yum install -y xdpyinfo

<br/>

    # yum install -y xclock

<br/>

    $ export DISPLAY=192.168.1.5:0.0

<br/>

    $ xclock

-- you can even just run the command:

    $ xclock -display 192.168.1.5:0

<br/><br/>

<br/>

<div align="center">
    <img src="https://img.oracledba.net/img/oracle/database/simple/11.2/xclock.png" border="0" alt="Oracle installation">
</div>
