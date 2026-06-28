---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Updating the Database with Oracle Recommended Patches
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Updating the Database with Oracle Recommended Patches
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Patches, Update
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-psu-update/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Updating the Database with Oracle Recommended Patches

<pre>

If you have an active contract for access to support.oracle.com, you can download the latest updates for Oracle products and, if necessary, make a request to technical support, including for custom patches. This was especially relevant during the period when time zones changed due to the President's decree.

On one of the tabs, Oracle shows which patches it recommends applying.

</pre>

<br/><br/>

<img src="https://img.oracledba.net/img/oracle/database/simple/11.2/OraclePatches_01.PNG" border="0" alt="Oracle Patches"><br/><br/>
<img src="https://img.oracledba.net/img/oracle/database/simple/11.2/OraclePatches_02.PNG" border="0" alt="Oracle Patches"><br/><br/>
<img src="https://img.oracledba.net/img/oracle/database/simple/11.2/OraclePatches_03.PNG" border="0" alt="Oracle Patches"><br/><br/>
<img src="https://img.oracledba.net/img/oracle/database/simple/11.2/OraclePatches_04.PNG" border="0" alt="Oracle Patches"><br/><br/>

<br/><br/>

<pre>

Before applying, it is recommended to update the patch update system itself, which is called OPatch.
OPatch itself has an internal code 6880880 and is available for download:

https://updates.oracle.com/ARULink/PatchDetails/process_form?patch_num=6880880
</pre>

<br/><br/>

<img src="https://img.oracledba.net/img/oracle/database/simple/11.2/OraclePatches_05.PNG" border="0" alt="Oracle Patches"><br/><br/>
<img src="https://img.oracledba.net/img/oracle/database/simple/11.2/OraclePatches_06.PNG" border="0" alt="Oracle Patches"><br/><br/>

<br/><br/>

### Updating OPatch

    $ rm -rf /u01/oracle/database/11.2/OPatch/
    $ unzip p6880880_112000_Linux-x86-64.zip
    $ mv OPatch/ /u01/oracle/database/11.2
    $ cd /u01/oracle/database/11.2/OPatch

<br/>

    $ ./opatch version

<br/>

    OPatch Version: 11.2.0.3.0
    OPatch succeeded.

### 2) Applying Patch 1

    $ sqlplus / as sysdba
    SQL> shutdown immediate;
    SQL> quit

<br/>

    $ cd /tmp

<br/>

    $ export PATH=$PATH:/u01/oracle/database/11.2/OPatch
    $ unzip p13632717_112030_Linux-x86-64.zip
    $ cd 13632717/
    $ opatch napply -skip_subset -skip_duplicate

<br/>

    ....
    OPatch succeeded.

<br/>

    cd $ORACLE_HOME/rdbms/admin
    $ sqlplus / as sysdba

<br/>

    SQL> startup
    SQL> @catbundle.sql cpu apply
    SQL> QUIT

<br/>

### 3) Applying Patch 2

    $ sqlplus / as sysdba
    SQL> shutdown immediate;
    SQL> quit

<br/>

    $ cd /tmp

<br/>

    $ unzip p13696216_112030_Linux-x86-64.zip
    $ cd 13696216
    $ opatch prereq CheckConflictAgainstOHWithDetail -ph ./

<br/>

    $ opatch apply

<br/>

    ***
    OPatch completed with warnings.

<br/>

    $ cd $ORACLE_HOME/rdbms/admin
    $ sqlplus / as sysdba
    SQL> startup
    SQL> @catbundle.sql psu apply
    SQL> QUIT

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
