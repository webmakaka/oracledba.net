---
layout: page
title: Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID - ASMLIB Installation
permalink: /database/installation/single/asm/linux/6.7/oracle/12.1/asmlib-installation/
---

# <a href="/database/installation/single/asm/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID]</a>: ASMLIB Installation

<br/>


 <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/install-mandatory-packages/">Mandatory packages should be installed</a>


<br/><br/>

    # vi /etc/yum.repos.d/OracleLinuxRepo.repo

<br/>

    [OEL6]
    name=Oracle Enterprise Linux $releasever - $basearch
    baseurl=http://public-yum.oracle.com/repo/OracleLinux/OL6/latest/$basearch/
    gpgkey=http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol6
    gpgcheck=1
    enabled=1

<br/>

    # yum repolist

<br/>

### Additional packages needs for ASM:

    # yum install -y nfs-utils.x86_64


<br/>

### Next packages should be installed for ASM:

From Oracle website we need:

http://www.oracle.com/technetwork/server-storage/linux/asmlib/rhel6-1940776.html

Package: oracleasmlib-*.x86_64.rpm


    # cd /tmp
    # wget http://download.oracle.com/otn_software/asmlib/oracleasmlib-2.0.4-1.el6.x86_64.rpm

<br/>

    # yum install -y \
    oracleasm \
    oracleasm-support \
    oracleasmlib-2.0.4-1.el6.x86_64.rpm

<br/>

Check:

    # rpm -qa | grep oracleasm
