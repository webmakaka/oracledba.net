---
layout: page
title: Oracle Active DataGuard 12.1 Installation on Centos 6.7
description: Oracle Active DataGuard 12.1 Installation on Centos 6.7
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/
---

# Oracle Active DataGuard 12.1 Installation on Centos 6.7

### Beta version of the document. Needs to be tested on real servers! If anyone follows this version of the document, please report back on what works, what needs fixing.

<br/>

Oracle Data Guard technology provides a solution for high availability, increased performance, and automatic disaster recovery.

Changes in the primary database can be transmitted to standby databases with a guarantee of no data loss during the transfer.

Two types of standby databases are supported - physical and logical standby.

A physical standby database contains the same structures as the primary database. A logical standby database may have different internal structures (e.g., additional indexes used for report generation). Synchronization of the primary database with standby databases is accomplished by transferring log data through SQL statements executed on the standby database.

A physical standby database is a block-level copy of the primary database. During disaster recovery, the standby database is exactly identical to the primary database.

A logical standby database is used for report generation (which requires significant system resources). In this case, the standby database is opened read-only and users who need to generate reports work with it. Meanwhile, the primary database continues to receive data from operators.

<br/>

I don't have an environment where I constantly work with DataGuard. Here I will try to configure it. I will update it as I gain new knowledge.

If you find errors, inaccuracies, typos, or know better approaches, <a href="/chat/">write in the chat or email</a>.

<br/>

**And yes, I haven't read the DataGuard Concepts Guide yet and don't plan to in the near future. Nowhere I've worked has it been used, because it's expensive. When there are tasks, I'll start a more in-depth study right away.
Therefore, clarifications will be very useful.**

The essence of DataGuard for someone who hasn't read the Concepts Guide seems quite simple. You need 2 identical (or roughly identical) servers. One will handle routine tasks, the other will, for example, build reports that consume a lot of CPU time, memory, etc.

To do this, a copy of the primary server is made. The primary server shares archive logs with the standby, thus keeping the database up to date. If the first server crashes, they can be swapped.

You can also configure the server to work in failover mode and switchover mode (role switching between primary and standby instance).

DataGuard works in Enterprise configuration and requires GRID. The license cost will be higher than Standard. If so, it might be cheaper to deploy 2 Standard servers and feed archive logs from one to the other, for example using RSYNC.

A similar task can also be solved using Oracle Golden Gate. Perhaps the solution with Golden Gate would be better.

<br/>

<div style="padding:10px; border:thin solid black;">

<strong>For information:</strong>

<br/>

db_name - name of our database (same for primary and standby instance). <br/>

db_unique_name - this is a unique name for each instance, it does not change when switching roles from standby to production.

</div>

<br/>

## Preparing virtual machines and instances:

<ul>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/info-about-env/">Description of the system to be configured</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/prepare-env/">Preliminary steps for environment setup</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/prepare-instance/">Preliminary steps for configuring instance parameters</a></li>

</ul>

<br/>

## Preparing and creating DATAGUARD:

<ul>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/create-foder-structure-like-on-primary/">Creating directories on standby that exist on primary</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/copy-passwords-file/">Copying password file from primary to standby</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/startup-instance-on-standby/">Starting instance on standby</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/setup-oracle-network-services/">Configuring Oracle network services for creating a duplicate of primary on standby</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/setup-instance-parameters-to-work-in-dataguard/">Configuring instance parameters on primary for DataGuard configuration</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/standby-redologs-on-primary-instance/">Creating standby redologs on primary</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/rman-connection-check/">Checking RMAN connection to both Instances</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/run-rman-script-for-duplicate-instance/">Creating and executing RMAN script for duplicating primary</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/post-duplicate-steps-on-standby/">Configuring Instance parameters after creating the duplicate on standby</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/check-redo-apply/">Checking redo apply</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/queries/">Queries for obtaining DataGuard status information</a></li>

</ul>

<br/>

## Broker (DGMGRL)

<ul>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/broker/setup/">Installing the broker (DGMGRL)</a></li>


    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/broker/switchover-listener-config/">Reconfiguring Listener for Switchover</a></li>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/broker/switchover/">Switchover (role switching between primary and standby instance)</a></li>

</ul>

<br/>

## Backups

<ul>

    <li><a href="/database/installation/distributed/dataguard/linux/6.7/oracle/12.1/backups/">BACKUPs on DataGuard</a></li>

</ul>

<br/>
<br/>

**Related materials: (Sorted from more useful to less)**:

<ul>
	<!-- <li><a href="https://pierreforstmanndotcom.wordpress.com/2014/11/28/create-a-physical-standby-database-with-oracle-12-1-0-2-and-rman-active-duplication/" rel="nofollow">[ENG] Create a physical standby database with Oracle 12.1.0.2 and RMAN active duplication</a></li> -->

    <li><a href="https://habr.com/ru/post/120495/" rel="nofollow">[HabraHabr] Once again about Oracle standby</a></li>

    <li><a href="http://docs.oracle.com/cd/B19306_01/server.102/b14239/toc.htm" rel="nofollow">[ENG] Data Guard Concepts and Administration</a></li>

    <li><a href="http://docs.oracle.com/cd/B28359_01/server.111/b28294/rcmbackp.htm" rel="nofollow">[ENG] Creating a Standby Database with Active Database Duplication</a></li>

</ul>
