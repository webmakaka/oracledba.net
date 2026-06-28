---
layout: page
title: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Installing Mandatory Packages
description: Installing Oracle DataBase 11.2.0.3.2 on Oracle Linux 6.3 - Installing Mandatory Packages
keywords: Oracle DataBase 11.2, Oracle Linux 6.3, Installing Mandatory Packages
permalink: /database/installation/single-instance/simple/linux/6.3/oracle/11.2/install-mandatory-packages/
---

# <a href="/database/installation/single-instance/simple/linux/6.3/oracle/11.2/">[Installing Oracle DataBase Server 11.2.0.3 on Oracle Linux 6.3]</a>: Installing Mandatory Packages

The Oracle database requires that certain components are installed on the system. Packages can be downloaded from the public repository (from the internet) or taken from the disk that contains the operating system distribution.

<br/>

**Option 1: Installing packages from the Oracle Linux DVD (Not recommended):**

    # mkdir /mnt/cdrom
    # mount -t iso9660 -o ro /dev/cdrom /mnt/cdrom

<br/>

    # vi /etc/yum.repos.d/oracleLinuxRepoDVD.repo

<br/>

    [OEL63_DVD]
    name=Oracle Enterprise Linux DVD
    baseurl=file:///mnt/cdrom/Server/
    gpgcheck=0
    enabled=1

<br/>

**Option 2: Installing packages from the Oracle Linux repository on the internet:**

    # vi /etc/yum.repos.d/oracleLinuxRepoINTERNET.repo

<br/>

    [OEL_INTERNET]
    name=Oracle Enterprise Linux $releasever - $basearch
    baseurl=http://public-yum.oracle.com/repo/OracleLinux/OL6/latest/$basearch/
    gpgkey=http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol6
    gpgcheck=1
    enabled=1

<br/>

    # yum repolist
    # yum update -y

<br/><br/>

<div style="padding:10px; border:thin solid black;">

Offtopic: (Recommended to skip! Just for information)<br/><br/>

You can run the following command and skip most of the steps for installing required packages and properly configuring the environment for Oracle installation.<br/><br/>

    # yum install -y oracle-validated <br/><br/>

By running this command, Oracle will install all necessary packages, create the required users, and make changes to configuration files.

There is only one drawback: it might not do everything exactly as you want. That is, the environment will be prepared with "default" settings.

</div>

<br/><br/>

The following packages must be installed: <br/><br/>

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

The following package is needed to start the graphical console

    # yum install -y xdpyinfo

<br/>

Additional packages:

    # yum install -y \
    	mc \
    	nano \
    	vim \
    	emacs \
    	wget \
    	xinetd \
    	screen \
    	ntp \
    	unzip

rlwrap - a package that allows storing command history in SQL\*PLUS and RMAN on Linux (it must be added as a separate line in the bash profile). By installing this package, you can use the up and down arrow keys to browse command history, proper backspace operation, etc.

    # yum install -y \
    readline-devel.x86_64

<br/>

    # cd /tmp
    # wget http://utopia.knoware.nl/~hlub/uck/rlwrap/rlwrap-0.37.tar.gz

<br/>

If the above site does not work, the source code can be taken from here:

    https://github.com/hanslub42/rlwrap

<br/>

    # tar zxvf rlwrap-0.37.tar.gz
    # cd rlwrap-0.37
    # ./configure
    # make
    # make check
    # make instal

<br/><br/>
<br/><br/>

<div style="padding:10px; border:thin solid black;">

    <h3>I recommend going directly to the latest version of the document, which uses newer software versions</h3>

    <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">Link to the Oracle installation document.</a>

</div>
