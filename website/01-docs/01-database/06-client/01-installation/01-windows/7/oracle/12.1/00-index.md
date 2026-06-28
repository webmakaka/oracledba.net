---
layout: page
title: Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)
description: Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)
keywords: Oracle Database, Oracle Client, Installation, Windows 7, PL/SQL Developer Installation
permalink: /client/installation/windows/7/oracle/12.1/
---

# [Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)]

If you find errors, inaccuracies, typos, or know better ways, <a href="/chat/">write to the chat</a>.

<br/>

Oracle Client is needed for remote connection to the database by various programs. Programs written in Java - so-called (thin clients) can do without a client. For example, SQL Developer and JDeveloper. This also applies to web applications that are run directly on the server, such as APEX, Enterprise Manager, iSQLPLUS.

For connecting other programs - TOAD, PL/SQL Developer, SQL PLUS and most others, the oci.dll (oracle call interface) library is required, which actually provides this capability and is of course included in the set of various additional programs united under the common name Oracle Client.

You can download the Oracle Client distribution from rutracker or a later version from the official website. If you have access to MetaLink, it is recommended to download the latest version from there.

Oracle client for Windows  
hxxp://rutracker.org/forum/viewtopic.php?t=4803357

For client installation, 1 archive is enough  
winnt_12102_client32.zip

**You can of course install the 64-bit client and sqlplus will work fine with it. However, PL/SQL Developer currently only works with the 32-bit client, so that is described below**

**UPD. PL/SQL Developer version 14.0.1 works with the 64-bit client.**

<br/>

### Environment preparation

First, you need to install 1 library on Windows 2008. Without it, the installation of the 32-bit client will fail. The 64-bit client does not require this library.

https://www.microsoft.com/en-gb/download/details.aspx?id=5555

<br/>

**hosts**

Edit the hosts file so that you don't have to access the database server by its IP

The hosts file should be edited, for example, in notepad running under an account with administrator rights.

C:\WINDOWS\system32\drivers\etc\hosts

    127.0.0.1   	localhost
    192.168.1.11	oracle12.localdomain oracle12

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/01-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/02-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/>

### Installation of Oracle Client

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/03-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/04-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/05-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/06-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/07-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/08-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

You only really need Oracle Call Interface. But for ease of setup and operation, I personally install 3 components:

<ul>
<li>SQL Plus</li>
<li>Oracle Call Interface (OCI)</li>
<li>Connection Manager</li>
</ul>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/09-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/10-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/11-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/>

### Generating configuration in the wizard for connecting to the database:

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/12-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/13-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/14-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/15-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/16-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/17-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/18-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/19-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/20-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

Connection parameters can be viewed on the server in the tnsnames.ora file

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/21-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/22-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/23-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/24-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/25-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/26-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/27-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/28-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/29-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/30-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/31-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/32-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/33-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/>

### As a result, libraries are installed and a tnsnames.ora file is generated

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/34-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/35-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
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

### Verification

    C:\> tnsping oracl12

system - login  
manager - password

    C:\>sqlplus /nolog
    SQL> conn system/manager@oracle12

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/36-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/37-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/38-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/>

### Oracle variables in registry

Instead of AMERICAN_AMERICA.WE8MSWIN1252 I set AMERICAN_AMERICA.AL32UTF8

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/39-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/40-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/41-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/>

### Connecting to the database using PL/SQL Developer

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/42-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/43-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>

<br/><br/>

<div>
	<img src="https://img.oracledba.net/02-client/installation/windows/7/oracle/12.1/44-oracle_client_12_installation_on_windows_7.png" border="0" alt="Installation of Oracle Client 12C (32 bit) on Windows 7 (64 bit)">
</div>
