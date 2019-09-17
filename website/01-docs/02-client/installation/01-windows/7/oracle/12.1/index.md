---
layout: page
title: Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)
permalink: /client/installation/windows/7/oracle/12.1/
---

# [Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)]


<br/>

In this document we will describe installation process for Oracle Database Client on Windows 7 (64 bit).  

To correct anything, please write mail to:

<div>
	<img src="/img/a3333333mail.gif" alt="Marley" border="0">
</div>


<br/>


Oracle Clietn need for remote connection from desktop to database with programms like SQLPLUS, PL/SQL Developer, TOAD, SQL Navigator and maty other.


Oracle client for Windows you could download from Oracle website.  

For installation we need only
winnt_12102_client32.zip

**With 64 bit client, not works programms like PL/SQL Developer. That is the reason why we will setup 32 bit client**

<br/>

### Prepare environment

Before we need to install additional library. This library needed only when you install 32 bit client.

https://www.microsoft.com/en-gb/download/details.aspx?id=5555


<br/>

**hosts**

Edit file hosts:

C:\WINDOWS\system32\drivers\etc\hosts

    127.0.0.1   	localhost
    192.168.1.11	oracle12.localdomain oracle12


<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/01-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>


<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/02-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>



<br/>

### Oracle Client Installation


<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/03-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/04-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/05-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/06-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/07-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/08-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>


We need only Oracle Call Interface library (OCL). But for convenient i will install next:

<ul>
<li>SQL Plus</li>
<li>Oracle Call Interface (OCI)</li>
<li>Connection Manager</li>
</ul>


<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/09-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/10-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/11-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>


<br/>

### Creating from master tnsnames.ora file:


<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/12-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/13-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/14-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/15-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/16-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/17-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/18-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/19-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/20-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>



Connection parameter you could see on database server in tnsnames.ora file

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/21-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/22-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/23-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/24-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/25-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/26-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/27-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/28-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/29-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/30-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/31-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/32-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/33-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>


<br/>

### Result should be like


<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/34-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/35-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>


    ORCL12 =
      (DESCRIPTION =
        (ADDRESS_LIST =
          (ADDRESS = (PROTOCOL = TCP)(HOST = oracle12.localdomain)(PORT = 1521))
        )
        (CONNECT_DATA =
          (SERVICE_NAME = orcl12.localdomain)
        )
      )

<br/>

### Check


    C:\> tnsping oracl12


system - login  
manager - password  

    C:\>sqlplus /nolog  
    SQL> conn system/manager@oracle12

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/36-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/37-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/38-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>


<br/>

### Edit Oracle Enviromnet Variables in windows reestr

I replace AMERICAN_AMERICA.WE8MSWIN1252 on AMERICAN_AMERICA.AL32UTF8



<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/39-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/40-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/41-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>



<br/>

### Trying connect to database server by PL/SQL Developer


<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/42-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/43-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/44-oracle_client_12_installation_on_windows_7.png" border="0" alt="Oracle Client 12C (32 bit) Installation on Windows 7 (64 bit)">
</div>
