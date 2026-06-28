---
layout: page
title: Example of backing up an Oracle database using operating system tools (NOARCHIVELOG)
description: Example of backing up an Oracle database using operating system tools (NOARCHIVELOG)
keywords: Oracle Database, Backup using operating system tools
permalink: /database/backup-and-restore/copy/
---

# Example of backing up an Oracle database using operating system tools (NOARCHIVELOG)

**No one is recommended to do this!**

Need to start the database from copied files on some other server

It's all stupid - copying files individually. If the database is not in ASM, just copy all files to another server and change some parameters in configs. If with ASM, then RMAN.

    SQL> archive log list;
    Database log mode	       No Archive Mode
    Automatic archival	       Disabled
    Archive destination	       USE_DB_RECOVERY_FILE_DEST
    Oldest online log sequence     7
    Current log sequence	       9

If not, you can switch to NOARCHIVELOG mode with the following commands.

    SQL> shutdown immediate;
    SQL> startup mount;
    SQL> alter database noarchivelog;
    SQL> alter database open;

<br/>

    $ mkdir -p /tmp/backups/ORCL12/{DATAFILE,CONTROLFILE,PARAMETERFILE}

<br/>

    SQL> CREATE PFILE = '/tmp/backups/ORCL12/PARAMETERFILE/pfile.txt' from SPFILE;

<br/>

    SQL> ALTER DATABASE BACKUP CONTROLFILE TO TRACE as '/tmp/backups/ORCL12/CONTROLFILE/controlfile.txt';

<br/>

    $ rman target /

<br/>

    RMAN> report schema;

    using target database control file instead of recovery catalog
    Report of database schema for database with db_unique_name ORCL12

    List of Permanent Datafiles
    ===========================
    File Size(MB) Tablespace           RB segs Datafile Name
    ---- -------- -------------------- ------- ------------------------
    1    790      SYSTEM               YES     +DATA/ORCL12/DATAFILE/system.258.888429421
    3    650      SYSAUX               NO      +DATA/ORCL12/DATAFILE/sysaux.257.888429347
    4    135      UNDOTBS1             YES     +DATA/ORCL12/DATAFILE/undotbs1.260.888429497
    6    5        USERS                NO      +DATA/ORCL12/DATAFILE/users.259.888429497

    List of Temporary Files
    =======================
    File Size(MB) Tablespace           Maxsize(MB) Tempfile Name
    ---- -------- -------------------- ----------- --------------------
    1    197      TEMP                 32767       +DATA/ORCL12/TEMPFILE/temp.265.888429595

<br/>

### Creating a consistent backup.

    RMAN> shutdown immediate;

<br/>

    $ export ORACLE_HOME=$GRID_HOME
    $ export ORACLE_SID=+ASM

<br/>

    $ asmcmd ls +DATA/ORCL12/DATAFILE
    SYSAUX.257.888429347
    SYSTEM.258.888429421
    UNDOTBS1.260.888429497
    USERS.259.888429497

<br/>

    $ asmcmd ls +DATA/ORCL12/CONTROLFILE/
    Current.261.888429547

<br/>

    $ asmcmd ls +DATA/ORCL12/PARAMETERFILE
    spfile.266.888429941

<br/>

     $ asmcmd cp +DATA/ORCL12/DATAFILE/SYSAUX.257.888429347 /tmp/backups/ORCL12/DATAFILE
     $ asmcmd cp +DATA/ORCL12/DATAFILE/SYSTEM.258.888429421 /tmp/backups/ORCL12/DATAFILE
     $ asmcmd cp +DATA/ORCL12/DATAFILE/UNDOTBS1.260.888429497 /tmp/backups/ORCL12/DATAFILE
     $ asmcmd cp +DATA/ORCL12/DATAFILE/USERS.259.888429497 /tmp/backups/ORCL12/DATAFILE

<br/>

    $ asmcmd cp +DATA/ORCL12/CONTROLFILE/Current.261.888429547 /tmp/backups/ORCL12/CONTROLFILE

<br/>

     $ asmcmd cp +DATA/ORCL12/PARAMETERFILE/spfile.266.888429941 /tmp/backups/ORCL12/PARAMETERFILE

 <br/>

    $ cd /tmp/backups/
    $ tar -cvzpf ORCL12.tar.gz ./ORCL12

