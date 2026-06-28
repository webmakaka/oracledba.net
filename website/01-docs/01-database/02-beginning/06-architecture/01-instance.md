---
layout: page
title: Oracle Database Instance
description: Oracle Database Instance
keywords: Oracle Database, Instance
permalink: /docs/architecture/instance/
---

# Oracle Database Instance

<br/>

When you install an Oracle database. You first install the DBMS software (Database Management System). In addition to the DBMS, the database itself is also needed. One database management system can work with several databases simultaneously on one server. Each such database in Oracle terminology is called a database instance. Each running instance actively uses processor, RAM, and disk resources.

Next, we will gradually analyze what is stored on disks (main files), which processes are responsible for what, and what is actually stored in RAM.

<strong>Oracle Database = Oracle DataBase Software + Oracle DataBase Instance (s)</strong>

<br/>

<div align="center">
<img src="https://img.oracledba.net/architecture/OracleDatabaseFiles.jpg" border="0" alt="Oracle Instance"><br/>
</div>

<br/>

To find out the current state of the database instance,
you can perform the following procedure:

<br/>
<br/>

1.  make sure you are connecting to the database with the correct ORACLE_SID parameter.<br/>
    You can change the SID with the <strong>export</strong> command

        $ export ORACLE_SID=ora112

<br/>

    $ echo $ORACLE_SID
    ora112

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> select status from v$instance;

<br/>

    STATUS
    ------------
    OPEN

<br/><br/>

In this case, everything is fine.
