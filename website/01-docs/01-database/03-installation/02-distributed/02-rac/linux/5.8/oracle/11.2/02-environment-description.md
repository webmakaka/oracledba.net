---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Environment description for Oracle RAC installation
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Environment description for Oracle RAC installation
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Environment description for Oracle RAC installation
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/environment-description/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Environment description for Oracle RAC installation

<br/>

RAC looks approximately like this:

<div align="center">
<img src="https://img.oracledba.net/img/oracle/database/rac/11.2/OracleRac_11.2.jpg" alt="oracle rac" border="0">
</div>

<br/><br/>

<hr>
<br/><br/>

This document provides an example deployment of <strong>Oracle Real Application Cluster 11.2 </strong> using 4 virtualbox virtual machines created "approximately" as follows:<br/>
https://docs.google.com/document/d/1ZU6Hk5DYitFYwlRFqN2qmJr6maPpvgsVc6ZTiZ1kYVA/edit

<br/><br/>
<br/><br/>

<div align="center">
	<img src="https://img.oracledba.net/img/oracle/database/rac/11.2/rac1.png" alt="oracle rac" border="0">
</div>

<br/><br/>

<ul>
<li>2 virtual machines are used as cluster nodes. Oracle software is installed on them: Oracle Grid and Oracle Database Software</li>
<li>1 virtual machine that acts as a data storage, whose disks are mounted via iSCSI on the cluster nodes.</li>
<li>1 virtual machine is used as a DNS server.</li>
</ul>

<br/><br/>
Each cluster node has 4 GB of RAM and 3 network adapters:<br/>
Oracle Linux 5.8 is chosen as the operating system.
<br/><br/>

<ul>
	<li>eth0 – public</li>
	<li>eth1 – interconnect (for communication between cluster nodes)</li>
	<li>eth2 – private (for cluster node communication with external storage)</li>
</ul>

<br/><br/>
<strong>For RAC installation, it is necessary to allocate IP addresses in one subnet:</strong>
<br/><br/>

<ul>
	<li>1 public IP for each node (just to connect to the server and perform administrative tasks)</li>
	<li>1 vip IP for each node ((in the same subnet as public) preferably vip should be defined in DNS)</li>
	<li>3 IP addresses for SCAN ((in the same subnet as public) must be defined in DNS (otherwise errors will occur during installation). The client connects to the SCAN address, which redirects the request to the vip address on the cluster node)</li>
</ul>
