---
layout: page
title: Oracle DataBase 12c - Linux - Oracle DataBase SoftWare Installation
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-database-software-installation/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Oracle DataBase SoftWare Installation


### Check environment berfore installation:


<br/>

	$ cd /tmp/database


<br/>

	$ export DISPLAY=192.168.1.5:0.0


<br/>

	$ ./runInstaller -executeSysPrereqs


<br/>


	Starting Oracle Universal Installer...

	Checking Temp space: must be greater than 500 MB.   Actual 27124 MB    Passed
	Checking swap space: must be greater than 150 MB.   Actual 3967 MB    Passed
	Checking monitor: must be configured to display at least 256 colors.    Actual 16777216    Passed
	Exiting Oracle Universal Installer, log for this session can be found at /tmp/OraInstall2013-09-06_03-31-58AM/installActions2013-09-06_03-31-58AM.log


### Start installation process:

	$ ./runInstaller


To ignore system errors, you could try to run installer with next option. But i don't recommend do it.

	$ ./runInstaller -ignoreSysPrereqs


<br/><br/>
If all correct, you will see:

<br/>


<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_01.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_02.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_03.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_04.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_05.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_06.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_07.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_08.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_09.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_10.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_11.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_12.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_13.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>


<br/><br/>

After you will see next window, you should execute with root permissions next scripts. For do it create new ssh session to the server. On all question press [Enter]

<br/><br/>


<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_14.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>



	# /u01/oraInventory/orainstRoot.sh


<br/>


	Changing permissions of /u01/oraInventory.
	Adding read,write permissions for group.
	Removing read,write,execute permissions for world.

	Changing groupname of /u01/oraInventory to oinstall.
	The execution of the script is complete.



	# /u01/oracle/database/12.1/root.sh


	Performing root user operation for Oracle 12c

	The following environment variables are set as:
	    ORACLE_OWNER= oracle
	    ORACLE_HOME=  /u01/oracle/database/12.1

	Enter the full pathname of the local bin directory: [/usr/local/bin]:
	   Copying dbhome to /usr/local/bin ...
	   Copying oraenv to /usr/local/bin ...
	   Copying coraenv to /usr/local/bin ...


	Creating /etc/oratab file...
	Entries will be added to the /etc/oratab file as needed by
	Database Configuration Assistant when a database is created
	Finished running generic part of root script.
	Now product-specific root actions will be performed.


<br/><br/>

<img src="http://img.oradba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/02_database_software_installation/oracle12R1_database_software_installation_15.png" border="0" alt="Oracle 12 relese 1 installation on Linux"><br/><br/>
