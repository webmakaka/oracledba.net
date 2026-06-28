---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Installing Oracle DBMS (DataBase Software)
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Installing Oracle DBMS (DataBase Software)
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Installing DataBase Software
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/oracle-database-software-installation/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Installing Oracle DBMS (DataBase Software)

<br/>

### Pre-installation configuration check:

If the DISPLAY variable is not set.

    $ export DISPLAY=192.168.1.5:0.0

<br/>

    $ cd /distrib/oracle/12.2/database/

<br/>

    $ ./runInstaller -executeSysPrereqs

<br/>

    Starting Oracle Universal Installer...

    Checking Temp space: must be greater than 500 MB.   Actual 26663 MB    Passed
    Checking swap space: must be greater than 150 MB.   Actual 3967 MB    Passed
    Checking monitor: must be configured to display at least 256 colors.    Actual 16777216    Passed
    Exiting Oracle Universal Installer, log for this session can be found at /tmp/OraInstall2015-09-15_09-20-12PM/installActions2015-09-15_09-20-12PM.log

<br/>

### Starting the database installation program:

<br/>

    $ ./runInstaller

In some cases, you have to run the installation ignoring system messages

    $ ./runInstaller -ignoreSysPrereqs

<br/><br/>
If everything is normal, the picture will appear:

<br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_01.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_02.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_03.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_04.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_05.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_06.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_07.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_08.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_09.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_10.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_11.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

<br/><br/>

After the following window appears, you must run the following scripts as root. It is recommended to connect to the database server with another session and run the commands there.

<br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_12.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>

    # /u01/oraInventory/orainstRoot.sh
    # /u01/oracle/database/12.2/root.sh

<br/><br/>

<img src="//img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/7.4/oracle/12.2/02-database-software-installation/database-software-installation_13.png" border="0" alt="Oracle DataBase 12.2 SoftWare installation"><br/><br/>
