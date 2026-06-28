---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Copying Distributions to the Server
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Copying Distributions to the Server
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Copying Distributions to the Server
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/copy-oracle-distrib-on-server/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Copying database distributions to the server (to /tmp directory)

Log in as the user who will perform the database installation.

    # su - oracle12

Copy the distributions to the temporary directory /tmp/oracle/12.1/

    $ cd /tmp/oracle/12.1/

<br/>

    $ ls
    linuxamd64_12102_database_1of2.zip  linuxamd64_12102_database_2of2.zip

Unzip the Database

    $ unzip linuxamd64_12102_database_1of2.zip; unzip linuxamd64_12102_database_2of2.zip

<br/>

### OFFTOPIC

The simplest way to copy files in Linux is to connect to the server using sftp://192.168.1.11

You can also use the scp utility. For example, the following command can fetch database distributions from another Linux server and place them in the /tmp/oracle/12.1/ directory:

    # scp marley@192.168.1.5:/oracle/linuxamd64_12c_database_*.zip /tmp/oracle/12.1/

<br/>

If you are working on Windows, the simplest way is to use winscp.

If you need to set the owner of the downloaded archives to the oracle12 user

    # chown -R oracle12:oinstall /tmp/linuxamd64_12c_database_*.zip
