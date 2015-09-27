---
layout: page
title: Oracle DataBase 12c - Linux - Install mandatory packages
permalink: /database/installation/single-instance/simple/linux/6.7/oracle/12.1/install-mandatory-packages/
---

# <a href="/database/installation/single-instance/simple/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7]</a>: Install mandatory packages



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



<br/>
<h3>Install mandatory packages</h3>


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


Next package need to start GUI form on remote host

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



<br/>

<h3>Install rlwrap</h3>

rlwrap - needs to work with arrow in sqlplus and rman:


	# yum install -y \
	readline-devel.x86_64

<br/>

	# cd /tmp
	# wget http://utopia.knoware.nl/~hlub/uck/rlwrap/rlwrap-0.37.tar.gz

<br/>

	# tar zxvf rlwrap-0.37.tar.gz
	# cd rlwrap-0.37
	# ./configure
	# make && make check && make install
