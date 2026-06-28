---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Copying Database Distributions to the Server
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Copying Database Distributions to the Server
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Copying Distributions
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/copy-oracle-distrib-on-server/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Copying database distributions to the server (to /tmp directory)

<br/>

Log in as the user who will perform the database installation.

    # su - oracle12

Copy the distributions to the temporary directory /distrib/oracle/12.2/

    $ cd /distrib/oracle/12.2/

<br/>

### OFFTOPIC

The simplest way to copy files in Linux is to connect to the server using sftp
Press Windows + L and in the header enter: sftp://192.168.56.101

You can also use the scp utility. For example, the following command can fetch database distributions from another Linux server and place them in the /tmp/oracle/12.2/ directory:

    # scp marley@192.168.1.5:/oracle/linuxx64_12201_database.zip /tmp/oracle/12.2/

<br/>

If you are working on Windows, the simplest way is to use winscp.

<br/>

If you need to set the owner of the downloaded archives to the oracle12 user

    # chown -R oracle12:oinstall /tmp/linuxamd64_12c_database_*.zip

### OFFTOPIC END

<br/>

    $ ls
    linuxx64_12201_database.zip

Unzip the Database

    $ unzip linuxx64_12201_database.zip

Delete the archive

    $ rm linuxx64_12201_database.zip
