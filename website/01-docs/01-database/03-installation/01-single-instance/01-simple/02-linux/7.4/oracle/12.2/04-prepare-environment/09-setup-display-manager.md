---
layout: page
title: Oracle DataBase 12.2 - Oracle Linux 7.4 - Настройка Display Manger
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/setup-display-manager/
---


<br/>

<div style="padding:10px; border:thin solid black;">

	<h3>Этот материал в разработке. Рекомендую обратиться к последней версии документа.</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Ссылка на документ по инсталляции Oracle.</a>

</div>

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Инсталляция Oracle DataBase Server 12.2 в Oracle Linux 7.4]</a>:: Настройка Display Manger

<br/>

### Подготовка и проверка

192.168.1.5 -  ip адрес компьютера, с которого происходит процесс управления установкой.<br/>
192.168.56.101 - ip адрес сервера<br/>



<br/>

## Если установка происходит с Windows машины

Устанавливаем XMing и доп шрифты. :<br/>
http://sourceforge.net/projects/xming/<br/>
http://sourceforge.net/projects/xming/files/Xming-fonts/

Перезагружаемся. Если не перезагрузить, при инсталляции в 10 версии RAC, возникали проблемы (кнопка не отображались на последнем шаге инсталляции).

Далее, необходимо настроить правила доступа.<br/>
В самом простом варианте, правой кнопкой мыши по ярлыку xming. Зайти в свойства и в target дописать -ac (т.е. без контроля доступа)

<br/>

<div align="center">
    <img src="https://img.oracledba.net/img/oracle/database/simple/12.1/XMing.png" border="0" alt="XMing">
</div>



<br/>


<br/>

## Если установка происходит с Linux машины


### На клиенте:

	$ sudo apt-get install -y gdm


<div align="center">
    <img src="https://img.oracledba.net/img/oracle/database/simple/11.2/gdm.png" border="0" alt="Oracle installation">
</div>


<br/>

Думаю, лучше выбрать lightdm  (gdm в последний раз у меня не захотел рабоать). Точнее, я настроил gdm также как описано здесь, далее копался хрен знает сколько времени и потом решил попробоваь lightdm. После перезагрузки service стал слушать порт 6000).

<br/>

Если что, можно потом переключиться командами:

<br/>

    # dpkg-reconfigure gdm
    # dpkg-reconfigure lightdm

<br/>

### Если выбран gdm

	# vi /etc/gdm/custom.conf

<br/>

Добавляю в блоки:

    [security]
    DisallowTCP=false

    [xdmcp]
    Enable=true

<br/>

### Если выбран lightgdm


	# vi /etc/lightdm/lightdm.conf

<br/>

	###########################

	[SeatDefaults]
	user-session=ubuntu
	greeter-session=unity-greeter
	xserver-allow-tcp=true

	###########################


<!--
<br/>

Возможно, что достаточно перестартовать сервисы командами:

    # service gdm status

    # service gdm restart (или уже даже # service gdm3 restart)

<br/>

Если выбран lightdm

    # service gdm lightgdm

Если не поможет, то: -->

<br/>

    # sudo restart lightdm


или

    # service gdm restart

<br/>

### Команды проверки

    $ ps ax | grep dm
    $ ps lf -C Xorg


Должна быть строчка "listen tcp"


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

    Starting Nmap 6.40 ( http://nmap.org ) at 2017-08-02 13:25 MSK
    Nmap scan report for marley.corp.local (10.14.3.105)
    Host is up (0.000047s latency).
    PORT     STATE  SERVICE
    6000/tcp closed X11

<br/>

<!--
    $ sudo ufw disable

<br/>

	Starting Nmap 5.21 ( http://nmap.org ) at 2013-08-18 04:13 MSK
	Nmap scan report for 192.168.1.5
	Host is up (0.000044s latency).
	PORT     STATE SERVICE
	6000/tcp open  X11 -->


<br/>

	$ nc -vv 192.168.1.5 6000
	Connection to 192.168.1.200 6000 port [tcp/x11] succeeded!=


<br/>

	$ xhost +192.168.1.11


<br/>

## На сервере:


Почему бы и не проверить на сервере, открыт ли порт

    # yum install -y nmap

<br/>

	# nmap -p 6000 192.168.1.5

<br/>

Далее лучше всего сделать следующее:

-- если не установили ранее, установите пакет xdpyinfo. Он нужен для отображения окон на клиентской машине.

<br/>

	# yum install -y xdpyinfo
    # su - oracle12

<br/>

	$ export DISPLAY=192.168.1.5:0.0

<br/>

    $ xdpyinfo


<br/>

Можно также установив xterm или xclock


<br/>

	# yum install -y xclock


<br/>

	$ xclock

-- можно даже проще, просто выполните команду:

	$ xclock -display 192.168.1.5:0

<br/><br/>

<br/>

<div align="center">
    <img src="https://img.oracledba.net/img/oracle/database/simple/11.2/xclock.png" border="0" alt="Oracle installation">
</div>

<br/>

### Если часы не появились, можно попробовать следующее:


Выполнил команду на сервере:

    $ xdpyinfo
    No protocol specified
    xdpyinfo:  unable to open display "<ip клиента ubuntu :0.0".


<br/>

Потом на клиенте под root сделал:

    # xhost +

<br/>

И снова на сервере:

    $ xdpyinfo

С выводом каких-то сообщений, но сообщения об ошибке уже не было.


При запуске  ./runInstaller окно с приглашением появилось.

А вот часы так и не появились у меня.
