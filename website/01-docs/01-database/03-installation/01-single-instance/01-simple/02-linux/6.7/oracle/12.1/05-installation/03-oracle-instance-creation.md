---
layout: page
title: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Creating a Database Instance
description: Oracle DataBase 12c Installation on Oracle Linux 6.7 - Creating a Database Instance
keywords: Oracle DataBase 12c, Oracle Linux 6.7, Instance
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-instance-creation/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 Installation on Oracle Linux 6.7]</a>: Creating a Database Instance

Run the command:

    $ dbca

<br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_01.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_02.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_03.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_04.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<pre>

Oracle offers to create a database instance based on one of the prepared templates.

1. Online Transaction Processing (OLTP) - when you need to optimize data input into the database. Primarily operations for adding and modifying data.
2. General purpose database (custom database) - you are offered to choose system parameters yourself. (the most optimal option).
3. Data warehouse - when you need to optimize work with data in the database. Advantage of read operations and building analytical reports.

If necessary, these parameters can be changed later in pfile or spfile.

</pre>

<br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_05.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_06.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_07.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_08.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_09.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_10.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_11.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<pre>

You are asked to select additional components. If you are not planning to use them, most likely you should not install them.

Oracle Text  - provides word indexing and search
http://docs.oracle.com/cd/B10501_01/text.920/a96517/cdefault.htm

Oracle OLAP - multidimensional data analysis for analytical applications.
http://www.oracle.com/technetwork/documentation/olap-101824.html

Oracle Spatial -  for Geographic Information System (GIS) (Probably something like google maps)
http://docs.oracle.com/html/A88805_01/sdo_intr.htm

Oracle Multimedia - needed if you plan to store images, audio, video in the database.
http://docs.oracle.com/cd/E11882_01/appdev.112/e10777/ch_intr.htm#i610845

Oracle JVM - needed if you need to call programs (procedures, functions, etc.) written in java directly inside the database.

Application Express - an application that allows you to easily create applications working with the database using wizards. Makes sense to keep only if you plan to work with it.

</pre>

<br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_12.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_13.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<pre>

If you are not planning to create another database instance on the server, it makes sense to allocate more memory to the server (> 90%).

You can also set the system parameters of the database being created yourself.

</pre>

<br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_14.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_15.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<pre>
If the database will use Cyrillic, it is recommended to choose an encoding that supports this feature. Unicode, where each character is encoded with 2 bytes, is quite suitable for this task.

</pre>

<br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_16.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<ul>
	<li>Dedicated Server Mode - a separate service is created for each connection. </li>
	<li>Shared Server Mode - a connection pool is created, and all clients connect to the database through this pool. Makes sense to use only in case of insufficient server resources to create dedicated services.</li>
</ul>

<br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_17.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_18.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_19.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_20.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

At this step, the installation progress seems to stop and nothing happens for some time. You need to wait.
<br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_21.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

Enterprise Manager did not start under Firefox for me. However, mine is overloaded with various plugins that block active site components.
<br/><br/>

<br/><br/>

https://192.168.1.11:5500/em

<br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_22.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_24.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_25.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<img src="https://img.oracledba.net/01-database/02-installation/01-single-instance/01-simple/02-linux/6.7/oracle/12.1/04_instance_creation/oracle12R1_database_instance_creation_26.png" border="0" alt="Oracle 12 relese 1 Instance Creation"><br/><br/>

<br/><br/>

    $ sqlplus / as sysdba

    SQL*Plus: Release 12.1.0.2.0 Production on Tue Sep 15 22:14:27 2015

    Copyright (c) 1982, 2014, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
    With the Partitioning, OLAP, Advanced Analytics and Real Application Testing options

<br/>

    SQL> select status from v$instance;

    STATUS
    ------------
    OPEN
