---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring Display Manager
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring Display Manager
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Display Manager
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/setup-display-manager/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Configuring Display Manager

<br/>

### Preparation and verification

192.168.1.5 - ip address of the computer from which the installation process is managed.<br/>
192.168.56.101 - ip address of the server<br/>

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

## If installing from a Linux machine

<br/>

### Preparing Oracle Linux 7.3 client with gnome environment

    # yum install -y nmap nc xclock

<br/>

    # vi /etc/gdm/custom.conf

<br/>

Add to the blocks:

    [security]
    DisallowTCP=false

    [xdmcp]
    Enable=true

<br/>

    # service gdm restart

<br/>

    $ xclock -display 192.168.1.5:0

If the clock appears, everything is fine and nothing else is needed.

<br/>

<div align="center">
    <img src="https://img.oracledba.net/img/oracle/database/simple/11.2/xclock.png" border="0" alt="Oracle installation">
</div>

<br/>

<br/>

### Preparing Ubuntu client

```
$ sudo apt-get install -y nmap nc xclock
```

<div align="center">
<img src="https://img.oracledba.net/img/oracle/database/simple/11.2/gdm.png" border="0" alt="Oracle installation">
</div>

<br/>

Option with lightdm.

If needed, you can switch later with commands:

<br/>

    # dpkg-reconfigure gdm
    # dpkg-reconfigure lightdm

<br/>

    # vi /etc/lightdm/lightdm.conf

<br/>

{% highlight shell %}

###########################

[SeatDefaults]
user-session=ubuntu
greeter-session=unity-greeter
xserver-allow-tcp=true

###########################

{% endhighlight %}

<br/>

    # sudo restart lightdm

<br/>

    $ xclock -display 192.168.1.5:0

If the clock appears, everything is fine and nothing else is needed.

<br/>

<div align="center">
    <img src="https://img.oracledba.net/img/oracle/database/simple/11.2/xclock.png" border="0" alt="Oracle installation">
</div>

<br/>

<br/>

### If the clock does not appear:

    $ ps ax | grep dm
    $ ps lf -C Xorg

There should be no line "no-listen tcp" (Or something similar)

<br/>

    $ netstat -an | grep -F 6000

<br/>

    tcp        0      0 0.0.0.0:6000            0.0.0.0:*               LISTEN
    tcp6       0      0 :::6000                 :::*                    LISTEN

<br/>

    # nmap -p 6000 192.168.1.5

<br/>

    Starting Nmap 6.40 ( http://nmap.org ) at 2017-11-23 09:02 MSK
    Nmap scan report for 10.14.3.43
    Host is up (0.000048s latency).
    PORT     STATE SERVICE
    6000/tcp open  X11

<br/>

    $ nc -vv 192.168.1.5 6000
    Connection to 192.168.1.200 6000 port [tcp/x11] succeeded!=

<br/>

### Allow form output from server to client

Then on the client as root I do:

    # xhost +

<!-- $ xhost +192.168.56.101

<br/> -->

<br/>

## On the server:

Check if the client port is open and accessible

    # yum install -y nmap

<br/>

    # nmap -p 6000 192.168.1.5

result

    ***
    6000/tcp open  X11

<br/>

Next, it's best to do the following:

-- if not installed earlier, install the xdpyinfo package. It is needed for displaying windows on the client machine.

<br/>

    # yum install -y xdpyinfo xclock
    # su - oracle12

<br/>

    $ xclock -display 192.168.1.5:0

<br/>

You can also try

    $ export DISPLAY=192.168.1.5:0.0

<br/>

    $ xdpyinfo
    name of display:    192.168.1.5:0.0
    version number:    11.0
    vendor string:    The X.Org Foundation
    vendor release number:    11702000
    X.Org version: 1.17.2
    maximum request size:  16777212 bytes
    motion buffer size:  256
    bitmap unit, bit order, padding:    32, LSBFi
    *****
