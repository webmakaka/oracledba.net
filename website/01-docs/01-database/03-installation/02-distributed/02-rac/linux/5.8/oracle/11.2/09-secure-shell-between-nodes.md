---
layout: page
title: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Configuring Secure Shell between cluster nodes
description: Oracle RAC 11.2 Installation on Oracle Linux 5.8 (ISCSI + ASM) - Configuring Secure Shell between cluster nodes
keywords: database, installation, distributed, rac, linux, 5.8, oracle, 11.2, Configuring Secure Shell between cluster nodes
permalink: /database/installation/distributed/rac/linux/5.8/oracle/11.2/secure-shell-between-nodes/
---

# <a href="/database/installation/distributed/rac/linux/5.8/oracle/11.2/">[Oracle RAC 11.2 Installation on Oracle Linux 5.8 x86_64]</a>: Configuring Secure Shell between cluster nodes

<br/>

The cluster nodes need to be able to communicate via ssh.
When Oracle RAC is installed, it is only installed on the first node,
it is simply copied to all the others.

### Configuring secure shell (ssh)

node1

    # su - oracle11

<br/>

    $ mkdir ~/.ssh
    $ chmod 700 ~/.ssh

Create RSA-type public and private encryption keys. (Just press Enter for all questions)

    $ /usr/bin/ssh-keygen -t rsa

Create DSA-type public and private encryption keys. (Press Enter for all questions)

    $ /usr/bin/ssh-keygen -t dsa

<br/>

    $ cd .ssh/

Add the obtained keys to the authorized key file.

    $ cat id_rsa.pub >>authorized_keys
    $ cat id_dsa.pub >>authorized_keys

<br/>

    $ ssh node2 mkdir /home/oracle11/.ssh/

<br/>

    $ scp authorized_keys node2:/home/oracle11/.ssh

<br/>

    $ ssh node2

Repeat the generation procedure

    $ /usr/bin/ssh-keygen -t rsa
    $ /usr/bin/ssh-keygen -t dsa

<br/>

    $ cd ~/.ssh
    $ cat id_rsa.pub >> authorized_keys
    $ cat id_dsa.pub >> authorized_keys

<br/>

    $ chmod 644 authorized_keys

<br/>

    $ scp authorized_keys node1:/home/oracle11/.ssh

<br/>

    $ ssh node1

<br/>

    $ exec /usr/bin/ssh-agent $SHELL
    $ /usr/bin/ssh-add

Check that everything is working. Try all possible connection options between nodes without entering credentials.

    $ ssh node1 date
    $ ssh node2 date

<br/>

    $ ssh node1.localdomain date
    $ ssh node2.localdomain date

<br/>

    $ ssh node2

<br/>

    $ ssh node1 date
    $ ssh node2 date

<br/>

    $ ssh node1.localdomain date
    $ ssh node2.localdomain date
