---
layout: page
title: Oracle DataBase Server 12.1 installation on Windows 2008 Server - Controlfiles multiplexing
permalink: /database/installation/single-instance/simple/windows/2008/oracle/12.1/oracle-multiplex-controlfiles/
---

# <a href="/database/installation/single-instance/simple/windows/2008/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Windows 2008 Server]</a>: Controlfiles multiplexing

<br/>

    CMD> sqlplus / as sysdba

<br/>

    SQL> select name from v$CONTROLFILE;


<br/>

    NAME
    --------------------------------------------------
    E:\APP\ORACLE\ORADATA\ORA121\CONTROL01.CTL
    E:\APP\ORACLE\ORADATA\ORA121\CONTROL02.CTL



<br/>

    SQL> shutdown immediate;

<br/>

    SQL> quit

<br/>

    md e:\app\oracle\oradata\ora121\control
    md f:\app\oracle\oradata\ora121\control



<br/>


    copy e:\app\oracle\oradata\ora121\CONTROL01.CTL e:\app\oracle\oradata\ora121\control\CONTROL01.CTL /y
    copy e:\app\oracle\oradata\ora121\CONTROL01.CTL e:\app\oracle\oradata\ora121\control\CONTROL02.CTL /y
    copy e:\app\oracle\oradata\ora121\CONTROL01.CTL f:\app\oracle\oradata\ora121\control\CONTROL03.CTL /y

<br/>

    sqlplus / as sysdba

<br/>

    SQL> startup nomount;

<br/>

    SQL> ALTER SYSTEM SET control_files = 'e:\app\oracle\oradata\ora121\control\CONTROL01.CTL', 'e:\app\oracle\oradata\ora121\control\CONTROL02.CTL', 'f:\app\oracle\oradata\ora121\control\CONTROL03.CTL' scope=spfile;



<br/>

    SQL> shutdown immediate;

<br/>

    SQL> startup;


<br/>

    SQL> SELECT name FROM v$CONTROLFILE;

<br/>

    NAME
    --------------------------------------------------------------
    E:\APP\ORACLE\ORADATA\ORA121\CONTROL\CONTROL01.CTL
    E:\APP\ORACLE\ORADATA\ORA121\CONTROL\CONTROL02.CTL
    F:\APP\ORACLE\ORADATA\ORA121\CONTROL\CONTROL03.CTL

<br/>

    SQL> quit

Remove old controlfiles:

    del E:\APP\ORACLE\ORADATA\ORA121\CONTROL01.CTL
    del E:\APP\ORACLE\ORADATA\ORA121\CONTROL02.CTL
