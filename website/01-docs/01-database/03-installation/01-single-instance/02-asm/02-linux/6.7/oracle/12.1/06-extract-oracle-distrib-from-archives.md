---
layout: page
title: Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID - Copy oracle distributives on server
permalink: /database/installation/single/asm/linux/6.7/oracle/12.1/extract-oracle-distrib-from-archives/
---

# <a href="/database/installation/single/asm/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID]</a>: Copy oracle distributives on server

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

<br/>

    $ ls
    linuxamd64_12102_database_1of2.zip  linuxamd64_12102_grid_1of2.zip
    linuxamd64_12102_database_2of2.zip  linuxamd64_12102_grid_2of2.zip

<br/>

    $ unzip linuxamd64_12102_grid_1of2.zip; unzip linuxamd64_12102_grid_2of2.zip

    $ unzip linuxamd64_12102_database_1of2.zip; unzip linuxamd64_12102_database_2of2.zip
