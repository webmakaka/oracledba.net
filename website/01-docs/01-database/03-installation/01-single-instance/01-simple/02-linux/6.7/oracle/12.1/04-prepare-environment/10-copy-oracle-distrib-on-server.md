---
layout: page
title: Oracle DataBase 12c - Linux - Copy oracle distributives on server
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/copy-oracle-distrib-on-server/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Copy oracle distributives on server folder

Copy oracle distributives on server to /tmp/oracle/12.1/ folder.

You could do it with connection by sftp protocol in Linux or use winscp from windows.

in Linux you could copy distrib with next command:

    # scp marley@192.168.1.5:/oracle/linuxamd64_12c_database_*.zip /tmp/oracle/12.1/

To setup right permissions:

    # chown -R oracle12:oinstall /tmp/oracle/12.1/linuxamd64_12c_database_*.zip

<br/>

### Login on server as user oracle12.

    # su - oracle12
    $ cd /tmp/oracle/12.1/

And extract archives:

    $ unzip linuxamd64_12c_database_1of2.zip; \
    unzip linuxamd64_12c_database_2of2.zip
