---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Installing Mandatory Packages
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Installing Mandatory Packages
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Installing Mandatory Packages
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/install-mandatory-packages/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Installing Mandatory Packages

<br/>

The Oracle database requires that some components be installed in the system. Packages can be downloaded from a public repository (from the internet) or taken from the disk where the operating system distribution is located.

<strong>I must note that actually, the server should not have internet access!</strong> To install packages, you need to set up a local repository and get the necessary packages from it. Moreover, ideally, there should be no unnecessary packages on the server.

<br/>

**Installing packages from Oracle Linux repository on the internet:**

This step should be performed if the file system does not have a file describing where Oracle Linux should get the necessary packages. If installing from start to finish according to this instruction, it does not need to be performed.

    # vi /etc/yum.repos.d/oracleLinuxRepoINTERNET.repo

<br/>

    [OEL_INTERNET]
    name=Oracle Enterprise Linux $releasever - $basearch
    baseurl=http://public-yum.oracle.com/repo/OracleLinux/OL7/latest/$basearch/
    gpgkey=http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol7
    gpgcheck=1
    enabled=1

<br/>

    # yum repolist

<br/>

### Updating packages

    # yum update -y

<br/>

The following packages must be installed: (http://docs.oracle.com/cd/E16655_01/install.121/e17718/toc.htm#BABGGEBA)

binutils-2.20.51.0.2-5.11.el6 (x86_64)<br/>
compat-libcap1-1.10-1 (x86_64)<br/>
compat-libstdc++-33-3.2.3-69.el6 (x86_64)<br/>
compat-libstdc++-33-3.2.3-69.el6.i686<br/>
gcc-4.4.4-13.el6 (x86_64)<br/>
gcc-c++-4.4.4-13.el6 (x86_64)<br/>
glibc-2.12-1.7.el6 (i686)<br/>
glibc-2.12-1.7.el6 (x86_64)<br/>
glibc-devel-2.12-1.7.el6 (x86_64)<br/>
glibc-devel-2.12-1.7.el6.i686<br/>
ksh<br/>
libgcc-4.4.4-13.el6 (i686)<br/>
libgcc-4.4.4-13.el6 (x86_64)<br/>
libstdc++-4.4.4-13.el6 (x86_64)<br/>
libstdc++-4.4.4-13.el6.i686<br/>
libstdc++-devel-4.4.4-13.el6 (x86_64)<br/>
libstdc++-devel-4.4.4-13.el6.i686<br/>
libaio-0.3.107-10.el6 (x86_64)<br/>
libaio-0.3.107-10.el6.i686<br/>
libaio-devel-0.3.107-10.el6 (x86_64)<br/>
libaio-devel-0.3.107-10.el6.i686<br/>
make-3.81-19.el6<br/>
sysstat-9.0.4-11.el6 (x86_64)<br/>

<br/><br/>

View packages in the repository with the following command:

    # yum search all binutils

<br/>

Install all necessary packages with one command:

    # yum install -y \
    binutils.x86_64 \
    compat-libcap1.x86_64 \
    compat-libstdc++-33.i686 \
    compat-libstdc++-33.x86_64 \
    gcc.x86_64 \
    gcc-c++.x86_64 \
    glibc.i686 \
    glibc.x86_64 \
    glibc-devel.i686 \
    glibc-devel.x86_64 \
    ksh.x86_64 \
    libgcc.i686 \
    libgcc.x86_64 \
    libstdc++.i686 \
    libstdc++.x86_64 \
    libstdc++-devel.i686 \
    libstdc++-devel.x86_64 \
    libaio.i686 \
    libaio.x86_64 \
    libaio-devel.i686 \
    libaio-devel.x86_64 \
    make.x86_64 \
    sysstat.x86_64

<br/>

For version 12.2, the following package is now also required:

    # yum install -y smartmontools

<br/>

The following package is needed to start the graphical console

    # yum install -y \
    xdpyinfo

<br/>

Additional packages that are not necessary for database installation:

    # yum install -y \
    vim \
    wget \
    xinetd \
    screen \
    ntp \
    unzip

<br/>

### Installing rlwrap

rlwrap is a package that allows you to store command history in SQL\*PLUS and RMAN in Linux (it must be specified as a separate line in the bash profile). By installing this package, you will be able to use the up and down arrow keys to view command history, proper backspace functionality, etc.

    # yum install -y \
    readline-devel.x86_64

<br/>

    # yum install -y git
    # cd /tmp
    # git clone --depth=1 https://github.com/hanslub42/rlwrap

    # cd rlwrap/

<br/>

    # yum install -y gcc
    # yum install -y automake
    # autoreconf --install
    # automake  --add-missing
    # ./configure
    # make && make check && make install
