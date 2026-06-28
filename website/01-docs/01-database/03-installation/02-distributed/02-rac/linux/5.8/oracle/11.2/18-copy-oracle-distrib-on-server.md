---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Copying database distributions to the server
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Copying database distributions to the server
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Copying database distributions to the server
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/copy-oracle-distrib-on-server/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Copying database distributions to the server

<br/>

Log in as the user who will perform the database installation.

    # su - oracle11

Copy the Oracle distributions to the temporary directory /tmp/oracle/11.2.0.3

    $ cd /tmp/oracle/11.2.0.3

<br/>

    $  ls
    p10404530_112030_Linux-x86-64_1of7.zip
    p10404530_112030_Linux-x86-64_2of7.zip
    p10404530_112030_Linux-x86-64_3of7.zip

<br/>

    $ unzip p10404530_112030_Linux-x86-64_1of7.zip; unzip p10404530_112030_Linux-x86-64_2of7.zip; unzip p10404530_112030_Linux-x86-64_3of7.zip

<!--

<br/>

	# scp marley@192.168.1.5:/mnt/dsk2/_ISO/oracle/linux/11.2.0.3.0/p10404530_112030_Linux-x86-64_{1..3}of7.zip /tmp/

<br/>

	# chown -R oracle11:oinstall /tmp/p10404530_112030_Linux-x86-64_*

-->
