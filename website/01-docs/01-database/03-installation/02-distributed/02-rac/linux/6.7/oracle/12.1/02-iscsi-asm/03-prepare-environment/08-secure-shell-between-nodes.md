---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Secure Shell configuration between cluster nodes
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Secure Shell configuration between cluster nodes
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/distributed/rac/linux/6.7/oracle/12.1/iscsi-asm/secure-shell-between-nodes/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Secure Shell configuration between cluster nodes

<br/>

The cluster nodes need to be able to communicate with each other via ssh.
When Oracle RAC is installed, it is only installed on the first node,
on all other nodes it is simply copied.

### Configuring secure shell (ssh)

<table cellpadding="4" cellspacing="2" align="center" border="0" width="100%">

<tr>
<td style="color: rgb(255, 255, 255);" bgcolor="#386351" width="14%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>Server:</strong></span></td>
<td height="20" bgcolor="#a2bcb1" width="60%"><span style="font-family: Arial,Helvetica,sans-serif; font-size: 14px;"><strong>rac1</strong></span></td>
</tr>

</table>

    # su - oracle12

<br/>

    $ mkdir ~/.ssh
    $ chmod 700 ~/.ssh

Create RSA-type public and private encryption keys. (Press Enter for all questions)

    $ /usr/bin/ssh-keygen -t rsa

Create DSA-type public and private encryption keys. (Press Enter for all questions)

    $ /usr/bin/ssh-keygen -t dsa

<br/>

    $ cd .ssh/

Add the obtained keys to the authorized keys file.

    $ cat id_rsa.pub >>authorized_keys
    $ cat id_dsa.pub >>authorized_keys

<br/>

    $ ssh rac2 mkdir /home/oracle12/.ssh/

<br/>

    $ scp authorized_keys rac2:/home/oracle12/.ssh

<br/>

    $ ssh rac2

Repeat the key generation procedure

    $ /usr/bin/ssh-keygen -t rsa
    $ /usr/bin/ssh-keygen -t dsa

<br/>

    $ cd ~/.ssh
    $ cat id_rsa.pub >> authorized_keys
    $ cat id_dsa.pub >> authorized_keys

<br/>

    $ chmod 644 authorized_keys

<br/>

    $ scp authorized_keys rac1:/home/oracle12/.ssh

<br/>

    $ ssh rac1

<br/>

    $ exec /usr/bin/ssh-agent $SHELL
    $ /usr/bin/ssh-add

Check that everything is working correctly. Try all possible connection options between nodes without entering credentials.

    $ ssh rac1 date
    $ ssh rac2 date

<br/>

    $ ssh rac1.localdomain date
    $ ssh rac2.localdomain date

<br/>

    $ ssh rac2

<br/>

    $ ssh rac1 date
    $ ssh rac2 date

<br/>

    $ ssh rac1.localdomain date
    $ ssh rac2.localdomain date

<br/>

    $ ssh rac1
