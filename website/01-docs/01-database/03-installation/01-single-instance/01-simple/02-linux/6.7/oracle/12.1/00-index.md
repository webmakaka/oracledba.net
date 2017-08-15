---
layout: page
title: Oracle DataBase Server 12.1 installation on Oracle Linux 6.7
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/
---


# [Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]


<br/>

In this document we will describe installation process for Oracle Database in Oracle Linux.  
For installation we won't use GUI on server.

To correct anything, please write mail to:

<div>
	<img src="http://img.fotografii.org/a3333333mail.gif" alt="Marley" border="0">
</div>

<br/>

<strong>We will use next Distributives:</strong>

<ul>
	<li>Oracle Linux - 6.7</li>
	<li>Oracle DataBase - 12.1</li>
</ul>

<br/>

<br/><br/>
<h2>Official Doccumentation:</h2>

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/docs/">Official Doccumentation</a><br/></li>
</ul>



<h2>Distributives:</h2>


<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/distrib/">Distributives and additional software for Orace database installation</a><br/></li>
</ul>


## Creating virtual machine for Oracle Database:


<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/virtual-machine/">Creating virtual machine for Oracle Database</a><br/></li>
</ul>


## Oracle Linux 6.7 Installation:


<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oel67-installation/">Oracle Linux 6.7 Installation</a><br/></li>
</ul>



<br/><br/>

## Prepare Oracle Linux for Orace database installation:


<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/network-interfaces/">Setup network interfaces</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-os-parameters-before-we-start/">Setup OS parameters before we start</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/install-mandatory-packages/">Install mandatory packages</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-actual-time/">Setup actual time</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/prepare-hdd-to-install-oracle/">Prepare hard disk drives</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/prepare-kernel-parameters-and-user-environments/">Configure system users and kernel parameters</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/autostart-only-packages-what-needed/">Autostart only packages what nedeed</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/create-folder-structure-and-user-permissions/">Creating folder structure for Oracle</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/setup-display-manager/">Setup Display Manger</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/copy-oracle-distrib-on-server/">Copy oracle distributives on server</a></li>

</ul>


<br/><br/>

## Oracle Database Installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-database-software-installation/">Oracle DataBase SoftWare Installation</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-listener-creation/">Create service for remote connection to Oracle (Listener)</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-instance-creation/">Oracle instance creation</a></li>
</ul>


<br/><br/>

## Steps after Oracle Database installation:

<ul>
	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/autorstart-oracle-after-restart/">Setup autostart Oracle after reboot</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-setup-fast-recovery-area-params/">Setup FAST RECOVERY AREA parameters</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-cold-backup/">Create a cold backup</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-restrict-root-access/">Restrict remote access by user root</a></li>

</ul>


<br/><br/>

## Provide additional reliability:

<ul>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/controlfiles-multiplexing/">Controlfiles multiplexing</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/redologs-multiplexing/">Redologs multiplexing</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/enable-archivelog-mod/">Enable ARCHIVELOG MODE</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/archivelogs-multiplexing/">Archivelog miltiplexing</a></li>


	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-change-default-datafile-location/">Change default datafile location</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-additionals-datafiles/">Extending tablespace (creating additional datafiles for tablespaceses)</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/enable-flashback-mod/">Enable FLASH BACK mode</a></li>

	<li><a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/oracle-final-hot-backup/">Final hot backup</a></li>
</ul>


<br/><br/>
<h2>Connect to Database Server from PC:</h2>

<ul>

	<li><a href="/client/installation/windows/7/oracle/12.1/">Installation Oracle Client 12C (32 bit) on Windows 7 (64 bit)</a></li>

</ul>