<br/>

### Restoring from backup

    $ ssh oracle12@piter "mkdir -p /tmp/backups/"
    $ scp ORCL12.tar.gz oracle12@192.168.1.12:/tmp/backups

Restoring on another server with the same instance:

    $ cd /tmp/backups/
    $ tar -xvzpf ORCL12.tar.gz ./

Now copying to ASM.

    $ export ORACLE_HOME=$GRID_HOME
    $ export ORACLE_SID=+ASM

<br/>

    $ asmcmd mkdir +DATA/ORCL12
    $ asmcmd mkdir +DATA/ORCL12/DATAFILE
    $ asmcmd mkdir +DATA/ORCL12/CONTROLFILE
    $ asmcmd mkdir +DATA/ORCL12/PARAMETERFILE
    $ asmcmd mkdir +DATA/ORCL12/ARCHIVELOG

<br/>

    $ asmcmd mkdir +ARCH/ORCL12/ARCHIVELOG

The cp command cannot copy files without numbers to ASM. You have to copy without them. Because of this, you will later have to recreate the controlfile.

    $ asmcmd cp /tmp/backups/ORCL12/DATAFILE/SYSAUX.257.888429347 +DATA/ORCL12/DATAFILE/SYSAUX
    $ asmcmd cp /tmp/backups/ORCL12/DATAFILE/SYSTEM.258.888429421 +DATA/ORCL12/DATAFILE/SYSTEM
    $ asmcmd cp /tmp/backups/ORCL12/DATAFILE/UNDOTBS1.260.888429497 +DATA/ORCL12/DATAFILE/UNDOTBS1
    $ asmcmd cp /tmp/backups/ORCL12/DATAFILE/USERS.259.888429497 +DATA/ORCL12/DATAFILE/USERS

<br/>

<!--

    $ asmcmd cp /tmp/backups/ORCL12/CONTROLFILE/Current.261.888345847 +DATA/ORCL12/CONTROLFILE/Current

<br/>

     $ asmcmd cp /tmp/backups/ORCL12/PARAMETERFILE/spfile.266.888346217 +DATA/ORCL12/PARAMETERFILE/spfile



$ asmcmd --privilege sysdba
ASMCMD> cd +DATA/DATAFILE
ASMCMD> mv SYSAUX SYSAUX.257.888345623


SYSAUX.257.888345623 +DATA/ORCL12/DATAFILE/SYSAUX
$ asmcmd cp /tmp/backups/ORCL12/DATAFILE/SYSTEM.258.888345709 +DATA/ORCL12/DATAFILE/SYSTEM
$ asmcmd cp /tmp/backups/ORCL12/DATAFILE/USERS.259.888345795 +DATA/ORCL12/DATAFILE/USERS

-->

Directory that must be created

    $ mkdir -p /u01/oracle/admin/ORCL12/adump

<br/>

    $ cd /tmp/backups/ORCL12/PARAMETERFILE/
    $ cp pfile.txt pfile.txt.bkp

<br/>

    $ vi pfile.txt

Removed lines related to controlfile:

    *.control_files='+DATA/ORCL12/CONTROLFILE/current.261.888429547','+ARCH/ORCL12/CONTROLFILE/current.256.888429547'

Result:

    ORCL12.__data_transfer_cache_size=0
    ORCL12.__db_cache_size=822083584
    ORCL12.__java_pool_size=16777216
    ORCL12.__large_pool_size=33554432
    ORCL12.__oracle_base='/u01/oracle'#ORACLE_BASE set from environment
    ORCL12.__pga_aggregate_target=402653184
    ORCL12.__sga_target=1207959552
    ORCL12.__shared_io_pool_size=50331648
    ORCL12.__shared_pool_size=268435456
    ORCL12.__streams_pool_size=0
    *.audit_file_dest='/u01/oracle/admin/ORCL12/adump'
    *.audit_trail='db'
    *.compatible='12.1.0.2.0'
    *.db_block_size=8192
    *.db_create_file_dest='+DATA'
    *.db_domain=''
    *.db_name='ORCL12'
    *.db_recovery_file_dest='+ARCH'
    *.db_recovery_file_dest_size=4560m
    *.diagnostic_dest='/u01/oracle'
    *.dispatchers='(PROTOCOL=TCP) (SERVICE=ORCL12XDB)'
    *.open_cursors=300
    *.pga_aggregate_target=382m
    *.processes=300
    *.remote_login_passwordfile='EXCLUSIVE'
    *.sga_target=1148m
    *.undo_tablespace='UNDOTBS1'

