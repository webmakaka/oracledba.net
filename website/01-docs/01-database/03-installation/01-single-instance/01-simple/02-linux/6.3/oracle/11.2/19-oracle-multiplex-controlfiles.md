---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Multiplexing Controlfiles
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Multiplexing Controlfiles
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Multiplexing Controlfiles
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/oracle-multiplex-controlfiles/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Multiplexing Controlfiles

<br/>

    $ mkdir -p /u02/oradata/${ORACLE_SID}/control
    $ mkdir -p /u03/oradata/${ORACLE_SID}/control

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> select name from v$CONTROLFILE;

<br/>

    NAME
	--------------------------------------------------------------------------------
    /u02/oradata/ora112/control01.ctl
    /u02/oradata/ora112/control02.ctl

<br/>

    SQL> shutdown immediate;

<br/>

    SQL> quit

<br/>

    $ cp /u02/oradata/ora112/control01.ctl /u02/oradata/${ORACLE_SID}/control/control01.ctl
    $ cp /u02/oradata/ora112/control01.ctl /u02/oradata/${ORACLE_SID}/control/control02.ctl
    $ cp /u02/oradata/ora112/control01.ctl /u03/oradata/${ORACLE_SID}/control/control03.ctl

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> startup nomount;

<br/>

    SQL> ALTER SYSTEM SET control_files = '/u02/oradata/ora112/control/control01.ctl', '/u02/oradata/ora112/control/control02.ctl', '/u03/oradata/ora112/control/control03.ctl' scope=spfile;

<br/>

    SQL> shutdown immediate;

<br/>

    SQL> startup;

<br/>

    SQL> SELECT name FROM v$CONTROLFILE;

<br/>

    NAME
	--------------------------------------------------------------------------------
    /u02/oradata/ora112/control/control01.ctl
    /u02/oradata/ora112/control/control02.ctl
    /u03/oradata/ora112/control/control03.ctl

<br/>

    SQL> quit

<br/>

Delete old controlfiles

    $ rm /u02/oradata/ora112/control01.ctl
    $ rm /u02/oradata/ora112/control02.ctl

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
