---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Creating Directory Structure and Setting Necessary Permissions
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Creating Directory Structure and Setting Necessary Permissions
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Creating Directory Structure and Setting Necessary Permissions
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/create-folder-structure-and-user-permissions/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Creating Directory Structure and Setting Necessary Permissions

    # mkdir -p /u01/oracle/database/11.2
    # chown -R oracle11:dba /u01/oracle
    # chmod -R 775 /u01/oracle/database/11.2


    # mkdir -p /u01/oraInventory
    # chown -R oracle11:oinstall /u01/oraInventory
    # chmod -R 775 /u01/oraInventory


    # mkdir -p /u02/oradata
    # chown -R oracle11:oinstall /u02/oradata
    # chmod -R 775 /u02/oradata

    # mkdir -p /u03/oradata
    # chown -R oracle11:oinstall /u03/oradata
    # chmod -R 775 /u03/oradata


    # mkdir -p /u03/orabackups
    # chown -R oracle11:oinstall /u03/orabackups
    # chmod -R 775 /u03/orabackups

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
