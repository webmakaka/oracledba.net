---
layout: page
title: Installation of Oracle Instant Client 11.2 on Oracle Linux
description: Installation of Oracle Instant Client 11.2 on Oracle Linux
keywords: Oracle Database, Oracle Client, Installation, Linux
permalink: /database/installation/oracle-client-installation/linux/6.3/oracle/11.2/
---

# Installation of Oracle Instant Client 11.2 on Oracle Linux

<br/>

Distrib:<br/>
http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html

Info:<br/>
http://docs.oracle.com/cd/E11882_01/server.112/e16604/apd.htm

<br/>

**Required:**

<ul>
	<li>instantclient-basic-linux.x64-11.2.0.3.0.zip</li>
	<li>instantclient-sqlplus-linux.x64-11.2.0.3.0.zip</li>
</ul>

<br/>

Archives should be extracted into 1 directory.<br/>
Otherwise, the following message may appear:<br/>
SP2-0667: Message file sp1<lang>.msb not found<br/>

<br/>

```
# mkdir -p /u01/app/oracle/instantclient
```

<br/>

```
# unzip instantclient-basic-linux.x64-11.2.0.3.0.zip
# unzip instantclient-sqlplus-linux.x64-11.2.0.3.0.zip
# mv instantclient_11_2/ 11.2
# mv 11.2/ /u01/app/oracle/instantclient
```

<br/>

```
# chown -R oracle11 /u01/app/oracle/instantclient/
```

<br/>

```
# vi /etc/yum.repos.d/oracleLinuxRepoINTERNET.repo
```

<br/>

```
[OEL_INTERNET]
name=Oracle Enterprise Linux $releasever - $basearch
baseurl=http://public-yum.oracle.com/repo/OracleLinux/OL6/latest/$basearch/
gpgkey=http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol6
gpgcheck=1
enabled=1
```

<br/>

```
# yum install -y \
gcc \
make \
readline-devel.x86_64
```

<br/>

```
# yum install -y libaio-devel
```

<br/>

```
# cd /tmp
# wget http://utopia.knoware.nl/~hlub/uck/rlwrap/rlwrap-0.37.tar.gz
```

<br/>

If the above site does not work, the source can be obtained here:

```
https://github.com/hanslub42/rlwrap
```

<br/>

```
# tar zxvf rlwrap-0.37.tar.gz
# cd rlwrap-0.37
# ./configure
```

<br/>

```
# make && make check && make install
```

<br/>

If one specific user will work with sqlplus, these entries should be added to their profile.

```
# su - oracle11
```

<br/>

```
$ vi ~/.bash_profile
```

<br/>

```
#################################
## Oracle Instant Client

export SQLPATH=/u01/app/oracle/instantclient/11.2
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export TNS_ADMIN=${SQLPATH}
export LD_LIBRARY_PATH=${SQLPATH}
export PATH=${SQLPATH}:${PATH}

alias sqlplus='rlwrap sqlplus'
alias rman='rlwrap rman'

#################################
```

<br/>

```
$ source ~/.bash_profile
```

<br/>

```
# sqlplus /nolog
```

<br/>

```
SQL> conn system/system@oracle112:1521/ora112.localdomain
Connected.
```

<br/>

### Creating a tnsnames.ora file with database connection parameters

```
# vi /u01/app/oracle/instantclient/11.2/tnsnames.ora
```

<br/>

```
oracle11 =
    (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = oracle112.localdomain)(PORT = 1521))
    (CONNECT_DATA =
        (SERVER = DEDICATED)
        (SERVICE_NAME = ora112.localdomain)
    )
    )
```

<br/>

<code>oracle112.localdomain - DNS or HOSTS entry</code>

<br/>

```
# sqlplus /nolog
```

<br/>

```
SQL> conn system/system@oracle11
Connected.
```

<br/>

### [Installation of Oracle Instant Client on Debian / Ubuntu](https://web.archive.org/web/20230128040957/https://debianworld.ru/articles/ustanovka-oracle-instant-client-v-debian-ubuntu/)

<br/>

### Oracle instant client compatibility table with oracle databases as of 2024.04.18

<div align="center">
<img src="/img/instant-client-compatibility.png" border="0" alt="Oracle Instance"><br/>
</div>
