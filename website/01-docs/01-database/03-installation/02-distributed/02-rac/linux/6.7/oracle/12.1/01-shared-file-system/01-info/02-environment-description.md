---
layout: page
title: Oracle RAC 12.1 SHARED FILE SYSTEM - Environment description for Oracle RAC installation
description: Oracle RAC 12.1 SHARED FILE SYSTEM - Environment description for Oracle RAC installation
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, SHARED FILE SYSTEM
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/shared-file-system/environment-description/
---

# [Oracle RAC 12.1 SHARED FILE SYSTEM Installation]: Environment description for Oracle RAC installation

<br/>

RAC looks approximately like this:

<div align="center">
<img src="https://img.oracledba.net/img/oracle/database/rac/11.2/OracleRac_11.2.jpg" alt="oracle rac" border="0">
</div>

<br/><br/>

<hr>
<br/><br/>

This document provides an example of deploying <strong>Oracle Real Application Cluster 12.1</strong> using 4 virtualbox virtual machines.

<br/><br/>

<ul>
<li>Cluster nodes: rac1, rac2</li>
<li>Shared storage server: storage </li>
<li>DNS server: dnsserv</li>
</ul>

<br/><br/>

<div align="center">
	<img src="https://img.oracledba.net/img/oracle/database/rac/11.2/rac1.png" alt="oracle rac" border="0">
</div>

<br/><br/>

<ul>
<li>2 virtual machines are used as cluster nodes. They will have Oracle software installed: Oracle Grid and Oracle Database Software</li>
<li>1 virtual machine acting as a data storage, whose disks are mounted in the cluster nodes' file system via Network File System (NFS) protocol. </li>
<li>1 virtual machine used as a DNS server. SCAN addresses must be registered in DNS. Otherwise, errors may occur or it may not be possible to install RAC correctly.</li>
</ul>

Oracle Linux 6.7 is used as the operating system on the virtual machines

Each cluster node has 4.5 GB (minimum 2 GB) of RAM. Storage and DNS server can have significantly less.

Each cluster node has 2 hard disks of 40 GB, storage has 8 disks, also 40 GB each. Disks are expandable as needed. I.e., they actually take less space if the specified volume is not used.<br/>

Each cluster node has 3 network adapters. Storage needs 2 network adapters, DNS server needs 1.

<ul>
<li>eth0 – public</li>
<li>eth1 – interconnect (for communication between cluster nodes)</li>
<li>eth2 – private (for cluster nodes communication with external storage)</li>
</ul>

<br/><br/>
<strong>For RAC installation, you need to allocate IP addresses in one subnet:</strong>
<br/><br/>

<ul>
<li>1 public IP for each node (just to connect to the server and perform administration tasks)</li>
<li>1 vip IP for each node ((in the same subnet as public) it's desirable that vips are registered in DNS)</li>
<li>3 IP addresses for SCAN ((in the same subnet as public) must be registered in DNS (otherwise errors will occur during installation). The client connects to the SCAN address, which redirects the request to the vip address on the cluster node)</li>
</ul>