<br/>

    $ export ORACLE_HOME=/u01/oracle/database/12.1
    $ export ORACLE_SID=ORCL12

<br/>

    $ sqlplus / as sysdba

<br/>

    SQL> startup nomount pfile=/tmp/backups/ORCL12/PARAMETERFILE/pfile.txt

<br/>

    SQL> create spfile from memory;
    SQL> shutdown immediate;

<br/>

    $ cd /tmp/backups/ORCL12/CONTROLFILE
    $ cp controlfile.txt controlfile.txt.bkp
    $ vi controlfile.txt

Took the "RESETLOGS case" part of the code. Had to remove the numbers in the data file names. Executing in parts in the console:

    SQL> STARTUP NOMOUNT

<br/>

    SQL> CREATE CONTROLFILE REUSE DATABASE "ORCL12" RESETLOGS  NOARCHIVELOG
        MAXLOGFILES 16
        MAXLOGMEMBERS 3
        MAXDATAFILES 100
        MAXINSTANCES 8
        MAXLOGHISTORY 292
    LOGFILE
      GROUP 1 (
        '+DATA/ORCL12/ONLINELOG/group_1.262.888429551',
        '+ARCH/ORCL12/ONLINELOG/group_1.257.888429559'
      ) SIZE 50M BLOCKSIZE 512,
      GROUP 2 (
        '+DATA/ORCL12/ONLINELOG/group_2.263.888429563',
        '+ARCH/ORCL12/ONLINELOG/group_2.258.888429569'
      ) SIZE 50M BLOCKSIZE 512,
      GROUP 3 (
        '+DATA/ORCL12/ONLINELOG/group_3.264.888429575',
        '+ARCH/ORCL12/ONLINELOG/group_3.259.888429581'
      ) SIZE 50M BLOCKSIZE 512
    -- STANDBY LOGFILE
    DATAFILE
      '+DATA/ORCL12/DATAFILE/system',
      '+DATA/ORCL12/DATAFILE/sysaux',
      '+DATA/ORCL12/DATAFILE/undotbs1',
      '+DATA/ORCL12/DATAFILE/users'
    CHARACTER SET AL32UTF8
    ;

<br/>

    SQL> select status from v$instance;

    STATUS
    ------------
    MOUNTED

<br/>

    SQL> SELECT MEMBER FROM V$LOG G, V$LOGFILE F WHERE G.GROUP# = F.GROUP# AND G.STATUS = 'CURRENT';

    MEMBER
    --------------------------------------------------------------------------------
    +ARCH/ORCL12/ONLINELOG/group_3.259.888429581
    +DATA/ORCL12/ONLINELOG/group_3.264.888429575

<br/>

    SQL> RECOVER DATABASE USING BACKUP CONTROLFILE UNTIL CANCEL
    ORA-00279: change 1678308 generated at 08/22/2015 18:18:48 needed for thread 1
    ORA-00289: suggestion : +ARCH
    ORA-00280: change 1678308 for thread 1 is in sequence #9


    Specify log: {<RET>=suggested | filename | AUTO | CANCEL}

    ORA-00308: cannot open archived log '+ARCH'
    ORA-17503: ksfdopn:2 Failed to open file +ARCH
    ORA-15045: ASM file name '+ARCH' is not in reference form

Some website says you can ignore such errors. This database never worked in Archivelog mode. However, the database opened.

<br/>

    SQL> ALTER DATABASE OPEN RESETLOGS;
    Database altered.

<br/>

    SQL> ALTER TABLESPACE TEMP ADD TEMPFILE '+DATA/ORCL12/TEMPFILE/temp' SIZE 206569472  REUSE AUTOEXTEND ON NEXT 655360  MAXSIZE 32767M;

<br/>

    SQL> create spfile from memory;

<br/>

After all steps, you need to make a backup
