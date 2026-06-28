---
layout: page
title: Copying password file from primary to standby
description: Copying password file from primary to standby
keywords: Oracle DataBase 12.1, Centos 6.7, DataGuard
permalink: /database/installation/distributed/dataguard/linux/6.7/oracle/12.1/copy-passwords-file/
---

# [Oracle Active DataGuard 12.1 Installation on Centos 6.7]: Copying password file from primary to standby

### On Primary

**Passwordfile**

    SQL> show parameter remote_login_passwordfile

    NAME				     TYPE	 VALUE
    ------------------------------------ ----------- ------------------------------
    remote_login_passwordfile	     string	 EXCLUSIVE

<br/>

    SQL> select * from v$pwfile_users;

    USERNAME		       SYSDB SYSOP SYSAS SYSBA SYSDG SYSKM     CON_ID
    ------------------------------ ----- ----- ----- ----- ----- ----- ----------
    SYS			       TRUE  TRUE  FALSE FALSE FALSE FALSE	    0
    SYSDG			       FALSE FALSE FALSE FALSE TRUE  FALSE	    0
    SYSBACKUP		       FALSE FALSE FALSE TRUE  FALSE FALSE	    0
    SYSKM			       FALSE FALSE FALSE FALSE FALSE TRUE	    0

<br/>

    $ chmod 4640 $ORACLE_HOME/dbs/orapw${ORACLE_SID}

<br/>

// The password file can be created with the following command. Entries - limits the maximum number of connections to the database (if I'm not mistaken). I did not create a new password file.

    $ orapwd fiel=$ORACLE_HOME/dbs/orapw${ORACLE_SID} password=oracle12 entries=5

Copying the password file

    $ scp $ORACLE_HOME/dbs/orapw${ORACLE_SID} oracle12@piter:$ORACLE_HOME/dbs/

<br/>

### Standby

    $ chmod 4640 $ORACLE_HOME/dbs/orapw${ORACLE_SID}
